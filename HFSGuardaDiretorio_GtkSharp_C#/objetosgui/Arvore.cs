/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 08/07/2015
 * Time: 10:51
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using Gtk;
using System.Collections.Generic;

namespace HFSGuardaDiretorio.objetosgui
{
	/// <summary>
	/// Description of Arvore.
	/// </summary>
	public sealed class Arvore
	{
		private static Arvore instancia = new Arvore();
		
		public static Arvore Instancia {
			get {
				return instancia;
			}
		}
		
		private Arvore()
		{
		}

		public void Construir(TreeView tvArvore){
			TreeStore storeArvore;
			TreeViewColumn tvColuna;
			CellRendererPixbuf pixbufRender;
			CellRendererText tvcolunaCell;

			tvColuna = new TreeViewColumn ();
			tvColuna.Title = "coluna";

			pixbufRender = new CellRendererPixbuf();
			tvColuna.PackStart(pixbufRender, false);
			tvColuna.AddAttribute(pixbufRender, "pixbuf", 0);

			tvcolunaCell = new CellRendererText ();
			tvColuna.PackStart(tvcolunaCell, true);
			tvColuna.AddAttribute(tvcolunaCell, "text", 1);

			tvArvore.AppendColumn(tvColuna);
			tvArvore.HeadersVisible = false;
			tvArvore.Selection.Mode = SelectionMode.Single;

			storeArvore = new TreeStore(typeof (Gdk.Pixbuf), typeof (string));
			tvArvore.Model = storeArvore;
		}

		public void selecionarPrimeiroItem(TreeView tvArvore){
			TreeIter iter;
			TreeStore store = (TreeStore)tvArvore.Model;
			store.GetIterFirst (out iter);
			tvArvore.Selection.SelectIter(iter);
		}

		public TreePath encontrarCaminhoPorNome(TreeView tvArvore, string[] nomes) {
			TreeStore arvoreStore = (TreeStore) tvArvore.Model;
			TreeIter raiz;

			if (arvoreStore.GetIterFirst (out raiz)) {
				raiz = encontrarCaminho(arvoreStore, raiz, nomes, 0);
				return arvoreStore.GetPath (raiz);
			}
			return null;
		}

		public TreeIter encontrarCaminho(TreeStore arvoreStore, TreeIter pai, string[] nomes, int nivel) {
			TreeIter filho;
			bool bValido;
			string valorPai;

			bValido = arvoreStore.IterIsValid (pai);
			if (bValido) {
				while (bValido) {
					valorPai = (string)arvoreStore.GetValue (pai, 1);
					if (valorPai.Equals (nomes [nivel])) {
				
						if (nivel == (nomes.Length - 1)) {
							return pai;
						}

						if (arvoreStore.IterHasChild (pai)) {
							arvoreStore.IterChildren (out filho, pai);

							return encontrarCaminho (arvoreStore, filho, nomes, nivel + 1);
						}

					}

					bValido = arvoreStore.IterNext (ref pai);
				}
			}

			return pai;
		}

	}
}
