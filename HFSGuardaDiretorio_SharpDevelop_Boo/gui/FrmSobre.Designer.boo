/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 10:59
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace HFSGuardaDiretorio.gui

partial internal class FrmSobre:

	private components as System.ComponentModel.IContainer = null

	
	protected override def Dispose(disposing as bool):
		if disposing:
			if components is not null:
				components.Dispose()
		super.Dispose(disposing)

	
	private def InitializeComponent():
		self.label1 = System.Windows.Forms.Label()
		self.label2 = System.Windows.Forms.Label()
		self.label3 = System.Windows.Forms.Label()
		self.label4 = System.Windows.Forms.Label()
		self.btnOk = System.Windows.Forms.Button()
		self.SuspendLayout()
		# 
		# label1
		# 
		self.label1.Font = System.Drawing.Font("Microsoft Sans Serif", 8.25, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, cast(System.Byte,0))
		self.label1.Location = System.Drawing.Point(12, 9)
		self.label1.Name = "label1"
		self.label1.Size = System.Drawing.Size(268, 21)
		self.label1.TabIndex = 0
		self.label1.Text = "HFSGuardaDir 2.0 - Catalogador de Diretórios"
		self.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		# 
		# label2
		# 
		self.label2.Location = System.Drawing.Point(12, 30)
		self.label2.Name = "label2"
		self.label2.Size = System.Drawing.Size(268, 18)
		self.label2.TabIndex = 1
		self.label2.Text = "Desenvolvido em Boo, Versão: 2.0"
		self.label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		# 
		# label3
		# 
		self.label3.Location = System.Drawing.Point(12, 48)
		self.label3.Name = "label3"
		self.label3.Size = System.Drawing.Size(268, 18)
		self.label3.TabIndex = 2
		self.label3.Text = "Por Henrique Figueiredo de Souza"
		self.label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		# 
		# label4
		# 
		self.label4.Location = System.Drawing.Point(12, 66)
		self.label4.Name = "label4"
		self.label4.Size = System.Drawing.Size(268, 18)
		self.label4.TabIndex = 3
		self.label4.Text = "Todos os direitos reservados, 2014"
		self.label4.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		# 
		# btnOk
		# 
		self.btnOk.Location = System.Drawing.Point(108, 96)
		self.btnOk.Name = "btnOk"
		self.btnOk.Size = System.Drawing.Size(75, 23)
		self.btnOk.TabIndex = 4
		self.btnOk.Text = "&Ok"
		self.btnOk.UseVisualStyleBackColor = true
		self.btnOk.Click += self.BtnOkClick as System.EventHandler
		# 
		# FrmSobre
		# 
		self.AutoScaleDimensions = System.Drawing.SizeF(6, 13)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(292, 125)
		self.Controls.Add(self.btnOk)
		self.Controls.Add(self.label4)
		self.Controls.Add(self.label3)
		self.Controls.Add(self.label2)
		self.Controls.Add(self.label1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MaximizeBox = false
		self.MinimizeBox = false
		self.Name = "FrmSobre"
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = "Sobre o Catalogador"
		self.ResumeLayout(false)

	private btnOk as System.Windows.Forms.Button

	private label4 as System.Windows.Forms.Label

	private label3 as System.Windows.Forms.Label

	private label2 as System.Windows.Forms.Label

	private label1 as System.Windows.Forms.Label

