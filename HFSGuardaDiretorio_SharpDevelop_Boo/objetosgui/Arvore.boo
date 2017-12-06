/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 08/07/2015
 * Time: 10:51
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosgui

import System
import System.Windows.Forms

public final class Arvore:

	private static instancia = Arvore()

	
	public static Instancia as Arvore:
		get:
			return instancia

	
	private def constructor():
		pass

	
	public def encontrarCaminhoPorNome(tvArvore as TreeView, nomes as (string)) as TreeNode:
		for item as TreeNode in tvArvore.Nodes:
			if item.Text.Equals(nomes[0]):
				return encontrarCaminho(item, nomes, 0)
		return null

	
	public def encontrarCaminho(pai as TreeNode, nomes as (string), nivel as int) as TreeNode:
		if pai.Text.Equals(nomes[nivel]):
			
			if nivel == (nomes.Length - 1):
				return pai
			
			if pai.GetNodeCount(true) > 0:
				for filho as TreeNode in pai.Nodes:
					res as TreeNode = encontrarCaminho(filho, nomes, (nivel + 1))
					
					if res is not null:
						return res
		return null
	

