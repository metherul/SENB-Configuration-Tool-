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

        public string presetToInstallName;

        //Storage variables
        public string item;

        public string[] skyrimFiles;
        public string[] skyrimDirectories;
        public string[] enbFileFilterArray;

        public string[] savedPresetsArray;

        public string[] presetFilesToInstall;
        public string[] presetDirectoriesToInstall;

        public List<string> matchingFiles;
        public List<string> matchingDirectories;

        public List<string> matchingPresetFiles;
        public List<string> matchingPresetDirectories;

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

            materialSkinManager.ColorScheme = new ColorScheme(Primary.Green800, Primary.Green900, Primary.Green500, Accent.LightGreen200, TextShade.WHITE);

            installPreset_Button.Enabled = false;
            deletePreset_Button.Enabled = false;

            //Set the label to the InstalledPreset value
            currentENB_Label.Text = "Installed Preset: " + Properties.Settings.Default["InstalledPreset"].ToString();

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

            //Check to see if the SkyrimLocation text box file exists, and if it does, save it in the settings
            if (Directory.Exists(SkyrimLocation_TextBox.Text.Replace("\"", "")))
            {
                savePreset_Button.Enabled = true;
                installPreset_Button.Enabled = true;

                uninstallENB_Button.Enabled = true;
                uninstallENB2_Button.Enabled = true;

                setNotification_Button.Visible = false;

                savedPresets_ComboBox.Enabled = true;

                Properties.Settings.Default.SkyrimLocation = SkyrimLocation_TextBox.Text;
                Properties.Settings.Default.Save();
            }

            else if (!Directory.Exists(SkyrimLocation_TextBox.Text.Replace("\"", "")))
            {
                savePreset_Button.Enabled = false;
                installPreset_Button.Enabled = false;

                uninstallENB_Button.Enabled = false;
                uninstallENB2_Button.Enabled = false;

                setNotification_Button.Visible = true;

                savedPresets_ComboBox.Enabled = false;

                Properties.Settings.Default.SkyrimLocation = SkyrimLocation_TextBox.Text;
                Properties.Settings.Default.Save();
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
                //Cannot move stuff across directories
                //Directory.Move(directory, metaLocation + @"data\presets\" + presetFileName + @"\" + directory.Replace(skyrimLocation + @"\", ""));
                DeepCopy(directory, metaLocation + @"data\presets\" + presetFileName + @"\" + directory.Replace(skyrimLocation + @"\", ""));

                Directory.Delete(directory, true);

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
            //Get the preset to install name
            presetToInstallName = savedPresets_ComboBox.Text;

            skyrimLocation = SkyrimLocation_TextBox.Text;

            //Get all the files in the preset directory
            presetFilesToInstall = Directory.GetFiles(metaLocation + @"data\presets\" + presetToInstallName);
            presetDirectoriesToInstall = Directory.GetDirectories(metaLocation + @"data\presets\" + presetToInstallName);

            //Get all current files in Skyrim directory
            skyrimFiles = Directory.GetFiles(skyrimLocation);
            skyrimDirectories = Directory.GetDirectories(skyrimLocation);

            //Read through the ENB filter again
            enbFileFilterArray = File.ReadAllLines(metaLocation + @"data\EnbFiles.cfg");

            //To start, clear the Debug Text Box
            debug2_TextBox.Clear();

            //Remove all existing ENB files in the Skyrim directory NOTE: Make this a warning
            foreach (string file in skyrimFiles)
            {
                //Since File has the complete path, remove it
                if (enbFileFilterArray.Contains(file.Replace(skyrimLocation + @"\", "")))
                {
                    //Deletes the file
                    File.Delete(file);

                    debug2_TextBox.AppendText("File Deleted: " + file + Environment.NewLine);
                }
            }

            //Remove all existing ENB directories in the Skyrim directory NOTE: Make this a warning
            foreach (string directory in skyrimDirectories)
            {
                //Since the directory has the complete path, remove it
                if (enbFileFilterArray.Contains(directory.Replace(skyrimLocation + @"\", "")))
                {
                    //Deletes the Directory
                    Directory.Delete(directory, true);

                    debug2_TextBox.AppendText("Directory Deleted: " + directory + Environment.NewLine);
                }
            }

            debug2_TextBox.AppendText(Environment.NewLine);

            //Add all files from the preset directory into the matchingPresetFiles list
            foreach (string file in presetFilesToInstall)
            {
                //Since the preset file has the complete path, remove it
                if (enbFileFilterArray.Contains(file.Replace(metaLocation + @"data\presets" + presetToInstallName, "")))
                {
                    //If it is in the EnbFilter, add it to the matchingPresetFiles list
                    matchingPresetFiles.Add(file);

                    debug2_TextBox.AppendText("File Added: " + file + Environment.NewLine);
                }
            }

            //Add all directories from the preset directory into the matchingPresetDirectories list (FULL PATH)
            foreach (string directory in presetDirectoriesToInstall)
            {
                //Since the preset directory has the complete path, remove it
                if (enbFileFilterArray.Contains(directory.Replace(metaLocation + @"data\presets" + presetToInstallName, "")))
                {
                    //If it is in the EnbFilter, add it to the matchingPresetDirectories list (FULL PATH)
                    matchingPresetDirectories.Add(directory);

                    debug2_TextBox.AppendText("Directory Added: " + directory + Environment.NewLine);
                }
            }

            debug2_TextBox.AppendText(Environment.NewLine);
            debug2_TextBox.AppendText(Environment.NewLine);

            //===//

            //Copy the files in the preset folder
            foreach (string file in presetFilesToInstall)
            {
                File.Copy(file, skyrimLocation + @"\" + file.Replace(metaLocation + @"data\presets\" + presetToInstallName + @"\", ""));

                debug2_TextBox.AppendText("File Moved: " + skyrimLocation + @"\" + file.Replace(metaLocation + @"data\presets\" + presetToInstallName + @"\", "") + Environment.NewLine);
            }

            foreach (string directory in presetDirectoriesToInstall)
            {
                DeepCopy(directory, skyrimLocation + @"\" + directory.Replace(metaLocation + @"data\presets\" + presetToInstallName + @"\", ""));

                debug2_TextBox.AppendText("Directory Moved: " + skyrimLocation + @"\" + directory.Replace(metaLocation + @"data\presets\" + presetToInstallName + @"\", "") + Environment.NewLine);
            }

            //Change the value of InstalledPreset
            Properties.Settings.Default["InstalledPreset"] = presetToInstallName;

            //Then save the setting
            Properties.Settings.Default.Save();

            //Then set the label to the InstalledPreset value
            currentENB_Label.Text = "Installed Preset:  " + Properties.Settings.Default["InstalledPreset"].ToString();


        }

        private void uninstallENB_Button_Click(object sender, EventArgs e)
        {
            debug_TextBox.Clear();

            UninstallENB(1);

            debug_TextBox.AppendText("ENB Files removed" + Environment.NewLine);
        }

        private void uninstallENB2_Button_Click(object sender, EventArgs e)
        {
            debug2_TextBox.Clear();

            UninstallENB(2);

            debug2_TextBox.AppendText("ENB Files removed" + Environment.NewLine);
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

                Properties.Settings.Default.SKSELocation = SKSELocation;
                Properties.Settings.Default.Save();
            }
        }

        private void SkyrimLocation_TextBox_TextChanged(object sender, EventArgs e)
        {
            //Check to see if the SkyrimLocation text box file exists, and if it does, save it in the settings

            if (Directory.Exists(SkyrimLocation_TextBox.Text.Replace("\"", "")))
            {
                savePreset_Button.Enabled = true;
                installPreset_Button.Enabled = true;

                uninstallENB_Button.Enabled = true;
                uninstallENB2_Button.Enabled = true;

                setNotification_Button.Visible = false;

                savedPresets_ComboBox.Enabled = true;

                Properties.Settings.Default.SkyrimLocation = SkyrimLocation_TextBox.Text;
                Properties.Settings.Default.Save();

                skyrimLocation = Properties.Settings.Default.SkyrimLocation;
            }

            else if (!Directory.Exists(SkyrimLocation_TextBox.Text.Replace("\"", "")))
            {
                savePreset_Button.Enabled = false;
                installPreset_Button.Enabled = true;

                uninstallENB_Button.Enabled = false;
                uninstallENB2_Button.Enabled = false;

                setNotification_Button.Visible = true;

                savedPresets_ComboBox.Enabled = false;

                Properties.Settings.Default.SkyrimLocation = SkyrimLocation_TextBox.Text;
                Properties.Settings.Default.Save();
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

            if (savedPresets_ComboBox.Text == Properties.Settings.Default["InstalledPreset"].ToString())
            {
                //Then reset the settings
                Properties.Settings.Default["InstalledPreset"] = "";

                //Then save the settings
                Properties.Settings.Default.Save();

                currentENB_Label.Text = "Installed Preset:  ";
            }

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

            matchingPresetFiles = new List<string>();
            matchingPresetDirectories = new List<string>();
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

        public void UninstallENB(int currentPage)
        {
            //Get the Skyrim Location
            skyrimLocation = SkyrimLocation_TextBox.Text;

            //Get all current files in Skyrim directory
            skyrimFiles = Directory.GetFiles(skyrimLocation);
            skyrimDirectories = Directory.GetDirectories(skyrimLocation);

            //Read through the ENB filter again
            enbFileFilterArray = File.ReadAllLines(metaLocation + @"data\EnbFiles.cfg");

            //Remove all existing ENB files in the Skyrim directory NOTE: Make this a warning
            foreach (string file in skyrimFiles)
            {
                //Since File has the complete path, remove it
                if (enbFileFilterArray.Contains(file.Replace(skyrimLocation + @"\", "")))
                {
                    //Deletes the file
                    File.Delete(file);

                    if (currentPage == 1)
                        debug_TextBox.AppendText("File Deleted: " + file + Environment.NewLine);

                    else if (currentPage == 2)
                        debug2_TextBox.AppendText("File Deleted: " + file + Environment.NewLine);
                }
            }

            //Remove all existing ENB directories in the Skyrim directory NOTE: Make this a warning
            foreach (string directory in skyrimDirectories)
            {
                //Since the directory has the complete path, remove it
                if (enbFileFilterArray.Contains(directory.Replace(skyrimLocation + @"\", "")))
                {
                    //Deletes the Directory
                    Directory.Delete(directory, true);

                    if (currentPage == 1)
                        debug_TextBox.AppendText("File Deleted: " + directory + Environment.NewLine);

                    else if (currentPage == 2)
                        debug2_TextBox.AppendText("File Deleted: " + directory + Environment.NewLine);
                }
            }

            //Then reset the settings
            Properties.Settings.Default["InstalledPreset"] = "";

            //Then save the settings
            Properties.Settings.Default.Save();

            currentENB_Label.Text = "Installed Preset:  ";
        }

        public void DeepCopy(string sourceDir, string targetDir)
        {
            Directory.CreateDirectory(targetDir);

            foreach (var file in Directory.GetFiles(sourceDir))
                File.Copy(file, Path.Combine(targetDir, Path.GetFileName(file)));

            foreach (var directory in Directory.GetDirectories(sourceDir))
                DeepCopy(directory, Path.Combine(targetDir, Path.GetFileName(directory)));
        }

        public void CopyFolder(string sourceFolder, string destFolder)
        {
            if (!Directory.Exists(destFolder))
                Directory.CreateDirectory(destFolder);
            string[] files = Directory.GetFiles(sourceFolder);
            foreach (string file in files)
            {
                string name = Path.GetFileName(file);
                string dest = Path.Combine(destFolder, name);
                File.Copy(file, dest);
            }
            string[] folders = Directory.GetDirectories(sourceFolder);
            foreach (string folder in folders)
            {
                string name = Path.GetFileName(folder);
                string dest = Path.Combine(destFolder, name);
                CopyFolder(folder, dest);
            }
        }
    }
}
