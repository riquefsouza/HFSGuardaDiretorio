/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 11:24
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace HFSGuardaDiretorio.gui

partial internal class FrmImportarDiretorio:

	private components as System.ComponentModel.IContainer = null

	
	protected override def Dispose(disposing as bool):
		if disposing:
			if components is not null:
				components.Dispose()
		super.Dispose(disposing)

	
	private def InitializeComponent():
		self.memoImportaDir = System.Windows.Forms.TextBox()
		self.barraStatus = System.Windows.Forms.StatusStrip()
		self.labStatus1 = System.Windows.Forms.ToolStripStatusLabel()
		self.labStatus2 = System.Windows.Forms.ToolStripStatusLabel()
		self.pbImportar = System.Windows.Forms.ProgressBar()
		self.barraStatus.SuspendLayout()
		self.SuspendLayout()
		// 
		// memoImportaDir
		// 
		self.memoImportaDir.Dock = System.Windows.Forms.DockStyle.Top
		self.memoImportaDir.Location = System.Drawing.Point(0, 0)
		self.memoImportaDir.Multiline = true
		self.memoImportaDir.Name = 'memoImportaDir'
		self.memoImportaDir.ScrollBars = System.Windows.Forms.ScrollBars.Both
		self.memoImportaDir.Size = System.Drawing.Size(889, 505)
		self.memoImportaDir.TabIndex = 0
		// 
		// barraStatus
		// 
		self.barraStatus.Items.AddRange((of System.Windows.Forms.ToolStripItem: self.labStatus1, self.labStatus2))
		self.barraStatus.Location = System.Drawing.Point(0, 522)
		self.barraStatus.Name = 'barraStatus'
		self.barraStatus.Size = System.Drawing.Size(889, 22)
		self.barraStatus.TabIndex = 9
		self.barraStatus.Text = 'statusStrip1'
		// 
		// labStatus1
		// 
		self.labStatus1.AutoSize = false
		self.labStatus1.BorderSides = ((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom) cast System.Windows.Forms.ToolStripStatusLabelBorderSides)
		self.labStatus1.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self.labStatus1.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self.labStatus1.Name = 'labStatus1'
		self.labStatus1.Size = System.Drawing.Size(200, 17)
		self.labStatus1.Text = 'Total de linhas sendo processadas:'
		self.labStatus1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// labStatus2
		// 
		self.labStatus2.BorderSides = ((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom) cast System.Windows.Forms.ToolStripStatusLabelBorderSides)
		self.labStatus2.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self.labStatus2.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self.labStatus2.Name = 'labStatus2'
		self.labStatus2.Size = System.Drawing.Size(643, 17)
		self.labStatus2.Spring = true
		self.labStatus2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// pbImportar
		// 
		self.pbImportar.Dock = System.Windows.Forms.DockStyle.Bottom
		self.pbImportar.Location = System.Drawing.Point(0, 505)
		self.pbImportar.Name = 'pbImportar'
		self.pbImportar.Size = System.Drawing.Size(889, 17)
		self.pbImportar.Step = 1
		self.pbImportar.TabIndex = 10
		// 
		// FrmImportarDiretorio
		// 
		self.AutoScaleDimensions = System.Drawing.SizeF(6.0F, 13.0F)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(889, 544)
		self.ControlBox = false
		self.Controls.Add(self.pbImportar)
		self.Controls.Add(self.barraStatus)
		self.Controls.Add(self.memoImportaDir)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MaximizeBox = false
		self.MinimizeBox = false
		self.Name = 'FrmImportarDiretorio'
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = 'Importando Diretório'
		self.Shown += self.FrmImportarDiretorioShown
		self.barraStatus.ResumeLayout(false)
		self.barraStatus.PerformLayout()
		self.ResumeLayout(false)
		self.PerformLayout()

	public labStatus2 as System.Windows.Forms.ToolStripStatusLabel

	private labStatus1 as System.Windows.Forms.ToolStripStatusLabel

	public barraStatus as System.Windows.Forms.StatusStrip

	public pbImportar as System.Windows.Forms.ProgressBar

	public memoImportaDir as System.Windows.Forms.TextBox

