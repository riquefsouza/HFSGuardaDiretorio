/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 09/07/2015
 * Time: 17:06
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosgui

import System
import System.Collections
import System.Windows.Forms

public class TabelaItemComparer(IComparer):

	private col as int

	private ordem as SortOrder

	
	public def constructor():
		col = 0
		ordem = SortOrder.Ascending

	
	public def constructor(coluna as int, ordem as SortOrder):
		col = coluna
		self.ordem = ordem

	
	public def Compare(x as object, y as object) as int:
		retornoVal as int = (-1)
		retornoVal = String.Compare((x cast ListViewItem).SubItems[col].Text, (y cast ListViewItem).SubItems[col].Text)
		
		if ordem == SortOrder.Ascending:
			retornoVal *= (-1)
		
		return retornoVal

