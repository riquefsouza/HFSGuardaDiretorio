/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 11:11
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.gui

import System
import System.Drawing
import System.Windows.Forms
import HFSGuardaDiretorio.objetos

partial public class FrmInfoDiretorio(Form):

	private fonte as Font

	
	public def constructor():
		//
		// The InitializeComponent() call is required for Windows Forms designer support.
		//
		InitializeComponent()
		
		fonte = Font(lvInfo.Items[0].Font, FontStyle.Bold)

	
	private def BtnOkClick(sender as object, e as EventArgs):
		self.Close()

	
	public def setDiretorio(diretorio as Diretorio):
		if diretorio is not null:
			lvInfo.Items[0].SubItems.Add(diretorio.Aba.Nome)
			lvInfo.Items[1].SubItems.Add(diretorio.Nome)
			lvInfo.Items[2].SubItems.Add(diretorio.TamanhoFormatado)
			lvInfo.Items[3].SubItems.Add(diretorio.Tipo.Nome)
			lvInfo.Items[4].SubItems.Add(diretorio.ModificadoFormatado)
			lvInfo.Items[5].SubItems.Add(diretorio.Atributos)
			lvInfo.Items[6].SubItems.Add(diretorio.Caminho)
			
			lvInfo.Columns[1].Width = (diretorio.Caminho.Length * 8)

	
	
	private def LvInfoDrawColumnHeader(sender as object, e as DrawListViewColumnHeaderEventArgs):
		e.DrawDefault = true

	
	private def LvInfoDrawItem(sender as object, e as DrawListViewItemEventArgs):
		e.DrawBackground()
		
		if (e.State & ListViewItemStates.Selected) == ListViewItemStates.Selected:
			e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
			e.Item.ForeColor = SystemColors.HighlightText
		else:
			e.Item.ForeColor = SystemColors.WindowText
		
		e.Item.Font = fonte
		
		e.DrawText()

	
	private def LvInfoDrawSubItem(sender as object, e as DrawListViewSubItemEventArgs):
		e.DrawBackground()
		
		if (e.ItemState & ListViewItemStates.Selected) == ListViewItemStates.Selected:
			e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
			e.SubItem.ForeColor = SystemColors.HighlightText
		else:
			e.SubItem.ForeColor = SystemColors.WindowText
		
		e.DrawText()

