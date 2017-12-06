 
from System import *
from System.Drawing import *
from System.Windows.Forms import *
from HFSGuardaDiretorio.objetos import *

class FrmInfoDiretorio(Form):
	def __init__(self):
		self._components = None
		self.InitializeComponent()
		self._fonte = Font(lvInfo.Items[0].Font, FontStyle.Bold)

	def InitializeComponent(self):
		listViewItem11 = System.Windows.Forms.ListViewItem("Aba:")
		listViewItem12 = System.Windows.Forms.ListViewItem("Nome:")
		listViewItem13 = System.Windows.Forms.ListViewItem("Tamanho:")
		listViewItem14 = System.Windows.Forms.ListViewItem("Tipo:")
		listViewItem15 = System.Windows.Forms.ListViewItem("Modificado:")
		listViewItem16 = System.Windows.Forms.ListViewItem("Atributos:")
		listViewItem17 = System.Windows.Forms.ListViewItem("Caminho:")
		self._groupBox1 = System.Windows.Forms.GroupBox()
		self._label5 = System.Windows.Forms.Label()
		self._label6 = System.Windows.Forms.Label()
		self._label3 = System.Windows.Forms.Label()
		self._label4 = System.Windows.Forms.Label()
		self._label2 = System.Windows.Forms.Label()
		self._label1 = System.Windows.Forms.Label()
		self._lvInfo = System.Windows.Forms.ListView()
		self._columnHeader1 = System.Windows.Forms.ColumnHeader()
		self._columnHeader2 = System.Windows.Forms.ColumnHeader()
		self._btnOk = System.Windows.Forms.Button()
		self._groupBox1.SuspendLayout()
		self.SuspendLayout()
		# 
		# groupBox1
		# 
		self._groupBox1.Controls.Add(self._label5)
		self._groupBox1.Controls.Add(self._label6)
		self._groupBox1.Controls.Add(self._label3)
		self._groupBox1.Controls.Add(self._label4)
		self._groupBox1.Controls.Add(self._label2)
		self._groupBox1.Controls.Add(self._label1)
		self._groupBox1.Location = System.Drawing.Point(12, 12)
		self._groupBox1.Name = "groupBox1"
		self._groupBox1.Size = System.Drawing.Size(340, 96)
		self._groupBox1.TabIndex = 0
		self._groupBox1.TabStop = False
		self._groupBox1.Text = "Legenda dos Atributos"
		# 
		# label5
		# 
		self._label5.Location = System.Drawing.Point(166, 62)
		self._label5.Name = "label5"
		self._label5.Size = System.Drawing.Size(168, 23)
		self._label5.TabIndex = 5
		self._label5.Text = "[ROL] - Arquivo Somente Leitura"
		self._label5.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# label6
		# 
		self._label6.Location = System.Drawing.Point(6, 62)
		self._label6.Name = "label6"
		self._label6.Size = System.Drawing.Size(154, 23)
		self._label6.TabIndex = 4
		self._label6.Text = "[SYS] - Arquivo de Sistema"
		self._label6.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# label3
		# 
		self._label3.Location = System.Drawing.Point(166, 39)
		self._label3.Name = "label3"
		self._label3.Size = System.Drawing.Size(168, 23)
		self._label3.TabIndex = 3
		self._label3.Text = "[VOL] - Volume ID"
		self._label3.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# label4
		# 
		self._label4.Location = System.Drawing.Point(6, 39)
		self._label4.Name = "label4"
		self._label4.Size = System.Drawing.Size(154, 23)
		self._label4.TabIndex = 2
		self._label4.Text = "[HID] - Arquivo Oculto"
		self._label4.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# label2
		# 
		self._label2.Location = System.Drawing.Point(166, 16)
		self._label2.Name = "label2"
		self._label2.Size = System.Drawing.Size(168, 23)
		self._label2.TabIndex = 1
		self._label2.Text = "[DIR] - Diretório"
		self._label2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# label1
		# 
		self._label1.Location = System.Drawing.Point(6, 16)
		self._label1.Name = "label1"
		self._label1.Size = System.Drawing.Size(154, 23)
		self._label1.TabIndex = 0
		self._label1.Text = "[ARQ] - Arquivo comum"
		self._label1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# lvInfo
		# 
		self._lvInfo.Columns.AddRange(System.Array[System.Windows.Forms.ColumnHeader](
			[self._columnHeader1,
			self._columnHeader2]))
		self._lvInfo.GridLines = True
		self._lvInfo.Items.AddRange(System.Array[System.Windows.Forms.ListViewItem](
			[listViewItem11,
			listViewItem12,
			listViewItem13,
			listViewItem14,
			listViewItem15,
			listViewItem16,
			listViewItem17]))
		self._lvInfo.Location = System.Drawing.Point(18, 114)
		self._lvInfo.MultiSelect = False
		self._lvInfo.Name = "lvInfo"
		self._lvInfo.OwnerDraw = True
		self._lvInfo.Size = System.Drawing.Size(328, 181)
		self._lvInfo.TabIndex = 1
		self._lvInfo.UseCompatibleStateImageBehavior = False
		self._lvInfo.View = System.Windows.Forms.View.Details
		self._lvInfo.DrawColumnHeader += self.LvInfoDrawColumnHeader
		self._lvInfo.DrawItem += self.LvInfoDrawItem
		self._lvInfo.DrawSubItem += self.LvInfoDrawSubItem
		# 
		# columnHeader1
		# 
		self._columnHeader1.Text = "Item"
		self._columnHeader1.Width = 108
		# 
		# columnHeader2
		# 
		self._columnHeader2.Text = "Descrição"
		self._columnHeader2.Width = 214
		# 
		# btnOk
		# 
		self._btnOk.Location = System.Drawing.Point(146, 309)
		self._btnOk.Name = "btnOk"
		self._btnOk.Size = System.Drawing.Size(75, 23)
		self._btnOk.TabIndex = 2
		self._btnOk.Text = "&Ok"
		self._btnOk.UseVisualStyleBackColor = True
		self._btnOk.Click += self.BtnOkClick
		# 
		# FrmInfoDiretorio
		# 
		self.AutoScaleDimensions = System.Drawing.SizeF(6, 13)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(363, 344)
		self.Controls.Add(self._btnOk)
		self.Controls.Add(self._lvInfo)
		self.Controls.Add(self._groupBox1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MaximizeBox = False
		self.MinimizeBox = False
		self.Name = "FrmInfoDiretorio"
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
		self.Text = "Informações do Diretório / Arquivo"
		self._groupBox1.ResumeLayout(False)
		self.ResumeLayout(False)

	def Dispose(self, disposing):
		if disposing:
			if self._components != None:
				self._components.Dispose()
		self.Dispose(disposing)

	def BtnOkClick(self, sender, e):
		self.Close()

	def setDiretorio(self, diretorio):
		if diretorio != None:
			lvInfo.Items[0].SubItems.Add(diretorio.Aba.Nome)
			lvInfo.Items[1].SubItems.Add(diretorio.Nome)
			lvInfo.Items[2].SubItems.Add(diretorio.TamanhoFormatado)
			lvInfo.Items[3].SubItems.Add(diretorio.Tipo.Nome)
			lvInfo.Items[4].SubItems.Add(diretorio.ModificadoFormatado)
			lvInfo.Items[5].SubItems.Add(diretorio.Atributos)
			lvInfo.Items[6].SubItems.Add(diretorio.Caminho)
			lvInfo.Columns[1].Width = diretorio.Caminho.Length * 8

	def LvInfoDrawColumnHeader(self, sender, e):
		e.DrawDefault = True

	def LvInfoDrawItem(self, sender, e):
		e.DrawBackground()
		if (e.State & ListViewItemStates.Selected) == ListViewItemStates.Selected:
			e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
			e.Item.ForeColor = SystemColors.HighlightText
		else:
			e.Item.ForeColor = SystemColors.WindowText
		e.Item.Font = self._fonte
		e.DrawText()

	def LvInfoDrawSubItem(self, sender, e):
		e.DrawBackground()
		if (e.ItemState & ListViewItemStates.Selected) == ListViewItemStates.Selected:
			e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
			e.SubItem.ForeColor = SystemColors.HighlightText
		else:
			e.SubItem.ForeColor = SystemColors.WindowText
		e.DrawText()