/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 11:58
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.gui

import System
import System.IO
import System.Drawing
import System.Windows.Forms
import HFSGuardaDiretorio.catalogador
import HFSGuardaDiretorio.objetos
import HFSGuardaDiretorio.objetosgui
import HFSGuardaDiretorio.objetosbo
import HFSGuardaDiretorio.comum

partial public class FrmCadExtensao(Form):

	private final catalogador as Catalogador

	
	public def constructor(frmPrincipal as FrmPrincipal):
		//
		// The InitializeComponent() call is required for Windows Forms designer support.
		//
		InitializeComponent()
		
		odEscolhaArquivo.Filter = Rotinas.FILTRO_IMAGEM
		
		catalogador = frmPrincipal.Catalogador
		CarregarExtensoesNaGrid()

	
	private def CarregarExtensoesNaGrid():
		item as ListViewItem
		
		lvExtensao.Items.Clear()
		imgListExtensao.Images.Clear()
		
		for extensao as Extensao in catalogador.listaExtensoes:
			item = lvExtensao.Items.Add(extensao.Nome)
			item.SubItems.Add('icone')
			imgListExtensao.Images.Add(Rotinas.byteArrayToBitmap(extensao.Bmp16))

	
	private def LvExtensaoDrawColumnHeader(sender as object, e as DrawListViewColumnHeaderEventArgs):
		e.DrawDefault = true

	
	private def LvExtensaoDrawItem(sender as object, e as DrawListViewItemEventArgs):
		e.DrawBackground()
		
		if (e.State & ListViewItemStates.Selected) == ListViewItemStates.Selected:
			e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
			e.Item.ForeColor = SystemColors.HighlightText
		else:
			e.Item.ForeColor = SystemColors.WindowText
		
		e.DrawText()

	
	private def LvExtensaoDrawSubItem(sender as object, e as DrawListViewSubItemEventArgs):
		if e.ColumnIndex > 0:
			e.DrawBackground()
			
			if (e.ItemState & ListViewItemStates.Selected) == ListViewItemStates.Selected:
				e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
				e.SubItem.ForeColor = SystemColors.HighlightText
			else:
				e.SubItem.ForeColor = SystemColors.WindowText
			
			rect = Rectangle((e.SubItem.Bounds.Left + 20), e.SubItem.Bounds.Top, e.SubItem.Bounds.Width, e.SubItem.Bounds.Height)
			e.Graphics.DrawImageUnscaled(imgListExtensao.Images[e.ItemIndex], rect)

	
	
	private def MenuIncluirExtensaoClick(sender as object, e as EventArgs):
		log as StringList
		retval as DialogResult = odEscolhaArquivo.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(odEscolhaArquivo.FileName)
			if arquivo.Exists:
				log = StringList()
				
				if ExtensaoBO.Instancia.SalvarExtensao(catalogador.listaExtensoes, arquivo.Name, arquivo.FullName, log):
					
					CarregarExtensoesNaGrid()
					
					Dialogo.mensagemInfo('Extensão salva com sucesso!')
				else:
					Dialogo.mensagemInfo('Extensão já existe cadastrada!')
		

	
	private def MenuExcluirExtensaoClick(sender as object, e as EventArgs):
		extensao as Extensao
		
		if catalogador.listaExtensoes.Count > 0:
			res as bool = Dialogo.confirma('Tem Certeza, que você deseja excluir esta extensão?')
			if res:
				extensao = ExtensaoBO.Instancia.pegaExtensaoPorOrdem(catalogador.listaExtensoes, (lvExtensao.SelectedIndices[0] + 1))
				
				if ExtensaoBO.Instancia.excluirExtensao(catalogador.listaExtensoes, extensao.Codigo):
					CarregarExtensoesNaGrid()
					Dialogo.mensagemInfo('Extensão excluída com sucesso!')
		

	
	private def MenuExcluirTodasExtensoesClick(sender as object, e as EventArgs):
		res as bool = Dialogo.confirma('Tem Certeza, que você deseja excluir todas as extensões?')
		if res:
			if ExtensaoBO.Instancia.excluirTodasExtensoes(catalogador.listaExtensoes):
				CarregarExtensoesNaGrid()
				Dialogo.mensagemInfo('Extensões excluídas com sucesso!')

	
	private def MenuExportarBitmapClick(sender as object, e as EventArgs):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teBMP, catalogador.listaExtensoes)

	
	private def MenuExportarIconeClick(sender as object, e as EventArgs):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teICO, catalogador.listaExtensoes)

	
	private def MenuExportarGIFClick(sender as object, e as EventArgs):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teGIF, catalogador.listaExtensoes)

	
	private def MenuExportarJPEGClick(sender as object, e as EventArgs):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teJPG, catalogador.listaExtensoes)

	
	private def MenuExportarPNGClick(sender as object, e as EventArgs):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.tePNG, catalogador.listaExtensoes)

	
	private def MenuExportarTIFFClick(sender as object, e as EventArgs):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teTIF, catalogador.listaExtensoes)

	
	private def MenuImportarIconesArquivosClick(sender as object, e as EventArgs):
		retval as DialogResult = odEscolhaArquivo.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(odEscolhaArquivo.FileName)
			if arquivo.Exists:
				ExtensaoBO.Instancia.ImportarExtensao(arquivo.FullName, catalogador.listaExtensoes)
				CarregarExtensoesNaGrid()

	
	private def MenuExtrairIconesArquivosClick(sender as object, e as EventArgs):
		retval as DialogResult = odEscolhaArquivo.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(odEscolhaArquivo.FileName)
			if arquivo.Exists:
				ExtensaoBO.Instancia.ExtrairExtensao(arquivo.FullName, catalogador.listaExtensoes)
				CarregarExtensoesNaGrid()

	
	private def BtnIncluirClick(sender as object, e as EventArgs):
		MenuIncluirExtensaoClick(sender, e)

	
	private def BtnExcluirClick(sender as object, e as EventArgs):
		MenuExcluirExtensaoClick(sender, e)

