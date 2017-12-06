/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 11:44
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.gui

import System
import System.IO
import System.Drawing
import System.Windows.Forms
import System.Collections.Generic
import HFSGuardaDiretorio.catalogador
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos
import HFSGuardaDiretorio.objetosbo
import HFSGuardaDiretorio.objetosgui

partial public class FrmCompararDiretorio(Form):

	private frmCompararDiretorioProgresso as FrmCompararDiretorioProgresso

	private final catalogador as Catalogador

	
	public listaCompara as List[of Diretorio]

	
	public def constructor(frmPrincipal as FrmPrincipal):
		//
		// The InitializeComponent() call is required for Windows Forms designer support.
		//
		InitializeComponent()
		
		listaCompara = List[of Diretorio]()
		frmCompararDiretorioProgresso = FrmCompararDiretorioProgresso(self)
		catalogador = frmPrincipal.Catalogador
		CarregarDados()
		LimparComparacao()

	
	private def BtnSalvarLogClick(sender as object, e as EventArgs):
		sLog as string
		listaLocal as StringList
		
		if listaCompara.Count > 0:
			listaLocal = StringList()
			sLog = (((Rotinas.ExtractFilePath(Application.ExecutablePath) + Path.DirectorySeparatorChar) + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now)) + '_Comparacao.log')
			
			for diretorio as Diretorio in listaCompara:
				listaLocal.Add(diretorio.Caminho)
			
			listaLocal.SaveToFile(sLog)
			
			Dialogo.mensagemInfo('Log salvo no mesmo diretório do sistema!')
		

	
	private def BtnCompararDiretoriosClick(sender as object, e as EventArgs):
		sCaminhoDir1 = ''
		sCaminhoDir2 = ''
		bSelecionado as bool
		
		bSelecionado = false
		if tvDiretorio1.SelectedNode.IsSelected:
			catalogador.LerArvoreDiretorio(tvDiretorio1.SelectedNode, barraStatus)
			sCaminhoDir1 = labStatus2.Text
			
			if tvDiretorio2.SelectedNode.IsSelected:
				catalogador.LerArvoreDiretorio(tvDiretorio2.SelectedNode, barraStatus)
				sCaminhoDir2 = labStatus2.Text
				bSelecionado = true
		
		LimparComparacao()
		
		if bSelecionado:
			Comparar(sCaminhoDir1, sCaminhoDir2)
		else:
			Dialogo.mensagemInfo('Diretórios não selecionados!')

	
	private def CmbAba1SelectedIndexChanged(sender as object, e as EventArgs):
		aba as Aba
		
		Cursor = Cursors.WaitCursor
		
		tvDiretorio1.Nodes.Clear()
		aba = AbaBO.Instancia.pegaAbaPorOrdem(catalogador.listaAbas, (cmbAba1.SelectedIndex + 1))
		catalogador.CarregarArvore(tvDiretorio1, aba)
		tvDiretorio1.Select()
		LimparComparacao()
		
		Cursor = Cursors.Default

	
	private def CmbAba2SelectedIndexChanged(sender as object, e as EventArgs):
		aba as Aba
		
		Cursor = Cursors.WaitCursor
		
		tvDiretorio2.Nodes.Clear()
		aba = AbaBO.Instancia.pegaAbaPorOrdem(catalogador.listaAbas, (cmbAba2.SelectedIndex + 1))
		catalogador.CarregarArvore(tvDiretorio2, aba)
		tvDiretorio2.Select()
		LimparComparacao()
		
		Cursor = Cursors.Default

	
	private def CarregarDados():
		for aba as Aba in catalogador.listaAbas:
			cmbAba1.Items.Add(aba.Nome)
			cmbAba2.Items.Add(aba.Nome)
		cmbAba1.SelectedIndex = 0
		cmbAba2.SelectedIndex = 0

	
	private def LimparComparacao():
		pb.Value = 0
		lvCompara.Items.Clear()
		btnSalvarLog.Enabled = false
		labStatus2.Text = ''

	
	private def SQLCompara(aba1 as Aba, aba2 as Aba, caminho1 as string, caminho2 as string) as string:
		sSQL as string
		
		sSQL = (((((((((((DiretorioBO.SQL_CONSULTA_ARQUIVO + ' WHERE aba=') + aba1.Codigo) + ' AND caminho LIKE ') + Rotinas.QuotedStr((caminho1 + '%'))) + ' AND nome NOT IN (SELECT nome FROM Diretorios ') + ' WHERE aba=') + aba2.Codigo) + ' AND caminho LIKE ') + Rotinas.QuotedStr((caminho2 + '%'))) + ')') + ' ORDER BY 1, 2, 3')
		return sSQL

	
	private def Comparar(sCaminhoDir1 as string, sCaminhoDir2 as string):
		sSQL as string
		aba1 as Aba
		aba2 as Aba
		tamLista as int
		
		aba1 = AbaBO.Instancia.pegaAbaPorOrdem(catalogador.listaAbas, (cmbAba1.SelectedIndex + 1))
		aba2 = AbaBO.Instancia.pegaAbaPorOrdem(catalogador.listaAbas, (cmbAba2.SelectedIndex + 1))
		
		sSQL = SQLCompara(aba1, aba2, sCaminhoDir1, sCaminhoDir2)
		listaCompara = DiretorioBO.Instancia.carregarDiretorio(sSQL, 'consultaarquivo', frmCompararDiretorioProgresso)
		
		if listaCompara.Count > 0:
			Tabela.Instancia.Carregar(true, lvCompara, listaCompara, catalogador.listaExtensoes, pb)
			
			tamLista = listaCompara.Count
			labStatus2.Text = tamLista.ToString()
			btnSalvarLog.Enabled = true
		else:
			Dialogo.mensagemInfo('Nenhuma diferença encontrada!')
	

