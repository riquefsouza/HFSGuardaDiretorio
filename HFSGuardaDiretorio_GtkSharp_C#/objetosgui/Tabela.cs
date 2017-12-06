/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 08/07/2015
 * Time: 10:45
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Collections.Generic;
using Gtk;
using HFSGuardaDiretorio.comum;
using HFSGuardaDiretorio.objetos;
using HFSGuardaDiretorio.objetosbo;
	
namespace HFSGuardaDiretorio.objetosgui
{
	/// <summary>
	/// Description of Tabela.
	/// </summary>
	public sealed class Tabela
	{
		private static Tabela instancia = new Tabela();
		
		public static Tabela Instancia {
			get {
				return instancia;
			}
		}
		
		private Tabela()
		{
		}

		public void Construir(bool bTabelaDir, NodeView lvTabela){
			ListStore lstore;
			TreeViewColumn tvColuna;
			CellRendererPixbuf pixbufRender;
			CellRendererText tvcolunaCell;

			tvColuna = new TreeViewColumn();
			tvColuna.Title = "Nome";

			pixbufRender = new CellRendererPixbuf();
			tvColuna.PackStart(pixbufRender, false);
			tvColuna.AddAttribute(pixbufRender, "pixbuf", 0);

			tvcolunaCell = new CellRendererText ();
			tvColuna.PackStart(tvcolunaCell, true);
			tvColuna.AddAttribute(tvcolunaCell, "text", 1);

			lvTabela.AppendColumn(tvColuna);
			lvTabela.AppendColumn("Tamanho", new Gtk.CellRendererText (), "text", 2);
			lvTabela.AppendColumn("Tipo", new Gtk.CellRendererText (), "text", 3);
			lvTabela.AppendColumn("Modificado", new Gtk.CellRendererText (), "text", 4);
			lvTabela.AppendColumn("Atributos", new Gtk.CellRendererText (), "text", 5);
			lvTabela.AppendColumn("Caminho", new Gtk.CellRendererText (), "text", 6);

			int[] tamanhos = new int[]{ 300, 100, 70, 120, 90, 300 };

			for (int i = 0; i < tamanhos.Length; i++) {
				//lvTabela.Columns[i].MinWidth = tamanhos[i];
				lvTabela.Columns[i].SortColumnId = i+1;
				lvTabela.Columns[i].Resizable = true;
				lvTabela.Columns[i].Sizing = TreeViewColumnSizing.Autosize;
			}

			if (bTabelaDir) {
				lstore = new ListStore(typeof(Gdk.Pixbuf), typeof(string), typeof(string),
					typeof(string), typeof(string), typeof(string), typeof(string));
			} else {
				lvTabela.AppendColumn ("Aba", new Gtk.CellRendererText (), "text", 7);
				//lvTabela.Columns[6].MinWidth = 150;
				lvTabela.Columns[6].SortColumnId = 7;
				lvTabela.Columns[6].Resizable = true;
				lvTabela.Columns[6].Sizing = TreeViewColumnSizing.Autosize;

				lstore = new ListStore (typeof(Gdk.Pixbuf), typeof(string), typeof(string),
					typeof(string), typeof(string), typeof(string), typeof(string),
					typeof(string));
			}

			lvTabela.Selection.Mode = SelectionMode.Single;
			lvTabela.Model = lstore;
			lvTabela.ColumnsAutosize();
		}
		
		public void AdicionaItemLista(bool bTabelaDir, NodeView lvTabela, Diretorio dir,
		                             List<Extensao> extensoes){
			ListStore lstore = (ListStore)lvTabela.Model;
			List<object> lista = new List<object>();
			Gdk.Pixbuf icone;

			if (dir.Tipo.Codigo == 'D') {
				icone = Rotinas.LerArquivoPixbuf ("diretorio.gif");
				lista.Add(icone);
			} else {
				icone = ExtensaoBO.Instancia.pixbufExtensao(extensoes, dir.Nome);
				lista.Add(icone);
			}

			lista.Add(dir.Nome);
			if (dir.Tipo.Codigo=='D'){
				lista.Add("");
			} else {
				lista.Add(dir.TamanhoFormatado);
			}
			lista.Add(dir.Tipo.Nome);
			lista.Add(dir.ModificadoFormatado);
			lista.Add(dir.Atributos);
			lista.Add(dir.Caminho);
			if (!bTabelaDir){
				lista.Add(dir.Aba.Nome);
			}

			lstore.AppendValues(lista.ToArray());
		}
		
		public void Carregar(bool bTabelaDir, NodeView lvTabela, List<Diretorio> diretorios, 
							List<Extensao> extensoes, ProgressBar pb){						
			if (diretorios.Count > 0) {
				int nProgresso = 0;
	            int nMaximum = diretorios.Count;
				pb.Fraction = 0;
				pb.PulseStep = 0.1;
	
	            foreach (Diretorio dir in diretorios) {    
	            	AdicionaItemLista(bTabelaDir, lvTabela, dir, extensoes);
					pb.Fraction = Rotinas.calculaProgresso(nMaximum, ++nProgresso);
	            }            
			}
		}
		
		public TreePath encontrarCaminhoPorNome(NodeView lvTabela, string nome) {
	        string slinha;
			ListStore lstore = (ListStore)lvTabela.Model;
			TreePath path = null;
			TreeIter iter;

			for (int i = 0; i < lstore.IterNChildren (); i++) {
				lstore.IterNthChild(out iter, i);
				slinha = (string)lstore.GetValue(iter, 1);

				if (slinha.Equals(nome)) {
					path = lstore.GetPath (iter);
					break;
				}
			}

	        return path;
	    }
		
	    public Diretorio getLinhaSelecionada(NodeView lvTabela, bool bTabelaDir){
	        Diretorio dir = null;
			ListStore lstore = (ListStore)lvTabela.Model;
			TreeIter iter;
	        
			lvTabela.Selection.GetSelected (out iter);

			if (lvTabela.Selection.IterIsSelected (iter)) {
				dir = new Diretorio();
				dir.Nome = (string)lstore.GetValue(iter, 1);
				dir.TamanhoFormatado = (string)lstore.GetValue(iter,2);
				dir.Tipo = new Tipo('D', (string)lstore.GetValue(iter,3));
				dir.ModificadoFormatado = (string)lstore.GetValue(iter,4);
				dir.Atributos = (string)lstore.GetValue(iter,5);
				dir.Caminho = (string)lstore.GetValue(iter,6);
	            if (bTabelaDir) {                
					dir.Aba.Nome = (string)lstore.GetValue(iter,7);
	            }
	        }
	        
	        return dir;
	    }

		public void listaCompara(NodeView lvTabela, int coluna) {
			ListStore tabelaStore = (ListStore)lvTabela.Model;
			tabelaStore.SetSortFunc(coluna, Compara);
		}

		private int Compara(TreeModel modelo, TreeIter linha1, TreeIter linha2) {
			SortType ordem;
			int colOrdem;
			ListStore lstore = (ListStore)modelo;

			lstore.GetSortColumnId (out colOrdem, out ordem);
			string valor1 = (string)modelo.GetValue (linha1, colOrdem);
			string valor2 = (string)modelo.GetValue (linha2, colOrdem);

			return valor1.CompareTo (valor2);
			/*
			if (valor1 < valor2)
				return -1;
			else if (valor1 == valor2)
				return 0;
			else
				return 1;
			*/
		}

	}
}
