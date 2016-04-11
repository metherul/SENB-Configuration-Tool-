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
        public string[] skyrimFiles;
        public string[] skyrimDirectories;
        public string[] enbFileFilterArray;

        public string[] settingsArray;

        public List<string> matchingFiles;
        public List<string> matchingDirectories;

        public MainForm()
        {
            InitializeComponent();

            //ASSIGN VARIABLES
            SetVariables();

            //Set Form
            SKSELocation_TextBox.Text = Properties.Settings.Default["SKSELocation"].ToString();
            SkyrimLocation_TextBox.Text = Properties.Settings.Default["SkyrimLocation"].ToString();
        }

        private void savePreset_Button_Click(object sender, EventArgs e)
        {
            skyrimFiles = Directory.GetFiles(SkyrimLocation_TextBox.Text);
            enbFileFilterArray = File.ReadAllLines(enbFileFilter);

            presetFileName = savePreset_TextBox.Text;

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
                Directory.Delete(metaLocation + @"data\presets\" + presetFileName, true);

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

            //And finally, lets reset the variables
            SetVariables();
        }

        private void debugUI_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (debugUI_CheckBox.Checked)
                debug_TextBox.Visible = true;

            else if (!debugUI_CheckBox.Checked)
                debug_TextBox.Visible = false;
        }

        private void runSKSE_Button_Click(object sender, EventArgs e)
        {
            Process.Start(SKSELocation);
        }

        private void SKSELocation_TextBox_TextChanged(object sender, EventArgs e)
        {
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
            if (Directory.Exists(SkyrimLocation_TextBox.Text.Replace("\"", "")))
            {
                Properties.Settings.Default.SkyrimLocation = skyrimLocation;
                Properties.Settings.Default.Save();
            }
        }

        private void savePreset_TextBox_TextChanged(object sender, EventArgs e)
        {
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
            openFileDialog.Filter = "Application Files (.exe) | *.exe";

            DialogResult result = openFileDialog.ShowDialog();

            if (result == DialogResult.OK)
            {
                SKSELocation_TextBox.Text = openFileDialog.FileName;

            }
        }

        private void skyrimLocation_FileDialog_Click(object sender, EventArgs e)
        {
            DialogResult result = folderBrowserDialog.ShowDialog();

            if (result == DialogResult.OK)
            {
                SkyrimLocation_TextBox.Text = folderBrowserDialog.SelectedPath;

                skyrimLocation = SkyrimLocation_TextBox.Text;

                Properties.Settings.Default.SkyrimLocation = skyrimLocation;
                Properties.Settings.Default.Save();

            }
        }

        //----------------------------------------//

        public void SetVariables()
        {
            skyrimLocation = Properties.Settings.Default.SkyrimLocation.ToString();
            SKSELocation = Properties.Settings.Default.SKSELocation.ToString();

            metaLocation = AppDomain.CurrentDomain.BaseDirectory;
            enbFileFilter = metaLocation + @"data\EnbFiles.cfg";



            matchingFiles = new List<string>();
            matchingDirectories = new List<string>();
        }

        public void DeleteDirectory(string target_dir)
        {
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
            File.WriteAllLines(metaLocation + @"data\Settings.cfg", settingsArray);

            File.ReadAllLines(metaLocation + @"data\Settings.cfg");
        }
    }
}
