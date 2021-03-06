
// This file has been generated by the GUI designer. Do not modify.
namespace HFSGuardaDiretorio.gui
{
	public partial class FrmCadExtensao
	{
		private global::Gtk.UIManager UIManager;
		
		private global::Gtk.Action ExtensaoAction;
		
		private global::Gtk.Action IncluirExtensoAction;
		
		private global::Gtk.Action ExcluirExtensaoAction;
		
		private global::Gtk.Action ExcluirTodasExtensoesAction;
		
		private global::Gtk.Action ExportarTodosAction;
		
		private global::Gtk.Action ExportarParaBitmapAction;
		
		private global::Gtk.Action ExportarParaIConeAction;
		
		private global::Gtk.Action ExportarParaGIFAction;
		
		private global::Gtk.Action ExportarParaJPEGAction;
		
		private global::Gtk.Action ExportarParaPNGAction;
		
		private global::Gtk.Action ExportarParaTIFFAction;
		
		private global::Gtk.Action ImportarTodosAction;
		
		private global::Gtk.Action ImportarIconesDosArquivosAction;
		
		private global::Gtk.Action ExtrairIconesDosArquivosAction;
		
		private global::Gtk.VBox vbox3;
		
		private global::Gtk.MenuBar menubar1;
		
		private global::Gtk.ScrolledWindow GtkScrolledWindow;
		
		private global::Gtk.NodeView tabelaExtensao;
		
		private global::Gtk.Button btnIncluir;
		
		private global::Gtk.Button btnExcluir;

