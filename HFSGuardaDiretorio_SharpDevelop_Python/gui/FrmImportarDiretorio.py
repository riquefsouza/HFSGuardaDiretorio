
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

class FrmImportarDiretorio(Form):
	def __init__(self, frmPrincipal):
		self._components = None
		self.InitializeComponent()
		self._frmImportarDiretorioProgresso = FrmImportarDiretorioProgresso(self)
		self._listaImportar = List[Importar]()
		self._frmPrincipal = frmPrincipal
		self._catalogador = frmPrincipal.Catalogador

	def InitializeComponent(self):
		self._memoImportaDir = System.Windows.Forms.TextBox()
		self._barraStatus = System.Windows.Forms.StatusStrip()
		self._labStatus1 = System.Windows.Forms.ToolStripStatusLabel()
		self._labStatus2 = System.Windows.Forms.ToolStripStatusLabel()
		self._pbImportar = System.Windows.Forms.ProgressBar()
		self._barraStatus.SuspendLayout()
		self.SuspendLayout()
		# 
		# memoImportaDir
		# 
		self._memoImportaDir.Dock = System.Windows.Forms.DockStyle.Top
		self._memoImportaDir.Location = System.Drawing.Point(0, 0)
		self._memoImportaDir.Multiline = True
		self._memoImportaDir.Name = "memoImportaDir"
		self._memoImportaDir.ScrollBars = System.Windows.Forms.ScrollBars.Both
		self._memoImportaDir.Size = System.Drawing.Size(889, 505)
		self._memoImportaDir.TabIndex = 0
		# 
		# barraStatus
		# 
		self._barraStatus.Items.AddRange(System.Array[System.Windows.Forms.ToolStripItem]([self._labStatus1, self._labStatus2]))
		self._barraStatus.Location = System.Drawing.Point(0, 522)
		self._barraStatus.Name = "barraStatus"
		self._barraStatus.Size = System.Drawing.Size(889, 22)
		self._barraStatus.TabIndex = 9
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
		self._labStatus1.Text = "Total de linhas sendo processadas:"
		self._labStatus1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# labStatus2
		# 
		self._labStatus2.BorderSides = System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom
		self._labStatus2.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self._labStatus2.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self._labStatus2.Name = "labStatus2"
		self._labStatus2.Size = System.Drawing.Size(643, 17)
		self._labStatus2.Spring = True
		self._labStatus2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# pbImportar
		# 
		self._pbImportar.Dock = System.Windows.Forms.DockStyle.Bottom
		self._pbImportar.Location = System.Drawing.Point(0, 505)
		self._pbImportar.Name = "pbImportar"
		self._pbImportar.Size = System.Drawing.Size(889, 17)
		self._pbImportar.Step = 1
		self._pbImportar.TabIndex = 10
		# 
		# FrmImportarDiretorio
		# 
		self.AutoScaleDimensions = System.Drawing.SizeF(6, 13)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(889, 544)
		self.ControlBox = False
		self.Controls.Add(self._pbImportar)
		self.Controls.Add(self._barraStatus)
		self.Controls.Add(self._memoImportaDir)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MaximizeBox = False
		self.MinimizeBox = False
		self.Name = "FrmImportarDiretorio"
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = "Importando Diretório"
		self.Shown += self.FrmImportarDiretorioShown
		self._barraStatus.ResumeLayout(False)
		self._barraStatus.PerformLayout()
		self.ResumeLayout(False)
		self.PerformLayout()

	def Dispose(self, disposing):
		if disposing:
			if self._components != None:
				self._components.Dispose()
		self.Dispose(disposing)

	def FrmImportarDiretorioShown(self, sender, e):
		enumerator = self._listaImportar.GetEnumerator()
		while enumerator.MoveNext():
			importar = enumerator.Current
			self._catalogador.diretorioOrdem.Ordem = 1
			if not self._bSubDiretorio:
				Cursor = Cursors.WaitCursor
				try:
					ImportarBO.Instancia.ImportacaoCompleta(importar, self._catalogador.diretorioOrdem, self._catalogador.listaExtensoes, self._frmImportarDiretorioProgresso)
				except Exception, ex:
					Dialogo.mensagemErro(ex.Message)
				
				Cursor = Cursors.Default
			else:
				if not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, self._catalogador.listaDiretorioPai):
					Cursor = Cursors.WaitCursor
					try:
						ImportarBO.Instancia.ImportacaoCompleta(importar, self._catalogador.diretorioOrdem, self._catalogador.listaExtensoes, self._frmImportarDiretorioProgresso)
					except Exception, ex:
						Dialogo.mensagemErro(ex.Message)
					
					Cursor = Cursors.Default
				else:
					Dialogo.mensagemInfo("O diretório já existe no catálogo!")
		if self._frmPrincipal.menuGravarLogImportacao.Selected:
			if memoImportaDir.Lines.Length > 0:
				sLog = Rotinas.ExtractFilePath(Application.ExecutablePath) + Path.DirectorySeparatorChar + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) + "_Importacao.log"
				log = StringList()
				log.AddRange(memoImportaDir.Lines)
				log.SaveToFile(sLog)
		self.Close()