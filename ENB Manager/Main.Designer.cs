namespace ENB_Manager
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.materialLabel1 = new MaterialSkin.Controls.MaterialLabel();
            this.savePreset_TextBox = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.materialTabControl1 = new MaterialSkin.Controls.MaterialTabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.debug_TextBox = new System.Windows.Forms.RichTextBox();
            this.savePreset_Button = new MaterialSkin.Controls.MaterialFlatButton();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.SkyrimLocation_TextBox = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.materialLabel4 = new MaterialSkin.Controls.MaterialLabel();
            this.SKSELocation_TextBox = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.materialLabel3 = new MaterialSkin.Controls.MaterialLabel();
            this.debugUI_CheckBox = new MaterialSkin.Controls.MaterialCheckBox();
            this.materialLabel2 = new MaterialSkin.Controls.MaterialLabel();
            this.materialTabSelector1 = new MaterialSkin.Controls.MaterialTabSelector();
            this.runSKSE_Button = new MaterialSkin.Controls.MaterialFlatButton();
            this.SKSELocation_FileDialog = new MaterialSkin.Controls.MaterialRaisedButton();
            this.skyrimLocation_FileDialog = new MaterialSkin.Controls.MaterialRaisedButton();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.folderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
            this.materialTabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.tabPage3.SuspendLayout();
            this.SuspendLayout();
            // 
            // materialLabel1
            // 
            this.materialLabel1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.materialLabel1.AutoSize = true;
            this.materialLabel1.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.materialLabel1.Depth = 0;
            this.materialLabel1.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel1.Location = new System.Drawing.Point(6, 12);
            this.materialLabel1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel1.Name = "materialLabel1";
            this.materialLabel1.Size = new System.Drawing.Size(104, 19);
            this.materialLabel1.TabIndex = 7;
            this.materialLabel1.Text = "Preset Name: ";
            // 
            // savePreset_TextBox
            // 
            this.savePreset_TextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.savePreset_TextBox.BackColor = System.Drawing.Color.White;
            this.savePreset_TextBox.Depth = 0;
            this.savePreset_TextBox.Font = new System.Drawing.Font("Roboto Light", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.savePreset_TextBox.Hint = "";
            this.savePreset_TextBox.Location = new System.Drawing.Point(115, 12);
            this.savePreset_TextBox.MouseState = MaterialSkin.MouseState.HOVER;
            this.savePreset_TextBox.Name = "savePreset_TextBox";
            this.savePreset_TextBox.PasswordChar = '\0';
            this.savePreset_TextBox.SelectedText = "";
            this.savePreset_TextBox.SelectionLength = 0;
            this.savePreset_TextBox.SelectionStart = 0;
            this.savePreset_TextBox.Size = new System.Drawing.Size(500, 23);
            this.savePreset_TextBox.TabIndex = 6;
            this.savePreset_TextBox.Text = "Preset Test";
            this.savePreset_TextBox.UseSystemPasswordChar = false;
            this.savePreset_TextBox.TextChanged += new System.EventHandler(this.savePreset_TextBox_TextChanged);
            // 
            // materialTabControl1
            // 
            this.materialTabControl1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.materialTabControl1.Controls.Add(this.tabPage1);
            this.materialTabControl1.Controls.Add(this.tabPage2);
            this.materialTabControl1.Controls.Add(this.tabPage3);
            this.materialTabControl1.Depth = 0;
            this.materialTabControl1.Location = new System.Drawing.Point(12, 73);
            this.materialTabControl1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialTabControl1.Name = "materialTabControl1";
            this.materialTabControl1.SelectedIndex = 0;
            this.materialTabControl1.Size = new System.Drawing.Size(633, 364);
            this.materialTabControl1.TabIndex = 10;
            // 
            // tabPage1
            // 
            this.tabPage1.BackColor = System.Drawing.Color.White;
            this.tabPage1.Controls.Add(this.debug_TextBox);
            this.tabPage1.Controls.Add(this.savePreset_Button);
            this.tabPage1.Controls.Add(this.materialLabel1);
            this.tabPage1.Controls.Add(this.savePreset_TextBox);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(625, 338);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Save Preset";
            // 
            // debug_TextBox
            // 
            this.debug_TextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.debug_TextBox.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.debug_TextBox.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.debug_TextBox.Font = new System.Drawing.Font("Roboto Light", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.debug_TextBox.Location = new System.Drawing.Point(10, 58);
            this.debug_TextBox.Name = "debug_TextBox";
            this.debug_TextBox.ReadOnly = true;
            this.debug_TextBox.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical;
            this.debug_TextBox.Size = new System.Drawing.Size(605, 230);
            this.debug_TextBox.TabIndex = 11;
            this.debug_TextBox.Text = "";
            // 
            // savePreset_Button
            // 
            this.savePreset_Button.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.savePreset_Button.AutoSize = true;
            this.savePreset_Button.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.savePreset_Button.Cursor = System.Windows.Forms.Cursors.Hand;
            this.savePreset_Button.Depth = 0;
            this.savePreset_Button.Location = new System.Drawing.Point(486, 297);
            this.savePreset_Button.Margin = new System.Windows.Forms.Padding(10, 6, 4, 6);
            this.savePreset_Button.MouseState = MaterialSkin.MouseState.HOVER;
            this.savePreset_Button.Name = "savePreset_Button";
            this.savePreset_Button.Primary = false;
            this.savePreset_Button.Size = new System.Drawing.Size(129, 36);
            this.savePreset_Button.TabIndex = 10;
            this.savePreset_Button.Text = "Save ENB Preset ";
            this.savePreset_Button.UseVisualStyleBackColor = true;
            this.savePreset_Button.Click += new System.EventHandler(this.savePreset_Button_Click);
            // 
            // tabPage2
            // 
            this.tabPage2.Location = new System.Drawing.Point(4, 23);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(625, 337);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Install Preset";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // tabPage3
            // 
            this.tabPage3.BackColor = System.Drawing.Color.White;
            this.tabPage3.Controls.Add(this.skyrimLocation_FileDialog);
            this.tabPage3.Controls.Add(this.SKSELocation_FileDialog);
            this.tabPage3.Controls.Add(this.SkyrimLocation_TextBox);
            this.tabPage3.Controls.Add(this.materialLabel4);
            this.tabPage3.Controls.Add(this.SKSELocation_TextBox);
            this.tabPage3.Controls.Add(this.materialLabel3);
            this.tabPage3.Controls.Add(this.debugUI_CheckBox);
            this.tabPage3.Controls.Add(this.materialLabel2);
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(625, 338);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Settings";
            // 
            // SkyrimLocation_TextBox
            // 
            this.SkyrimLocation_TextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.SkyrimLocation_TextBox.Depth = 0;
            this.SkyrimLocation_TextBox.Hint = "";
            this.SkyrimLocation_TextBox.Location = new System.Drawing.Point(134, 46);
            this.SkyrimLocation_TextBox.MouseState = MaterialSkin.MouseState.HOVER;
            this.SkyrimLocation_TextBox.Name = "SkyrimLocation_TextBox";
            this.SkyrimLocation_TextBox.PasswordChar = '\0';
            this.SkyrimLocation_TextBox.SelectedText = "";
            this.SkyrimLocation_TextBox.SelectionLength = 0;
            this.SkyrimLocation_TextBox.SelectionStart = 0;
            this.SkyrimLocation_TextBox.Size = new System.Drawing.Size(421, 23);
            this.SkyrimLocation_TextBox.TabIndex = 5;
            this.SkyrimLocation_TextBox.UseSystemPasswordChar = false;
            this.SkyrimLocation_TextBox.TextChanged += new System.EventHandler(this.SkyrimLocation_TextBox_TextChanged);
            // 
            // materialLabel4
            // 
            this.materialLabel4.AutoSize = true;
            this.materialLabel4.Depth = 0;
            this.materialLabel4.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel4.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel4.Location = new System.Drawing.Point(7, 48);
            this.materialLabel4.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel4.Name = "materialLabel4";
            this.materialLabel4.Size = new System.Drawing.Size(126, 19);
            this.materialLabel4.TabIndex = 4;
            this.materialLabel4.Text = "Skyrim Location: ";
            // 
            // SKSELocation_TextBox
            // 
            this.SKSELocation_TextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.SKSELocation_TextBox.Depth = 0;
            this.SKSELocation_TextBox.Hint = "";
            this.SKSELocation_TextBox.Location = new System.Drawing.Point(134, 13);
            this.SKSELocation_TextBox.MouseState = MaterialSkin.MouseState.HOVER;
            this.SKSELocation_TextBox.Name = "SKSELocation_TextBox";
            this.SKSELocation_TextBox.PasswordChar = '\0';
            this.SKSELocation_TextBox.SelectedText = "";
            this.SKSELocation_TextBox.SelectionLength = 0;
            this.SKSELocation_TextBox.SelectionStart = 0;
            this.SKSELocation_TextBox.Size = new System.Drawing.Size(421, 23);
            this.SKSELocation_TextBox.TabIndex = 3;
            this.SKSELocation_TextBox.UseSystemPasswordChar = false;
            this.SKSELocation_TextBox.TextChanged += new System.EventHandler(this.SKSELocation_TextBox_TextChanged);
            // 
            // materialLabel3
            // 
            this.materialLabel3.AutoSize = true;
            this.materialLabel3.Depth = 0;
            this.materialLabel3.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel3.Location = new System.Drawing.Point(7, 13);
            this.materialLabel3.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel3.Name = "materialLabel3";
            this.materialLabel3.Size = new System.Drawing.Size(116, 19);
            this.materialLabel3.TabIndex = 2;
            this.materialLabel3.Text = "SKSE Location: ";
            // 
            // debugUI_CheckBox
            // 
            this.debugUI_CheckBox.AutoSize = true;
            this.debugUI_CheckBox.Checked = true;
            this.debugUI_CheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
            this.debugUI_CheckBox.Depth = 0;
            this.debugUI_CheckBox.Font = new System.Drawing.Font("Roboto", 10F);
            this.debugUI_CheckBox.Location = new System.Drawing.Point(134, 77);
            this.debugUI_CheckBox.Margin = new System.Windows.Forms.Padding(0);
            this.debugUI_CheckBox.MouseLocation = new System.Drawing.Point(-1, -1);
            this.debugUI_CheckBox.MouseState = MaterialSkin.MouseState.HOVER;
            this.debugUI_CheckBox.Name = "debugUI_CheckBox";
            this.debugUI_CheckBox.Ripple = true;
            this.debugUI_CheckBox.Size = new System.Drawing.Size(26, 30);
            this.debugUI_CheckBox.TabIndex = 1;
            this.debugUI_CheckBox.UseVisualStyleBackColor = true;
            this.debugUI_CheckBox.CheckedChanged += new System.EventHandler(this.debugUI_CheckBox_CheckedChanged);
            // 
            // materialLabel2
            // 
            this.materialLabel2.AutoSize = true;
            this.materialLabel2.Depth = 0;
            this.materialLabel2.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel2.Location = new System.Drawing.Point(7, 83);
            this.materialLabel2.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel2.Name = "materialLabel2";
            this.materialLabel2.Size = new System.Drawing.Size(126, 19);
            this.materialLabel2.TabIndex = 0;
            this.materialLabel2.Text = "Enable Debug UI: ";
            // 
            // materialTabSelector1
            // 
            this.materialTabSelector1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.materialTabSelector1.BaseTabControl = this.materialTabControl1;
            this.materialTabSelector1.Depth = 0;
            this.materialTabSelector1.Location = new System.Drawing.Point(-5, 24);
            this.materialTabSelector1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialTabSelector1.Name = "materialTabSelector1";
            this.materialTabSelector1.Size = new System.Drawing.Size(662, 43);
            this.materialTabSelector1.TabIndex = 11;
            this.materialTabSelector1.Text = "materialTabSelector1";
            // 
            // runSKSE_Button
            // 
            this.runSKSE_Button.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.runSKSE_Button.AutoSize = true;
            this.runSKSE_Button.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.runSKSE_Button.Cursor = System.Windows.Forms.Cursors.Hand;
            this.runSKSE_Button.Depth = 0;
            this.runSKSE_Button.Enabled = false;
            this.runSKSE_Button.Location = new System.Drawing.Point(577, 27);
            this.runSKSE_Button.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.runSKSE_Button.MouseState = MaterialSkin.MouseState.HOVER;
            this.runSKSE_Button.Name = "runSKSE_Button";
            this.runSKSE_Button.Primary = false;
            this.runSKSE_Button.Size = new System.Drawing.Size(76, 36);
            this.runSKSE_Button.TabIndex = 12;
            this.runSKSE_Button.Text = "Run SKSE";
            this.runSKSE_Button.UseVisualStyleBackColor = true;
            this.runSKSE_Button.Click += new System.EventHandler(this.runSKSE_Button_Click);
            // 
            // SKSELocation_FileDialog
            // 
            this.SKSELocation_FileDialog.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.SKSELocation_FileDialog.Depth = 0;
            this.SKSELocation_FileDialog.Location = new System.Drawing.Point(561, 13);
            this.SKSELocation_FileDialog.MouseState = MaterialSkin.MouseState.HOVER;
            this.SKSELocation_FileDialog.Name = "SKSELocation_FileDialog";
            this.SKSELocation_FileDialog.Primary = true;
            this.SKSELocation_FileDialog.Size = new System.Drawing.Size(52, 23);
            this.SKSELocation_FileDialog.TabIndex = 6;
            this.SKSELocation_FileDialog.Text = "...";
            this.SKSELocation_FileDialog.UseVisualStyleBackColor = true;
            this.SKSELocation_FileDialog.Click += new System.EventHandler(this.SKSELocation_FileDialog_Click);
            // 
            // skyrimLocation_FileDialog
            // 
            this.skyrimLocation_FileDialog.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.skyrimLocation_FileDialog.Depth = 0;
            this.skyrimLocation_FileDialog.Location = new System.Drawing.Point(561, 46);
            this.skyrimLocation_FileDialog.MouseState = MaterialSkin.MouseState.HOVER;
            this.skyrimLocation_FileDialog.Name = "skyrimLocation_FileDialog";
            this.skyrimLocation_FileDialog.Primary = true;
            this.skyrimLocation_FileDialog.Size = new System.Drawing.Size(52, 23);
            this.skyrimLocation_FileDialog.TabIndex = 7;
            this.skyrimLocation_FileDialog.Text = "...";
            this.skyrimLocation_FileDialog.UseVisualStyleBackColor = true;
            this.skyrimLocation_FileDialog.Click += new System.EventHandler(this.skyrimLocation_FileDialog_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.ClientSize = new System.Drawing.Size(657, 449);
            this.Controls.Add(this.runSKSE_Button);
            this.Controls.Add(this.materialTabSelector1);
            this.Controls.Add(this.materialTabControl1);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Name = "MainForm";
            this.Text = "ENB Manager";
            this.materialTabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.tabPage3.ResumeLayout(false);
            this.tabPage3.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private MaterialSkin.Controls.MaterialLabel materialLabel1;
        private MaterialSkin.Controls.MaterialSingleLineTextField savePreset_TextBox;
        private MaterialSkin.Controls.MaterialTabControl materialTabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private MaterialSkin.Controls.MaterialTabSelector materialTabSelector1;
        private MaterialSkin.Controls.MaterialFlatButton savePreset_Button;
        private System.Windows.Forms.TabPage tabPage3;
        private System.Windows.Forms.RichTextBox debug_TextBox;
        private MaterialSkin.Controls.MaterialLabel materialLabel2;
        private MaterialSkin.Controls.MaterialCheckBox debugUI_CheckBox;
        private MaterialSkin.Controls.MaterialFlatButton runSKSE_Button;
        private MaterialSkin.Controls.MaterialSingleLineTextField SKSELocation_TextBox;
        private MaterialSkin.Controls.MaterialLabel materialLabel3;
        private MaterialSkin.Controls.MaterialSingleLineTextField SkyrimLocation_TextBox;
        private MaterialSkin.Controls.MaterialLabel materialLabel4;
        private MaterialSkin.Controls.MaterialRaisedButton skyrimLocation_FileDialog;
        private MaterialSkin.Controls.MaterialRaisedButton SKSELocation_FileDialog;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog;
    }
}

