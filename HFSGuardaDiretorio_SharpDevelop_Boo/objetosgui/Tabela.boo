/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 08/07/2015
 * Time: 10:45
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosgui

import System
import System.Collections.Generic
import System.Windows.Forms
import HFSGuardaDiretorio.objetos
import HFSGuardaDiretorio.objetosbo

public final class Tabela:

	private static instancia = Tabela()

	
	public static Instancia as Tabela:
		get:
			return instancia

	
	private def constructor():
		pass

	
	public def AdicionaItemLista(bTabelaDir as bool, lvTabela as ListView, dir as Diretorio, extensoes as List[of Extensao]):
		item as ListViewItem
		
		item = lvTabela.Items.Add(dir.Nome)
		if dir.Tipo.Codigo == char('D'):
			item.SubItems.Add('')
			item.ImageIndex = 0
		else:
			item.SubItems.Add(dir.TamanhoFormatado)
			item.ImageIndex = ExtensaoBO.Instancia.indiceExtensao(extensoes, dir.Nome)
		item.SubItems.Add(dir.Tipo.Nome)
		item.SubItems.Add(dir.ModificadoFormatado)
		item.SubItems.Add(dir.Atributos)
		item.SubItems.Add(dir.Caminho)
		if not bTabelaDir:
			item.SubItems.Add(dir.Aba.Nome)

	
	public def Carregar(bTabelaDir as bool, lvTabela as ListView, diretorios as List[of Diretorio], extensoes as List[of Extensao], pb as ProgressBar):
		if diretorios.Count > 0:
			pb.Minimum = 0
			pb.Maximum = diretorios.Count
			pb.Value = 0
			pb.Step = 1
			
			for dir as Diretorio in diretorios:
				AdicionaItemLista(bTabelaDir, lvTabela, dir, extensoes)
				pb.Value += 1

	
	public def encontrarLinha(lvTabela as ListView, nome as string) as int:
		slinha as string
		nlinha = 0
		for i in range(0, lvTabela.Items.Count):
			slinha = lvTabela.Items[i].SubItems[0].Text
			if slinha.Equals(nome):
				nlinha = i
				break 
		return nlinha

	
	public def getLinhaSelecionada(lvTabela as ListView, bTabelaDir as bool) as Diretorio:
		dir as Diretorio = null
		
		if lvTabela.SelectedItems.Count > 0:
			dir = Diretorio()
			dir.Nome = lvTabela.SelectedItems[0].SubItems[0].Text
			dir.TamanhoFormatado = lvTabela.SelectedItems[0].SubItems[1].Text
			dir.Tipo = Tipo(char('D'), lvTabela.SelectedItems[0].SubItems[2].Text)
			dir.ModificadoFormatado = lvTabela.SelectedItems[0].SubItems[3].Text
			dir.Atributos = lvTabela.SelectedItems[0].SubItems[4].Text
			dir.Caminho = lvTabela.SelectedItems[0].SubItems[5].Text
			if bTabelaDir:
				dir.Aba.Nome = lvTabela.SelectedItems[0].SubItems[6].Text
		
		return dir
	

