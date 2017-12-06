/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 10/12/2014
 * Time: 17:39
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.gui

import System
import System.Collections.Generic
import System.Drawing
import System.Windows.Forms
import HFSGuardaDiretorio.catalogador
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetosgui

partial public class FrmPrincipal(Form):

	private frmPrincipalProgresso as FrmPrincipalProgresso

	private final catalogador as Catalogador

	private colOrdem as int

	
	public def constructor():
		colOrdem = (-1)
		//
		// The InitializeComponent() call is required for Windows Forms designer support.
		//
		InitializeComponent()
		
		frmPrincipalProgresso = FrmPrincipalProgresso(self)
		catalogador = Catalogador(self)

	
	public Catalogador as Catalogador:
		get:
			return catalogador

	
	private def MenuIncluirNovaAbaClick(sender as object, e as EventArgs):
		catalogador.IncluirNovaAba()

	
	private def MenuAlterarNomeAbaAtivaClick(sender as object, e as EventArgs):
		catalogador.AlterarNomeAbaAtiva(frmPrincipalProgresso)

	
	private def MenuExcluirAbaAtivaClick(sender as object, e as EventArgs):
		catalogador.ExcluirAbaAtiva(frmPrincipalProgresso)

	
	private def MenuImportarDiretorioClick(sender as object, e as EventArgs):
		catalogador.ComecaImportacao(false, frmPrincipalProgresso)

	
	private def MenuImportarSubDiretoriosClick(sender as object, e as EventArgs):
		catalogador.ComecaImportacao(true, frmPrincipalProgresso)

	
	private def MenuCadastrarExtensaoArquivoClick(sender as object, e as EventArgs):
		frmCadExtensao = FrmCadExtensao(self)
		frmCadExtensao.ShowDialog()

	
	private def MenuCompararDiretoriosClick(sender as object, e as EventArgs):
		frmCompararDiretorio = FrmCompararDiretorio(self)
		frmCompararDiretorio.ShowDialog()

	
	private def MenuSobreCatalogadorClick(sender as object, e as EventArgs):
		frmSobre = FrmSobre()
		frmSobre.ShowDialog()

	
	private def MenuExpandirDiretoriosClick(sender as object, e as EventArgs):
		catalogador.getArvoreAtual().ExpandAll()

	
	private def MenuColapsarDiretoriosClick(sender as object, e as EventArgs):
		catalogador.getArvoreAtual().CollapseAll()

	
	private def MenuTXTClick(sender as object, e as EventArgs):
		catalogador.ExportarArquivo(TipoExportar.teTXT, frmPrincipalProgresso)

	
	private def MenuCSVClick(sender as object, e as EventArgs):
		catalogador.ExportarArquivo(TipoExportar.teCSV, frmPrincipalProgresso)

	
	private def MenuHTMLClick(sender as object, e as EventArgs):
		catalogador.ExportarArquivo(TipoExportar.teHTML, frmPrincipalProgresso)

	
	private def MenuXMLClick(sender as object, e as EventArgs):
		catalogador.ExportarArquivo(TipoExportar.teXML, frmPrincipalProgresso)

	
	private def MenuSQLClick(sender as object, e as EventArgs):
		catalogador.ExportarArquivo(TipoExportar.teSQL, frmPrincipalProgresso)

	
	private def MenuImportarDiretoriosViaXMLClick(sender as object, e as EventArgs):
		log = StringList()
		catalogador.ImportarArquivo(log, frmPrincipalProgresso)

	
	private def MenuMostrarOcultArvoreDirAbaAtivaClick(sender as object, e as EventArgs):
		catalogador.mostrarOcultarArvore()

	
	private def MenuMostrarOcultarListaItensPesquisadosClick(sender as object, e as EventArgs):
		spPesquisa.Panel2Collapsed = (not spPesquisa.Panel2Collapsed)

	
	private def BtnImportarDiretorioClick(sender as object, e as EventArgs):
		MenuImportarDiretorioClick(sender, e)

	
	private def BtnPesquisarClick(sender as object, e as EventArgs):
		catalogador.Pesquisar()

	
	private def FrmPrincipalFormClosed(sender as object, e as FormClosedEventArgs):
		Rotinas.Desconectar()

	
	private def MenuInformacoesDiretorioArquivoClick(sender as object, e as EventArgs):
		catalogador.InformacoesDiretorioArquivo()

	
	private def MenuExcluirDiretorioSelecionadoClick(sender as object, e as EventArgs):
		catalogador.ExcluirDiretorioSelecionado(frmPrincipalProgresso)

	
	private def MenuIconesClick(sender as object, e as EventArgs):
		catalogador.getTabelaAtual().View = View.LargeIcon

	
	private def MenuListaClick(sender as object, e as EventArgs):
		catalogador.getTabelaAtual().View = View.List

	
	private def MenuDetalhesClick(sender as object, e as EventArgs):
		catalogador.getTabelaAtual().View = View.Details

	
	private def MenuIconesPequenosClick(sender as object, e as EventArgs):
		catalogador.getTabelaAtual().View = View.SmallIcon

	
	private def MenuExpandirDiretorios2Click(sender as object, e as EventArgs):
		MenuExpandirDiretoriosClick(sender, e)

	
	private def MenuColapsarDiretorios2Click(sender as object, e as EventArgs):
		MenuColapsarDiretoriosClick(sender, e)

	
	private def MenuIncluirNovaAba2Click(sender as object, e as EventArgs):
		MenuIncluirNovaAbaClick(sender, e)

	
	private def MenuAlterarNomeAbaAtiva2Click(sender as object, e as EventArgs):
		MenuAlterarNomeAbaAtivaClick(sender, e)

	
	private def MenuExcluirAbaAtiva2Click(sender as object, e as EventArgs):
		MenuExcluirAbaAtivaClick(sender, e)

	
	private def TabControl1SelectedIndexChanged(sender as object, e as EventArgs):
		catalogador.tabPanelMudou()

	
	public def LvFixaDoubleClick(sender as object, e as EventArgs):
		lvTabela = (sender cast ListView)
		
		if lvTabela.SelectedItems.Count > 0:
			nome as string = lvTabela.SelectedItems[0].Text
			tipo as string = lvTabela.SelectedItems[0].SubItems[2].Text
			
			catalogador.DuploCliqueLista(nome, tipo)

	
	public def LvFixaColumnClick(sender as object, e as ColumnClickEventArgs):
		lvTabela = (sender cast ListView)
		colOrdem = catalogador.listaCompara(lvTabela, e.Column, colOrdem)

	
	private def LvPesquisaColumnClick(sender as object, e as ColumnClickEventArgs):
		lvTabela = (sender cast ListView)
		colOrdem = catalogador.listaCompara(lvTabela, e.Column, colOrdem)

	
	private def LvPesquisaClick(sender as object, e as EventArgs):
		lvPesquisa = (sender cast ListView)
		
		if lvPesquisa.SelectedItems.Count > 0:
			nome as string = lvPesquisa.SelectedItems[0].Text
			caminho as string = lvPesquisa.SelectedItems[0].SubItems[5].Text
			nomeAba as string = lvPesquisa.SelectedItems[0].SubItems[6].Text
			
			catalogador.EncontrarItemLista(nomeAba, nome, caminho)

	
	public def TvFixaAfterSelect(sender as object, e as TreeViewEventArgs):
		lvTabela as ListView = catalogador.getTabelaAtual()
		catalogador.ListarArquivos(lvTabela, e.Node)
	

