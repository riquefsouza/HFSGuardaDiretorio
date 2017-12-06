
import System.Drawing
import System.Windows.Forms

from System.Drawing import *
from System.Windows.Forms import *

class FrmSobre(Form):
	def __init__(self):
		self.InitializeComponent()

	def InitializeComponent(self):
		self._label1 = System.Windows.Forms.Label()
		self._label2 = System.Windows.Forms.Label()
		self._label3 = System.Windows.Forms.Label()
		self._label4 = System.Windows.Forms.Label()
		self._btnOk = System.Windows.Forms.Button()
		self.SuspendLayout()
		# 
		# label1
		# 
		self._label1.Font = System.Drawing.Font("Microsoft Sans Serif", 8.25, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, 0)
		self._label1.Location = System.Drawing.Point(12, 9)
		self._label1.Name = "label1"
		self._label1.Size = System.Drawing.Size(268, 21)
		self._label1.TabIndex = 0
		self._label1.Text = "HFSGuardaDir 2.0 - Catalogador de Diretórios"
		self._label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		# 
		# label2
		# 
		self._label2.Location = System.Drawing.Point(12, 30)
		self._label2.Name = "label2"
		self._label2.Size = System.Drawing.Size(268, 18)
		self._label2.TabIndex = 1
		self._label2.Text = "Desenvolvido em Python.Net, Versão: 2.0"
		self._label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		# 
		# label3
		# 
		self._label3.Location = System.Drawing.Point(12, 48)
		self._label3.Name = "label3"
		self._label3.Size = System.Drawing.Size(268, 18)
		self._label3.TabIndex = 2
		self._label3.Text = "Por Henrique Figueiredo de Souza"
		self._label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		# 
		# label4
		# 
		self._label4.Location = System.Drawing.Point(12, 66)
		self._label4.Name = "label4"
		self._label4.Size = System.Drawing.Size(268, 18)
		self._label4.TabIndex = 3
		self._label4.Text = "Todos os direitos reservados, 2015"
		self._label4.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		# 
		# btnOk
		# 
		self._btnOk.Location = System.Drawing.Point(108, 96)
		self._btnOk.Name = "btnOk"
		self._btnOk.Size = System.Drawing.Size(75, 23)
		self._btnOk.TabIndex = 4
		self._btnOk.Text = "&Ok"
		self._btnOk.UseVisualStyleBackColor = True
		self._btnOk.Click += self.BtnOkClick
		# 
		# FrmSobre
		# 
		self.AutoScaleDimensions = System.Drawing.SizeF(6, 13)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(292, 125)
		self.Controls.Add(self._btnOk)
		self.Controls.Add(self._label4)
		self.Controls.Add(self._label3)
		self.Controls.Add(self._label2)
		self.Controls.Add(self._label1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MaximizeBox = False
		self.MinimizeBox = False
		self.Name = "FrmSobre"
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = "Sobre o Catalogador"
		self.ResumeLayout(False)
				
	def BtnOkClick(self, sender, e):
		self.Close()