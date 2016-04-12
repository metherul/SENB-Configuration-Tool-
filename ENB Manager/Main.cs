using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using System.IO;
using System.Diagnostics;

using MaterialSkin;
using MaterialSkin.Controls;

namespace ENB_Manager
{
    public partial class MainForm : MaterialForm
    {
        //Skyrim variables 
        public string skyrimLocation;
        public string SKSELocation;

        //Meta variables
        public string metaLocation;
        public string enbFileFilter;
        public string presetFileName;

        //Storage variables
        public string item;

        public string[] skyrimFiles;
        public string[] skyrimDirectories;
        public string[] enbFileFilterArray;

        public string[] settingsArray;

        public string[] savedPresetsArray;

        public List<string> matchingFiles;
        public List<string> matchingDirectories;

        //UI 
        MaterialSkinManager materialSkinManager;

        //Entry point for the application
        public MainForm()
        {
            InitializeComponent();

            //ASSIGN VARIABLES
            SetVariables();

            //Set Form
            SKSELocation_TextBox.Text = Properties.Settings.Default["SKSELocation"].ToString();
            SkyrimLocation_TextBox.Text = Properties.Settings.Default["SkyrimLocation"].ToString();

            //UI
            materialSkinManager = MaterialSkinManager.Instance;

            installPreset_Button.Enabled = false;
            deletePreset_Button.Enabled = false;

            //Add values to the ComboBox
            savedPresetsArray = Directory.GetDirectories(metaLocation + @"data\presets\");
            savedPresets_ComboBox.Items.Add("");
            foreach (string preset in savedPresetsArray)
            {
                savedPresets_ComboBox.Items.Add(preset.Replace(metaLocation + @"data\presets\", ""));
            }

            foreach (string item in savedPresetsArray)
            {
                debug2_TextBox.AppendText("Presets Found: " + item.Replace(metaLocation + @"data\presets\", "") + Environment.NewLine);
            }

            debug2_TextBox.AppendText(Environment.NewLine);
        }

        private void savePreset_Button_Click(object sender, EventArgs e)
        {
            //Get the files located in the skyrim location
            //Read through the enbFileFilter to get filters
            //Then move them into a folder created after the preset value

            skyrimFiles = Directory.GetFiles(SkyrimLocation_TextBox.Text);
            enbFileFilterArray = File.ReadAllLines(enbFileFilter);

            presetFileName = savePreset_TextBox.Text;

            //Reset the debug text box
            debug_TextBox.Text = "";

            debug_TextBox.AppendText("Skyrim Location: " + skyrimLocation + Environment.NewLine);
            debug_TextBox.AppendText("SKSE Location: " + SKSELocation + Environment.NewLine);
            debug_TextBox.AppendText("Meta Location: " + metaLocation + Environment.NewLine);
            debug_TextBox.AppendText("ENB File Filter: " + enbFileFilter + Environment.NewLine);

            debug_TextBox.AppendText(Environment.NewLine);

            //Get files in Skyrim folder and add them to an array
            //skyrimFiles = Directory.GetFiles(skyrimLocation).Select(path => Path.GetFileName(path)).ToArray();

            //Read through Skyrim folder for ENB files
            AnalyseDirectory();

            //Now cut those files to an external file with the preset name
            //First, sure the presetFileName does not already exist. If it does, overwrite it
            if (Directory.Exists(metaLocation + @"data\presets\" + presetFileName))
            {
                Directory.Delete(metaLocation + @"data\presets\" + presetFileName, true);
                debug_TextBox.AppendText("Deleted Pre-Existing Directory: " + presetFileName + Environment.NewLine);
            }

            //Create preset file
            Directory.CreateDirectory(metaLocation + @"data\presets\" + presetFileName);

            //Move the files from the Skyrim file array stored in the array and move them into the preset folder
            foreach (string file in matchingFiles)
            {
                File.Move(file, metaLocation + @"data\presets\" + presetFileName + @"\" + file.Replace(skyrimLocation + @"\", ""));

                debug_TextBox.AppendText("File Moved: " + presetFileName + @"\" + file.Replace(skyrimLocation + @"\", "") + Environment.NewLine);
            }

            //Move the directories from the Skyrim directory stored in the array and move them into the preset folder
            foreach (string directory in matchingDirectories)
            {
                Directory.Move(directory, metaLocation + @"data\presets\" + presetFileName + @"\" + directory.Replace(skyrimLocation + @"\", ""));

                debug_TextBox.AppendText("Directory Moved: " + presetFileName + @"\" + directory.Replace(skyrimLocation + @"\", "") + Environment.NewLine);
            }

            //Then lets reset the variables
            SetVariables();

            //Finally, reset the ComboBox
            savedPresets_ComboBox.Items.Clear();

            savedPresetsArray = Directory.GetDirectories(metaLocation + @"data\presets\");
            savedPresets_ComboBox.Items.Add("");
            foreach (string preset in savedPresetsArray)
            {
                item = preset.Replace(metaLocation + @"data\presets\", "");

                savedPresets_ComboBox.Items.Add(preset.Replace(metaLocation + @"data\presets\", ""));
            }
        }

        private void installPreset_Button_Click(object sender, EventArgs e)
        {

        }

        private void debugUI_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            //Disables or enables based on whether or not debugUICheckBox is checked or not

            if (debugUI_CheckBox.Checked)
            {
                debug_TextBox.Visible = true;
                debug2_TextBox.Visible = true;
            }

            else if (!debugUI_CheckBox.Checked)
            {
                debug_TextBox.Visible = false;
                debug2_TextBox.Visible = false;
            }
        }

        private void runSKSE_Button_Click(object sender, EventArgs e)
        {
            //Runs SKSE or program mapped to the SKSE location variable

            Process.Start(SKSELocation);
        }

        private void SKSELocation_TextBox_TextChanged(object sender, EventArgs e)
        {
            //Checks to see if the SKSE text box value is a file that exists, as well as if it ends with .exe

            if (File.Exists(SKSELocation_TextBox.Text.Replace("\"", "")) && SKSELocation_TextBox.Text.EndsWith(".exe"))
            {
                runSKSE_Button.Enabled = true;
                SKSELocation = SKSELocation_TextBox.Text.Replace("\"", "");

                Properties.Settings.Default.SKSELocation = SKSELocation;
                Properties.Settings.Default.Save();
            }

            else
            {
                runSKSE_Button.Enabled = false;
                SKSELocation = null;
            }
        }

        private void SkyrimLocation_TextBox_TextChanged(object sender, EventArgs e)
        {
            //Check to see if the SkyrimLocation text box file exists, and if it does, save it in the settings

            if (Directory.Exists(SkyrimLocation_TextBox.Text.Replace("\"", "")))
            {
                savePreset_Button.Enabled = true;

                Properties.Settings.Default.SkyrimLocation = skyrimLocation;
                Properties.Settings.Default.Save();
            }

            else if (!Directory.Exists(SkyrimLocation_TextBox.Text.Replace("\"", "")))
            {
                savePreset_Button.Enabled = false;
            }
        }

        private void savePreset_TextBox_TextChanged(object sender, EventArgs e)
        {
            //Check to make sure the savePreset text box has text inside of it. If it does, enable the savePreset_Button

            if (!String.IsNullOrWhiteSpace(savePreset_TextBox.Text))
            {
                savePreset_Button.Enabled = true;
            }

            else
            {
                savePreset_Button.Enabled = false;
            }
        }

        private void SKSELocation_FileDialog_Click(object sender, EventArgs e)
        {
            //Set the filters for the OpenFileDialog WPF function, and then open it.
            //Saves the resulting path to the SKSELocation textbox, which is then checked by the text_changed function

            openFileDialog.Filter = "Application Files (.exe) | *.exe";

            DialogResult result = openFileDialog.ShowDialog();

            if (result == DialogResult.OK)
            {
                SKSELocation_TextBox.Text = openFileDialog.FileName;

            }
        }

        private void skyrimLocation_FileDialog_Click(object sender, EventArgs e)
        {
            //Opens up a FolderBrowserDialog and then sets the result to the SkyrimLocation_TextBox and saves it in the settings

            DialogResult result = folderBrowserDialog.ShowDialog();

            if (result == DialogResult.OK)
            {
                SkyrimLocation_TextBox.Text = folderBrowserDialog.SelectedPath;

                skyrimLocation = SkyrimLocation_TextBox.Text;

                //Not needed, this code is already executed when the text in the text box changes
                //Properties.Settings.Default.SkyrimLocation = skyrimLocation;
                //Properties.Settings.Default.Save();

            }
        }

        private void savedPresets_ComboBox_TextChanged(object sender, EventArgs e)
        {
            debug2_TextBox.AppendText(metaLocation + @"data\presets\" + savedPresets_ComboBox.Text + Environment.NewLine);

            if (savedPresetsArray.Contains(metaLocation + @"data\presets\" + savedPresets_ComboBox.Text))
            {
                installPreset_Button.Enabled = true;
                deletePreset_Button.Enabled = true;
            }

            else if (!savedPresetsArray.Contains(savedPresets_ComboBox.Text.Replace(metaLocation + @"data\preset\", "")))
            {
                installPreset_Button.Enabled = false;
                deletePreset_Button.Enabled = false;
            }
        }

        private void deletePreset_Button_Click(object sender, EventArgs e)
        {
            //Delete the selected file
            Directory.Delete(metaLocation + @"data\presets\" + savedPresets_ComboBox.Text, true);

            debug2_TextBox.AppendText("Deleted Preset: " + savedPresets_ComboBox.Text + Environment.NewLine);

            //Add values to the ComboBox
            savedPresets_ComboBox.Items.Clear();

            savedPresetsArray = Directory.GetDirectories(metaLocation + @"data\presets\");
            savedPresets_ComboBox.Items.Add("");
            foreach (string preset in savedPresetsArray)
            {
                savedPresets_ComboBox.Items.Add(preset.Replace(metaLocation + @"data\presets\", ""));
            }
        }

        //----------------------------------------//

        public void SetVariables()
        {
            //Inside this function so it can be used called at the end of the Save Preset action

            skyrimLocation = Properties.Settings.Default.SkyrimLocation.ToString();
            SKSELocation = Properties.Settings.Default.SKSELocation.ToString();

            metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            enbFileFilter = metaLocation + @"data\EnbFiles.cfg";



            matchingFiles = new List<string>();
            matchingDirectories = new List<string>();
        }

        public void DeleteDirectory(string target_dir)
        {
            //Not needed anymore, but I'll keep it around just in case. 

            string[] files = Directory.GetFiles(target_dir);
            string[] dirs = Directory.GetDirectories(target_dir);

            foreach (string file in files)
            {
                File.SetAttributes(file, FileAttributes.Normal);
                File.Delete(file);
            }

            foreach (string dir in dirs)
            {
                DeleteDirectory(dir);
            }

            Directory.Delete(target_dir, false);
        }

        public void AnalyseDirectory()
        {
            //--- THIS FUNCTION SCANS THE TOP "ROW" OF THE SKYRIM FOLDER LOOKING FOR ENB FILES ---//

            //Get the files for the first run
            skyrimDirectories = Directory.GetDirectories(skyrimLocation);
            skyrimFiles = Directory.GetFiles(skyrimLocation);

            //Run through the Skyrim Files array and check for any matching Files
            foreach (string file in skyrimFiles)
            {
                if (File.Exists(file))
                {
                    if (enbFileFilterArray.Contains(file.Replace(skyrimLocation + @"\", "")))
                    {
                        debug_TextBox.AppendText("File Found: " + file + Environment.NewLine);

                        matchingFiles.Add(file);
                    }
                }
            }

            //Run through the Skyrim Files array and check for any matching directories
            foreach (string directory in skyrimDirectories)
            {
                if (Directory.Exists(directory))
                {
                    if (enbFileFilterArray.Contains(directory.Replace(skyrimLocation + @"\", "")))
                    {
                        debug_TextBox.AppendText("Directory Found: " + directory + Environment.NewLine);

                        matchingDirectories.Add(directory);
                    }
                }
            }

            debug_TextBox.AppendText(Environment.NewLine);
        }

        public void ApplySettings()
        {
            //Not needed due to in-grained application settings

            File.WriteAllLines(metaLocation + @"data\Settings.cfg", settingsArray);

            File.ReadAllLines(metaLocation + @"data\Settings.cfg");
        }
    }
}