		protected virtual void Build ()
		{
			global::Stetic.Gui.Initialize (this);
			// Widget HFSGuardaDiretorio.gui.FrmCadExtensao
			this.UIManager = new global::Gtk.UIManager ();
			global::Gtk.ActionGroup w1 = new global::Gtk.ActionGroup ("Default");
			this.ExtensaoAction = new global::Gtk.Action ("ExtensaoAction", global::Mono.Unix.Catalog.GetString ("Extensão"), null, null);
			this.ExtensaoAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Extensão");
			w1.Add (this.ExtensaoAction, null);
			this.IncluirExtensoAction = new global::Gtk.Action ("IncluirExtensoAction", global::Mono.Unix.Catalog.GetString ("Incluir Extensão"), null, null);
			this.IncluirExtensoAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Incluir Extensão");
			w1.Add (this.IncluirExtensoAction, null);
			this.ExcluirExtensaoAction = new global::Gtk.Action ("ExcluirExtensaoAction", global::Mono.Unix.Catalog.GetString ("Excluir Extensão"), null, null);
			this.ExcluirExtensaoAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Excluir Extensão");
			w1.Add (this.ExcluirExtensaoAction, null);
			this.ExcluirTodasExtensoesAction = new global::Gtk.Action ("ExcluirTodasExtensoesAction", global::Mono.Unix.Catalog.GetString ("Excluir Todas Extensões"), null, null);
			this.ExcluirTodasExtensoesAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Excluir Todas Extensões");
			w1.Add (this.ExcluirTodasExtensoesAction, null);
			this.ExportarTodosAction = new global::Gtk.Action ("ExportarTodosAction", global::Mono.Unix.Catalog.GetString ("Exportar Todos"), null, null);
			this.ExportarTodosAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Exportar Todos");
			w1.Add (this.ExportarTodosAction, null);
			this.ExportarParaBitmapAction = new global::Gtk.Action ("ExportarParaBitmapAction", global::Mono.Unix.Catalog.GetString ("Exportar para Bitmap"), null, null);
			this.ExportarParaBitmapAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Exportar para Bitmap");
			w1.Add (this.ExportarParaBitmapAction, null);
			this.ExportarParaIConeAction = new global::Gtk.Action ("ExportarParaIConeAction", global::Mono.Unix.Catalog.GetString ("Exportar para Ícone"), null, null);
			this.ExportarParaIConeAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Exportar para Ícone");
			w1.Add (this.ExportarParaIConeAction, null);
			this.ExportarParaGIFAction = new global::Gtk.Action ("ExportarParaGIFAction", global::Mono.Unix.Catalog.GetString ("Exportar para GIF"), null, null);
			this.ExportarParaGIFAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Exportar para GIF");
			w1.Add (this.ExportarParaGIFAction, null);
			this.ExportarParaJPEGAction = new global::Gtk.Action ("ExportarParaJPEGAction", global::Mono.Unix.Catalog.GetString ("Exportar para JPEG"), null, null);
			this.ExportarParaJPEGAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Exportar para JPEG");
			w1.Add (this.ExportarParaJPEGAction, null);
			this.ExportarParaPNGAction = new global::Gtk.Action ("ExportarParaPNGAction", global::Mono.Unix.Catalog.GetString ("Exportar para PNG"), null, null);
			this.ExportarParaPNGAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Exportar para PNG");
			w1.Add (this.ExportarParaPNGAction, null);
			this.ExportarParaTIFFAction = new global::Gtk.Action ("ExportarParaTIFFAction", global::Mono.Unix.Catalog.GetString ("Exportar para TIFF"), null, null);
			this.ExportarParaTIFFAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Exportar para TIFF");
			w1.Add (this.ExportarParaTIFFAction, null);
			this.ImportarTodosAction = new global::Gtk.Action ("ImportarTodosAction", global::Mono.Unix.Catalog.GetString ("Importar Todos"), null, null);
			this.ImportarTodosAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Importar Todos");
			w1.Add (this.ImportarTodosAction, null);
			this.ImportarIconesDosArquivosAction = new global::Gtk.Action ("ImportarIconesDosArquivosAction", global::Mono.Unix.Catalog.GetString ("Importar Ícones dos Arquivos"), null, null);
			this.ImportarIconesDosArquivosAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Importar Ícones dos Arquivos");
			w1.Add (this.ImportarIconesDosArquivosAction, null);
			this.ExtrairIconesDosArquivosAction = new global::Gtk.Action ("ExtrairIconesDosArquivosAction", global::Mono.Unix.Catalog.GetString ("Extrair Ícones dos Arquivos"), null, null);
			this.ExtrairIconesDosArquivosAction.ShortLabel = global::Mono.Unix.Catalog.GetString ("Extrair Ícones dos Arquivos");
			w1.Add (this.ExtrairIconesDosArquivosAction, null);
			this.UIManager.InsertActionGroup (w1, 0);
			this.AddAccelGroup (this.UIManager.AccelGroup);
			this.WidthRequest = 286;
			this.HeightRequest = 418;
			this.Name = "HFSGuardaDiretorio.gui.FrmCadExtensao";
			this.Title = global::Mono.Unix.Catalog.GetString ("Cadastro de Extensão de Arquivo");
			this.WindowPosition = ((global::Gtk.WindowPosition)(1));
			this.Modal = true;
			this.Resizable = false;
			this.AllowGrow = false;
			// Internal child HFSGuardaDiretorio.gui.FrmCadExtensao.VBox
			global::Gtk.VBox w2 = this.VBox;
			w2.Name = "dialog1_VBox";
			w2.BorderWidth = ((uint)(2));
			// Container child dialog1_VBox.Gtk.Box+BoxChild
			this.vbox3 = new global::Gtk.VBox ();
			this.vbox3.Name = "vbox3";
			this.vbox3.Spacing = 6;
			// Container child vbox3.Gtk.Box+BoxChild
			this.UIManager.AddUiFromString (@"<ui><menubar name='menubar1'><menu name='ExtensaoAction' action='ExtensaoAction'><menuitem name='IncluirExtensoAction' action='IncluirExtensoAction'/><menuitem name='ExcluirExtensaoAction' action='ExcluirExtensaoAction'/><menuitem name='ExcluirTodasExtensoesAction' action='ExcluirTodasExtensoesAction'/></menu><menu name='ExportarTodosAction' action='ExportarTodosAction'><menuitem name='ExportarParaBitmapAction' action='ExportarParaBitmapAction'/><menuitem name='ExportarParaIConeAction' action='ExportarParaIConeAction'/><menuitem name='ExportarParaGIFAction' action='ExportarParaGIFAction'/><menuitem name='ExportarParaJPEGAction' action='ExportarParaJPEGAction'/><menuitem name='ExportarParaPNGAction' action='ExportarParaPNGAction'/><menuitem name='ExportarParaTIFFAction' action='ExportarParaTIFFAction'/></menu><menu name='ImportarTodosAction' action='ImportarTodosAction'><menuitem name='ImportarIconesDosArquivosAction' action='ImportarIconesDosArquivosAction'/><menuitem name='ExtrairIconesDosArquivosAction' action='ExtrairIconesDosArquivosAction'/></menu></menubar></ui>");
			this.menubar1 = ((global::Gtk.MenuBar)(this.UIManager.GetWidget ("/menubar1")));
			this.menubar1.Name = "menubar1";
			this.vbox3.Add (this.menubar1);
			global::Gtk.Box.BoxChild w3 = ((global::Gtk.Box.BoxChild)(this.vbox3 [this.menubar1]));
			w3.Position = 0;
			w3.Expand = false;
			w3.Fill = false;
			// Container child vbox3.Gtk.Box+BoxChild
			this.GtkScrolledWindow = new global::Gtk.ScrolledWindow ();
			this.GtkScrolledWindow.Name = "GtkScrolledWindow";
			this.GtkScrolledWindow.ShadowType = ((global::Gtk.ShadowType)(1));
			// Container child GtkScrolledWindow.Gtk.Container+ContainerChild
			this.tabelaExtensao = new global::Gtk.NodeView ();
			this.tabelaExtensao.CanFocus = true;
			this.tabelaExtensao.Name = "tabelaExtensao";
			this.GtkScrolledWindow.Add (this.tabelaExtensao);
			this.vbox3.Add (this.GtkScrolledWindow);
			global::Gtk.Box.BoxChild w5 = ((global::Gtk.Box.BoxChild)(this.vbox3 [this.GtkScrolledWindow]));
			w5.Position = 1;
			w2.Add (this.vbox3);
			global::Gtk.Box.BoxChild w6 = ((global::Gtk.Box.BoxChild)(w2 [this.vbox3]));
			w6.Position = 0;
			// Internal child HFSGuardaDiretorio.gui.FrmCadExtensao.ActionArea
			global::Gtk.HButtonBox w7 = this.ActionArea;
			w7.Name = "dialog1_ActionArea";
			w7.Spacing = 10;
			w7.BorderWidth = ((uint)(5));
			w7.LayoutStyle = ((global::Gtk.ButtonBoxStyle)(1));
			// Container child dialog1_ActionArea.Gtk.ButtonBox+ButtonBoxChild
			this.btnIncluir = new global::Gtk.Button ();
			this.btnIncluir.CanDefault = true;
			this.btnIncluir.CanFocus = true;
			this.btnIncluir.Name = "btnIncluir";
			this.btnIncluir.UseUnderline = true;
			this.btnIncluir.Label = global::Mono.Unix.Catalog.GetString ("_Incluir");
			this.AddActionWidget (this.btnIncluir, 0);
			global::Gtk.ButtonBox.ButtonBoxChild w8 = ((global::Gtk.ButtonBox.ButtonBoxChild)(w7 [this.btnIncluir]));
			w8.Expand = false;
			w8.Fill = false;
			// Container child dialog1_ActionArea.Gtk.ButtonBox+ButtonBoxChild
			this.btnExcluir = new global::Gtk.Button ();
			this.btnExcluir.CanDefault = true;
			this.btnExcluir.CanFocus = true;
			this.btnExcluir.Name = "btnExcluir";
			this.btnExcluir.UseUnderline = true;
			this.btnExcluir.Label = global::Mono.Unix.Catalog.GetString ("_Excluir");
			this.AddActionWidget (this.btnExcluir, 0);
			global::Gtk.ButtonBox.ButtonBoxChild w9 = ((global::Gtk.ButtonBox.ButtonBoxChild)(w7 [this.btnExcluir]));
			w9.Position = 1;
			w9.Expand = false;
			w9.Fill = false;
			if ((this.Child != null)) {
				this.Child.ShowAll ();
			}
			this.DefaultWidth = 400;
			this.DefaultHeight = 418;
			this.Show ();
			this.IncluirExtensoAction.Activated += new global::System.EventHandler (this.OnIncluirExtensaoActionActivated);
			this.ExcluirExtensaoAction.Activated += new global::System.EventHandler (this.OnExcluirExtensaoActionActivated);
			this.ExcluirTodasExtensoesAction.Activated += new global::System.EventHandler (this.OnExcluirTodasExtensoesActionActivated);
			this.ExportarParaBitmapAction.Activated += new global::System.EventHandler (this.OnExportarParaBitmapActionActivated);
			this.ExportarParaIConeAction.Activated += new global::System.EventHandler (this.OnExportarParaIConeActionActivated);
			this.ExportarParaGIFAction.Activated += new global::System.EventHandler (this.OnExportarParaGIFActionActivated);
			this.ExportarParaJPEGAction.Activated += new global::System.EventHandler (this.OnExportarParaJPEGActionActivated);
			this.ExportarParaPNGAction.Activated += new global::System.EventHandler (this.OnExportarParaPNGActionActivated);
			this.ExportarParaTIFFAction.Activated += new global::System.EventHandler (this.OnExportarParaTIFFActionActivated);
			this.ImportarIconesDosArquivosAction.Activated += new global::System.EventHandler (this.OnImportarIconesDosArquivosActionActivated);
			this.ExtrairIconesDosArquivosAction.Activated += new global::System.EventHandler (this.OnExtrairIconesDosArquivosActionActivated);
			this.btnIncluir.Clicked += new global::System.EventHandler (this.OnBtnIncluirClicked);
			this.btnExcluir.Clicked += new global::System.EventHandler (this.OnBtnExcluirClicked);
		}
	}
}
