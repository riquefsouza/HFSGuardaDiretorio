
import System.Drawing
import System.Windows.Forms

from System.Drawing import *
from System.Windows.Forms import *

class FrmSplash(Form):
	def __init__(self):
		self.InitializeComponent()
		
	def InitializeComponent(self):
		self._label1 = System.Windows.Forms.Label()
		self._label2 = System.Windows.Forms.Label()
		self._pb = System.Windows.Forms.ProgressBar()
		self.SuspendLayout()
		# 
		# label1
		# 
		self._label1.Font = System.Drawing.Font("Microsoft Sans Serif", 20, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, 0)
		self._label1.Location = System.Drawing.Point(21, 9)
		self._label1.Name = "label1"
		self._label1.Size = System.Drawing.Size(332, 34)
		self._label1.TabIndex = 0
		self._label1.Text = "HFSGuardaDiretorio 2.0"
		# 
		# label2
		# 
		self._label2.Font = System.Drawing.Font("Microsoft Sans Serif", 15, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, 0)
		self._label2.Location = System.Drawing.Point(47, 53)
		self._label2.Name = "label2"
		self._label2.Size = System.Drawing.Size(267, 29)
		self._label2.TabIndex = 1
		self._label2.Text = "Catalogador de Diretórios"
		# 
		# pb
		# 
		self._pb.Dock = System.Windows.Forms.DockStyle.Bottom
		self._pb.Location = System.Drawing.Point(0, 96)
		self._pb.Name = "pb"
		self._pb.Size = System.Drawing.Size(375, 17)
		self._pb.Step = 1
		self._pb.TabIndex = 2
		# 
		# FrmSplash
		# 
		self.AutoScaleDimensions = System.Drawing.SizeF(6, 13)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(375, 113)
		self.ControlBox = False
		self.Controls.Add(self._pb)
		self.Controls.Add(self._label2)
		self.Controls.Add(self._label1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
		self.MaximizeBox = False
		self.MinimizeBox = False
		self.Name = "FrmSplash"
		self.ShowIcon = False
		self.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = "FrmSplash"
		self.ResumeLayout(False)