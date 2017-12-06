
from System import *
from System.IO import *
from System.Drawing import *
from System.Collections.Generic import *
from System.Windows.Forms import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosbo import *
from HFSGuardaDiretorio.objetosgui import *
from HFSGuardaDiretorio.catalogador import *

class FrmCompararDiretorio(Form):
	def __init__(self, frmPrincipal):
		self._components = None
		self.InitializeComponent()
		self._listaCompara = List[Diretorio]()
		self._frmCompararDiretorioProgresso = FrmCompararDiretorioProgresso(self)
		self._catalogador = frmPrincipal.Catalogador
		self.CarregarDados()
		self.LimparComparacao()

	def InitializeComponent(self):
		self._components = System.ComponentModel.Container()
		#resources = System.Resources.ResourceManager("HFSGuardaDiretorio.FrmCompararDiretorio", System.Reflection.Assembly.GetEntryAssembly())
		self._panel1 = System.Windows.Forms.Panel()
		self._pb = System.Windows.Forms.ProgressBar()
		self._btnSalvarLog = System.Windows.Forms.Button()
		self._btnCompararDiretorios = System.Windows.Forms.Button()
		self._gpDiretorio1 = System.Windows.Forms.GroupBox()
		self._tvDiretorio1 = System.Windows.Forms.TreeView()
		self._imageList1 = System.Windows.Forms.ImageList(self._components)
		self._cmbAba1 = System.Windows.Forms.ComboBox()
		self._gpDiretorio2 = System.Windows.Forms.GroupBox()
		self._tvDiretorio2 = System.Windows.Forms.TreeView()
		self._cmbAba2 = System.Windows.Forms.ComboBox()
		self._barraStatus = System.Windows.Forms.StatusStrip()
		self._labStatus1 = System.Windows.Forms.ToolStripStatusLabel()
		self._labStatus2 = System.Windows.Forms.ToolStripStatusLabel()
		self._label1 = System.Windows.Forms.Label()
		self._lvCompara = System.Windows.Forms.ListView()
		self._columnHeader10 = System.Windows.Forms.ColumnHeader()
		self._columnHeader11 = System.Windows.Forms.ColumnHeader()
		self._columnHeader12 = System.Windows.Forms.ColumnHeader()
		self._columnHeader13 = System.Windows.Forms.ColumnHeader()
		self._columnHeader14 = System.Windows.Forms.ColumnHeader()
		self._columnHeader15 = System.Windows.Forms.ColumnHeader()
		self._panel1.SuspendLayout()
		self._gpDiretorio1.SuspendLayout()
		self._gpDiretorio2.SuspendLayout()
		self._barraStatus.SuspendLayout()
		self.SuspendLayout()
		# 
		# panel1
		# 
		self._panel1.Controls.Add(self._pb)
		self._panel1.Controls.Add(self._btnSalvarLog)
		self._panel1.Controls.Add(self._btnCompararDiretorios)
		self._panel1.Dock = System.Windows.Forms.DockStyle.Top
		self._panel1.Location = System.Drawing.Point(0, 0)
		self._panel1.Name = "panel1"
		self._panel1.Size = System.Drawing.Size(687, 37)
		self._panel1.TabIndex = 0
		# 
		# pb
		# 
		self._pb.Location = System.Drawing.Point(136, 10)
		self._pb.Name = "pb"
		self._pb.Size = System.Drawing.Size(446, 19)
		self._pb.Step = 1
		self._pb.TabIndex = 2
		# 
		# btnSalvarLog
		# 
		self._btnSalvarLog.Location = System.Drawing.Point(588, 8)
		self._btnSalvarLog.Name = "btnSalvarLog"
		self._btnSalvarLog.Size = System.Drawing.Size(87, 23)
		self._btnSalvarLog.TabIndex = 1
		self._btnSalvarLog.Text = "&Salvar Log"
		self._btnSalvarLog.UseVisualStyleBackColor = True
		self._btnSalvarLog.Click += self.BtnSalvarLogClick
		# 
		# btnCompararDiretorios
		# 
		self._btnCompararDiretorios.Location = System.Drawing.Point(12, 8)
		self._btnCompararDiretorios.Name = "btnCompararDiretorios"
		self._btnCompararDiretorios.Size = System.Drawing.Size(118, 23)
		self._btnCompararDiretorios.TabIndex = 0
		self._btnCompararDiretorios.Text = "&Comparar Diretórios"
		self._btnCompararDiretorios.UseVisualStyleBackColor = True
		self._btnCompararDiretorios.Click += self.BtnCompararDiretoriosClick
		# 
		# gpDiretorio1
		# 
		self._gpDiretorio1.Controls.Add(self._tvDiretorio1)
		self._gpDiretorio1.Controls.Add(self._cmbAba1)
		self._gpDiretorio1.Location = System.Drawing.Point(12, 43)
		self._gpDiretorio1.Name = "gpDiretorio1"
		self._gpDiretorio1.Size = System.Drawing.Size(329, 284)
		self._gpDiretorio1.TabIndex = 1
		self._gpDiretorio1.TabStop = False
		self._gpDiretorio1.Text = "Diretório 1"
		# 
		# tvDiretorio1
		# 
		self._tvDiretorio1.ImageIndex = 0
		self._tvDiretorio1.ImageList = self._imageList1
		self._tvDiretorio1.Location = System.Drawing.Point(6, 46)
		self._tvDiretorio1.Name = "tvDiretorio1"
		self._tvDiretorio1.SelectedImageIndex = 0
		self._tvDiretorio1.Size = System.Drawing.Size(317, 232)
		self._tvDiretorio1.TabIndex = 1
		# 
		# imageList1
		# 
		#self._imageList1.ImageStream = resources.GetObject("imageList1.ImageStream")
		self._imageList1.TransparentColor = System.Drawing.Color.Transparent
		self._imageList1.Images.SetKeyName(0, "Fechar.bmp")
		self._imageList1.Images.SetKeyName(1, "Abrir.bmp")
		# 
		# cmbAba1
		# 
		self._cmbAba1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		self._cmbAba1.FormattingEnabled = True
		self._cmbAba1.Location = System.Drawing.Point(6, 19)
		self._cmbAba1.Name = "cmbAba1"
		self._cmbAba1.Size = System.Drawing.Size(317, 21)
		self._cmbAba1.TabIndex = 0
		self._cmbAba1.SelectedIndexChanged += self.CmbAba1SelectedIndexChanged
		# 
		# gpDiretorio2
		# 
		self._gpDiretorio2.Controls.Add(self._tvDiretorio2)
		self._gpDiretorio2.Controls.Add(self._cmbAba2)
		self._gpDiretorio2.Location = System.Drawing.Point(347, 43)
		self._gpDiretorio2.Name = "gpDiretorio2"
		self._gpDiretorio2.Size = System.Drawing.Size(329, 284)
		self._gpDiretorio2.TabIndex = 2
		self._gpDiretorio2.TabStop = False
		self._gpDiretorio2.Text = "Diretório 2"
		# 
		# tvDiretorio2
		# 
		self._tvDiretorio2.ImageIndex = 0
		self._tvDiretorio2.ImageList = self._imageList1
		self._tvDiretorio2.Location = System.Drawing.Point(6, 46)
		self._tvDiretorio2.Name = "tvDiretorio2"
		self._tvDiretorio2.SelectedImageIndex = 0
		self._tvDiretorio2.Size = System.Drawing.Size(317, 232)
		self._tvDiretorio2.TabIndex = 1
		# 
		# cmbAba2
		# 
		self._cmbAba2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		self._cmbAba2.FormattingEnabled = True
		self._cmbAba2.Location = System.Drawing.Point(6, 19)
		self._cmbAba2.Name = "cmbAba2"
		self._cmbAba2.Size = System.Drawing.Size(317, 21)
		self._cmbAba2.TabIndex = 0
		self._cmbAba2.SelectedIndexChanged += self.CmbAba2SelectedIndexChanged
		# 
		# barraStatus
		# 
		self._barraStatus.Items.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._labStatus1,
			self._labStatus2]))
		self._barraStatus.Location = System.Drawing.Point(0, 558)
		self._barraStatus.Name = "barraStatus"
		self._barraStatus.Size = System.Drawing.Size(687, 22)
		self._barraStatus.TabIndex = 10
		self._barraStatus.Text = "statusStrip1"
		# 
		# labStatus1
		# 
		self._labStatus1.AutoSize = False
		self._labStatus1.BorderSides = System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom
		self._labStatus1.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self._labStatus1.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self._labStatus1.Name = "labStatus1"
		self._labStatus1.Size = System.Drawing.Size(200, 17)
		self._labStatus1.Text = "Total de diferenças encontradas:"
		self._labStatus1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# labStatus2
		# 
		self._labStatus2.BorderSides = System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom
		self._labStatus2.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self._labStatus2.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self._labStatus2.Name = "labStatus2"
		self._labStatus2.Size = System.Drawing.Size(441, 17)
		self._labStatus2.Spring = True
		self._labStatus2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# label1
		# 
		self._label1.Location = System.Drawing.Point(8, 330)
		self._label1.Name = "label1"
		self._label1.Size = System.Drawing.Size(138, 18)
		self._label1.TabIndex = 11
		self._label1.Text = "Diferenças Encontradas"
		# 
		# lvCompara
		# 
		self._lvCompara.Columns.AddRange(System.Array[System.Windows.Forms.ColumnHeader](
			[self._columnHeader10,
			self._columnHeader11,
			self._columnHeader12,
			self._columnHeader13,
			self._columnHeader14,
			self._columnHeader15]))
		self._lvCompara.FullRowSelect = True
		self._lvCompara.GridLines = True
		self._lvCompara.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable
		self._lvCompara.Location = System.Drawing.Point(0, 351)
		self._lvCompara.MultiSelect = False
		self._lvCompara.Name = "lvCompara"
		self._lvCompara.Size = System.Drawing.Size(687, 205)
		self._lvCompara.SmallImageList = self._imageList1
		self._lvCompara.TabIndex = 12
		self._lvCompara.UseCompatibleStateImageBehavior = False
		self._lvCompara.View = System.Windows.Forms.View.Details
		# 
		# columnHeader10
		# 
		self._columnHeader10.Text = "Nome"
		self._columnHeader10.Width = 300
		# 
		# columnHeader11
		# 
		self._columnHeader11.Text = "Tamanho"
		self._columnHeader11.Width = 100
		# 
		# columnHeader12
		# 
		self._columnHeader12.Text = "Tipo"
		self._columnHeader12.Width = 70
		# 
		# columnHeader13
		# 
		self._columnHeader13.Text = "Modificado"
		self._columnHeader13.Width = 120
		# 
		# columnHeader14
		# 
		self._columnHeader14.Text = "Atributos"
		self._columnHeader14.Width = 90
		# 
		# columnHeader15
		# 
		self._columnHeader15.Text = "Caminho"
		self._columnHeader15.Width = 300
		# 
		# FrmCompararDiretorio
		# 
		self.AutoScaleDimensions = System.Drawing.SizeF(6, 13)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(687, 580)
		self.Controls.Add(self._lvCompara)
		self.Controls.Add(self._label1)
		self.Controls.Add(self._barraStatus)
		self.Controls.Add(self._gpDiretorio2)
		self.Controls.Add(self._gpDiretorio1)
		self.Controls.Add(self._panel1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MaximizeBox = False
		self.MinimizeBox = False
		self.Name = "FrmCompararDiretorio"
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = "Comparar Diretórios"
		self._panel1.ResumeLayout(False)
		self._gpDiretorio1.ResumeLayout(False)
		self._gpDiretorio2.ResumeLayout(False)
		self._barraStatus.ResumeLayout(False)
		self._barraStatus.PerformLayout()
		self.ResumeLayout(False)
		self.PerformLayout()

	def Dispose(self, disposing):
		if disposing:
			if self._components != None:
				self._components.Dispose()
		self.Dispose(disposing)

	def BtnSalvarLogClick(self, sender, e):
		if self._listaCompara.Count > 0:
			listaLocal = StringList()
			sLog = Rotinas.ExtractFilePath(Application.ExecutablePath) + Path.DirectorySeparatorChar + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) + "_Comparacao.log"
			enumerator = listaCompara.GetEnumerator()
			while enumerator.MoveNext():
				diretorio = enumerator.Current
				listaLocal.Add(diretorio.Caminho)
			listaLocal.SaveToFile(sLog)
			Dialogo.mensagemInfo("Log salvo no mesmo diretório do sistema!")

	def BtnCompararDiretoriosClick(self, sender, e):
		sCaminhoDir1 = ""
		sCaminhoDir2 = ""
		bSelecionado = False
		if tvDiretorio1.SelectedNode.IsSelected:
			self._catalogador.LerArvoreDiretorio(tvDiretorio1.SelectedNode, barraStatus)
			sCaminhoDir1 = labStatus2.Text
			if tvDiretorio2.SelectedNode.IsSelected:
				self._catalogador.LerArvoreDiretorio(tvDiretorio2.SelectedNode, barraStatus)
				sCaminhoDir2 = labStatus2.Text
				bSelecionado = True
		self.LimparComparacao()
		if bSelecionado:
			self.Comparar(sCaminhoDir1, sCaminhoDir2)
		else:
			Dialogo.mensagemInfo("Diretórios não selecionados!")

	def CmbAba1SelectedIndexChanged(self, sender, e):
		Cursor = Cursors.WaitCursor
		tvDiretorio1.Nodes.Clear()
		aba = AbaBO.Instancia.pegaAbaPorOrdem(self._catalogador.listaAbas, cmbAba1.SelectedIndex + 1)
		self._catalogador.CarregarArvore(tvDiretorio1, aba)
		tvDiretorio1.Select()
		self.LimparComparacao()
		Cursor = Cursors.Default

	def CmbAba2SelectedIndexChanged(self, sender, e):
		Cursor = Cursors.WaitCursor
		tvDiretorio2.Nodes.Clear()
		aba = AbaBO.Instancia.pegaAbaPorOrdem(self._catalogador.listaAbas, cmbAba2.SelectedIndex + 1)
		self._catalogador.CarregarArvore(tvDiretorio2, aba)
		tvDiretorio2.Select()
		self.LimparComparacao()
		Cursor = Cursors.Default

	def CarregarDados(self):
		enumerator = self._catalogador.listaAbas.GetEnumerator()
		while enumerator.MoveNext():
			aba = enumerator.Current
			cmbAba1.Items.Add(aba.Nome)
			cmbAba2.Items.Add(aba.Nome)
		cmbAba1.SelectedIndex = 0
		cmbAba2.SelectedIndex = 0

	def LimparComparacao(self):
		pb.Value = 0
		lvCompara.Items.Clear()
		btnSalvarLog.Enabled = False
		labStatus2.Text = ""

	def SQLCompara(self, aba1, aba2, caminho1, caminho2):
		sSQL = DiretorioBO.SQL_CONSULTA_ARQUIVO + " WHERE aba=" + aba1.Codigo + " AND caminho LIKE " + Rotinas.QuotedStr(caminho1 + "%") + " AND nome NOT IN (SELECT nome FROM Diretorios " + " WHERE aba=" + aba2.Codigo + " AND caminho LIKE " + Rotinas.QuotedStr(caminho2 + "%") + ")" + " ORDER BY 1, 2, 3"
		return sSQL

	def Comparar(self, sCaminhoDir1, sCaminhoDir2):
		aba1 = AbaBO.Instancia.pegaAbaPorOrdem(self._catalogador.listaAbas, cmbAba1.SelectedIndex + 1)
		aba2 = AbaBO.Instancia.pegaAbaPorOrdem(self._catalogador.listaAbas, cmbAba2.SelectedIndex + 1)
		sSQL = self.SQLCompara(aba1, aba2, sCaminhoDir1, sCaminhoDir2)
		self._listaCompara = DiretorioBO.Instancia.carregarDiretorio(sSQL, "consultaarquivo", self._frmCompararDiretorioProgresso)
		if self._listaCompara.Count > 0:
			Tabela.Instancia.Carregar(True, lvCompara, self._listaCompara, self._catalogador.listaExtensoes, pb)
			tamLista = self._listaCompara.Count
			labStatus2.Text = tamLista.ToString()
			btnSalvarLog.Enabled = True
		else:
			Dialogo.mensagemInfo("Nenhuma diferença encontrada!")