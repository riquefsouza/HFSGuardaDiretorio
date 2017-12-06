/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 11:24
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.gui

import System
import System.IO
import System.Drawing
import System.Collections.Generic
import System.Windows.Forms
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos
import HFSGuardaDiretorio.objetosbo
import HFSGuardaDiretorio.objetosgui
import HFSGuardaDiretorio.catalogador

partial public class FrmImportarDiretorio(Form):

	private final frmPrincipal as FrmPrincipal

	private final frmImportarDiretorioProgresso as FrmImportarDiretorioProgresso

	private final catalogador as Catalogador

	
	public bSubDiretorio as bool

	public listaImportar as List[of Importar]

	public listaDiretorio as List[of Diretorio]

	
	public def constructor(frmPrincipal as FrmPrincipal):
		//
		// The InitializeComponent() call is required for Windows Forms designer support.
		//
		InitializeComponent()
		
		frmImportarDiretorioProgresso = FrmImportarDiretorioProgresso(self)
		listaImportar = List[of Importar]()
		
		self.frmPrincipal = frmPrincipal
		catalogador = frmPrincipal.Catalogador

	
	private def FrmImportarDiretorioShown(sender as object, e as EventArgs):
		sLog as string
		
		for importar as Importar in self.listaImportar:
			catalogador.diretorioOrdem.Ordem = 1
			
			if not bSubDiretorio:
				Cursor = Cursors.WaitCursor
				
				try:
					ImportarBO.Instancia.ImportacaoCompleta(importar, catalogador.diretorioOrdem, catalogador.listaExtensoes, frmImportarDiretorioProgresso)
				except ex as Exception:
					Dialogo.mensagemErro(ex.Message)
				
				Cursor = Cursors.Default
			elif not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, catalogador.listaDiretorioPai):
				Cursor = Cursors.WaitCursor
				
				try:
					ImportarBO.Instancia.ImportacaoCompleta(importar, catalogador.diretorioOrdem, catalogador.listaExtensoes, frmImportarDiretorioProgresso)
				except ex as Exception:
					Dialogo.mensagemErro(ex.Message)
				
				Cursor = Cursors.Default
			else:
				Dialogo.mensagemInfo('O diretório já existe no catálogo!')
		
		if frmPrincipal.menuGravarLogImportacao.Selected:
			if memoImportaDir.Lines.Length > 0:
				sLog = (((Rotinas.ExtractFilePath(Application.ExecutablePath) + Path.DirectorySeparatorChar) + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now)) + '_Importacao.log')
				
				log = StringList()
				log.AddRange(memoImportaDir.Lines)
				log.SaveToFile(sLog)
		
		self.Close()
		
	

