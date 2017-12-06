/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 10:52
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace HFSGuardaDiretorio.gui

partial internal class FrmSplash:

	private components as System.ComponentModel.IContainer = null

	
	protected override def Dispose(disposing as bool):
		if disposing:
			if components is not null:
				components.Dispose()
		super.Dispose(disposing)

	
	private def InitializeComponent():
		self.label1 = System.Windows.Forms.Label()
		self.label2 = System.Windows.Forms.Label()
		self.pb = System.Windows.Forms.ProgressBar()
		self.SuspendLayout()
		// 
		// label1
		// 
		self.label1.Font = System.Drawing.Font('Microsoft Sans Serif', 20.0F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (0 cast byte))
		self.label1.Location = System.Drawing.Point(21, 9)
		self.label1.Name = 'label1'
		self.label1.Size = System.Drawing.Size(332, 34)
		self.label1.TabIndex = 0
		self.label1.Text = 'HFSGuardaDiretorio 2.0'
		// 
		// label2
		// 
		self.label2.Font = System.Drawing.Font('Microsoft Sans Serif', 15.0F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (0 cast byte))
		self.label2.Location = System.Drawing.Point(47, 53)
		self.label2.Name = 'label2'
		self.label2.Size = System.Drawing.Size(267, 29)
		self.label2.TabIndex = 1
		self.label2.Text = 'Catalogador de Diretórios'
		// 
		// pb
		// 
		self.pb.Dock = System.Windows.Forms.DockStyle.Bottom
		self.pb.Location = System.Drawing.Point(0, 96)
		self.pb.Name = 'pb'
		self.pb.Size = System.Drawing.Size(375, 17)
		self.pb.Step = 1
		self.pb.TabIndex = 2
		// 
		// FrmSplash
		// 
		self.AutoScaleDimensions = System.Drawing.SizeF(6.0F, 13.0F)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(375, 113)
		self.ControlBox = false
		self.Controls.Add(self.pb)
		self.Controls.Add(self.label2)
		self.Controls.Add(self.label1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
		self.MaximizeBox = false
		self.MinimizeBox = false
		self.Name = 'FrmSplash'
		self.ShowIcon = false
		self.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = 'FrmSplash'
		self.ResumeLayout(false)

	public pb as System.Windows.Forms.ProgressBar

	private label2 as System.Windows.Forms.Label

	private label1 as System.Windows.Forms.Label

