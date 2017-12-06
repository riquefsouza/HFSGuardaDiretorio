with System; use System;
with Gtk.Main;
with Gdk.Event; use Gdk.Event;
with Gtk.Accel_Group; use Gtk.Accel_Group;
with Gtk.Style; use Gtk.Style;
with Glib; use Glib;
with Gtk; use Gtk;
with Gdk.Types; use Gdk.Types;
with Gtk.Widget; use Gtk.Widget;
with Gtk.Enums; use Gtk.Enums;
with Gtkada.Handlers; use Gtkada.Handlers;
with Rotinas; use Rotinas;
with Gtk.Cell_Renderer_Text; use Gtk.Cell_Renderer_Text;
with Gtk.Tree_Store; use Gtk.Tree_Store;
with Gtk.Message_Dialog; use Gtk.Message_Dialog;
with Gdk.Window; use Gdk.Window;

package body FrmCadExtensao is

	procedure Criar(frmCadExtensao: out FrmCadExtensao_Access) is
	begin
		frmCadExtensao := new frmCadExtensao_Record;
		Inicializa(frmCadExtensao);
	end Criar;

	procedure Inicializa(frmCadExtensao: access FrmCadExtensao_Record'Class) is
		pragma Suppress(All_Checks);
		Num: Gint;
		pragma Unreferenced(Num);
		Text_Render: Gtk_Cell_Renderer_Text := Gtk_Cell_Renderer_Text_New;
	begin
		Dialog.Initialize(frmCadExtensao);

		frmCadExtensao.btnExcluir := Gtk_Button_New_With_Label("excluir");
		frmCadExtensao.btnExcluir.Set_Name("btnExcluir");
		frmCadExtensao.btnExcluir.Set_Label("excluir");
		frmCadExtensao.btnExcluir.Set_Visible(True);
		frmCadExtensao.btnExcluir.Set_Can_Focus(True);
		frmCadExtensao.btnExcluir.Set_Receives_Default(True);
		frmCadExtensao.btnExcluir.Set_Use_Stock(True);
	
		frmCadExtensao.btnIncluir := Gtk_Button_New_With_Label("incluir");
		frmCadExtensao.btnIncluir.Set_Name("btnIncluir");
		frmCadExtensao.btnIncluir.Set_Label("incluir");
		frmCadExtensao.btnIncluir.Set_Visible(True);
		frmCadExtensao.btnIncluir.Set_Can_Focus(True);
		frmCadExtensao.btnIncluir.Set_Receives_Default(True);
		frmCadExtensao.btnIncluir.Set_Use_Stock(True);
	
		frmCadExtensao.form_area := Gtk_Hbutton_Box_New;
		frmCadExtensao.form_area.Set_Name("form_area");
		frmCadExtensao.form_area.Set_Visible(True);
		frmCadExtensao.form_area.Set_Can_Focus(False);
		frmCadExtensao.form_area.Set_Layout(Buttonbox_Center);
		frmCadExtensao.form_area.Pack_Start(frmCadExtensao.btnIncluir, False, False, 0);
		frmCadExtensao.form_area.Pack_Start(frmCadExtensao.btnExcluir, False, False, 0);
	
		frmCadExtensao.colunaCadExtIcone := Gtk_Tree_View_Column_New;
		frmCadExtensao.colunaCadExtIcone.Set_Min_Width(100);
		frmCadExtensao.colunaCadExtIcone.Set_Title("ícone");
	
		frmCadExtensao.colunaCadExtExtensao := Gtk_Tree_View_Column_New;
		frmCadExtensao.colunaCadExtExtensao.Set_Min_Width(150);
		frmCadExtensao.colunaCadExtExtensao.Set_Title("extensão");
	
		frmCadExtensao.tabelaExtensao := Gtk_Tree_View_New;
		frmCadExtensao.tabelaExtensao.Set_Name("tabelaExtensao");
		frmCadExtensao.tabelaExtensao.Set_Visible(True);
		frmCadExtensao.tabelaExtensao.Set_Can_Focus(True);
		frmCadExtensao.tabelaExtensao.Set_Model(Rotinas.modelo_lsTabelaExtensao);
		Num := frmCadExtensao.tabelaExtensao.Append_Column(frmCadExtensao.colunaCadExtExtensao);
		frmCadExtensao.colunaCadExtExtensao.Pack_Start(Text_Render, True);
		frmCadExtensao.colunaCadExtExtensao.Add_Attribute(Text_Render, "text", 0);
		Num := frmCadExtensao.tabelaExtensao.Append_Column(frmCadExtensao.colunaCadExtIcone);
		frmCadExtensao.colunaCadExtIcone.Pack_Start(Text_Render, True);
		frmCadExtensao.colunaCadExtIcone.Add_Attribute(Text_Render, "text", 1);
	
		frmCadExtensao.scrollTabela := Gtk_Scrolled_Window_New;
		frmCadExtensao.scrollTabela.Set_Name("scrollTabela");
		frmCadExtensao.scrollTabela.Set_Visible(True);
		frmCadExtensao.scrollTabela.Set_Can_Focus(True);
		frmCadExtensao.scrollTabela.Set_Policy(Policy_Automatic, Policy_Automatic);
		frmCadExtensao.scrollTabela.Add(frmCadExtensao.tabelaExtensao);
	
		frmCadExtensao.menuExtrairIconesArquivos := Gtk_Menu_Item_New;
		frmCadExtensao.menuExtrairIconesArquivos.Set_Name("menuExtrairIconesArquivos");
		frmCadExtensao.menuExtrairIconesArquivos.Set_Visible(True);
		frmCadExtensao.menuExtrairIconesArquivos.Set_Can_Focus(False);
		frmCadExtensao.menuExtrairIconesArquivos.Set_Label("extrair ícones dos arquivos");
		frmCadExtensao.menuExtrairIconesArquivos.Set_Use_Underline(True);
	
		frmCadExtensao.menuImportarIconesArquivos := Gtk_Menu_Item_New;
		frmCadExtensao.menuImportarIconesArquivos.Set_Name("menuImportarIconesArquivos");
		frmCadExtensao.menuImportarIconesArquivos.Set_Visible(True);
		frmCadExtensao.menuImportarIconesArquivos.Set_Can_Focus(False);
		frmCadExtensao.menuImportarIconesArquivos.Set_Label("importar ícones dos arquivos");
		frmCadExtensao.menuImportarIconesArquivos.Set_Use_Underline(True);
	
		frmCadExtensao.submenuImportarTodos := Gtk_Menu_New;
		frmCadExtensao.submenuImportarTodos.Set_Name("submenuImportarTodos");
		frmCadExtensao.submenuImportarTodos.Set_Visible(True);
		frmCadExtensao.submenuImportarTodos.Set_Can_Focus(False);
		frmCadExtensao.submenuImportarTodos.Append(frmCadExtensao.menuImportarIconesArquivos);
		frmCadExtensao.submenuImportarTodos.Append(frmCadExtensao.menuExtrairIconesArquivos);
	
		frmCadExtensao.menuImportarTodos := Gtk_Menu_Item_New;
		frmCadExtensao.menuImportarTodos.Set_Name("menuImportarTodos");
		frmCadExtensao.menuImportarTodos.Set_Visible(True);
		frmCadExtensao.menuImportarTodos.Set_Can_Focus(False);
		frmCadExtensao.menuImportarTodos.Set_Label("importar todos");
		frmCadExtensao.menuImportarTodos.Set_Use_Underline(True);
		frmCadExtensao.menuImportarTodos.Set_Submenu(frmCadExtensao.submenuImportarTodos);
	
		frmCadExtensao.menuExportarTIFF := Gtk_Menu_Item_New;
		frmCadExtensao.menuExportarTIFF.Set_Name("menuExportarTIFF");
		frmCadExtensao.menuExportarTIFF.Set_Visible(True);
		frmCadExtensao.menuExportarTIFF.Set_Can_Focus(False);
		frmCadExtensao.menuExportarTIFF.Set_Label("exportar para tiff");
		frmCadExtensao.menuExportarTIFF.Set_Use_Underline(True);
	
		frmCadExtensao.menuExportarPNG := Gtk_Menu_Item_New;
		frmCadExtensao.menuExportarPNG.Set_Name("menuExportarPNG");
		frmCadExtensao.menuExportarPNG.Set_Visible(True);
		frmCadExtensao.menuExportarPNG.Set_Can_Focus(False);
		frmCadExtensao.menuExportarPNG.Set_Label("exportar para png");
		frmCadExtensao.menuExportarPNG.Set_Use_Underline(True);
	
		frmCadExtensao.menuExportarJPEG := Gtk_Menu_Item_New;
		frmCadExtensao.menuExportarJPEG.Set_Name("menuExportarJPEG");
		frmCadExtensao.menuExportarJPEG.Set_Visible(True);
		frmCadExtensao.menuExportarJPEG.Set_Can_Focus(False);
		frmCadExtensao.menuExportarJPEG.Set_Label("exportar para jpeg");
		frmCadExtensao.menuExportarJPEG.Set_Use_Underline(True);
	
		frmCadExtensao.menuExportarGIF := Gtk_Menu_Item_New;
		frmCadExtensao.menuExportarGIF.Set_Name("menuExportarGIF");
		frmCadExtensao.menuExportarGIF.Set_Visible(True);
		frmCadExtensao.menuExportarGIF.Set_Can_Focus(False);
		frmCadExtensao.menuExportarGIF.Set_Label("exportar para gif");
		frmCadExtensao.menuExportarGIF.Set_Use_Underline(True);
	
		frmCadExtensao.menuExportarIcone := Gtk_Menu_Item_New;
		frmCadExtensao.menuExportarIcone.Set_Name("menuExportarIcone");
		frmCadExtensao.menuExportarIcone.Set_Visible(True);
		frmCadExtensao.menuExportarIcone.Set_Can_Focus(False);
		frmCadExtensao.menuExportarIcone.Set_Label("exportar para ícone");
		frmCadExtensao.menuExportarIcone.Set_Use_Underline(True);
	
		frmCadExtensao.menuExportarBitmap := Gtk_Menu_Item_New;
		frmCadExtensao.menuExportarBitmap.Set_Name("menuExportarBitmap");
		frmCadExtensao.menuExportarBitmap.Set_Visible(True);
		frmCadExtensao.menuExportarBitmap.Set_Can_Focus(False);
		frmCadExtensao.menuExportarBitmap.Set_Label("exportar para bitmap");
		frmCadExtensao.menuExportarBitmap.Set_Use_Underline(True);
	
		frmCadExtensao.submenuExportarTodos := Gtk_Menu_New;
		frmCadExtensao.submenuExportarTodos.Set_Name("submenuExportarTodos");
		frmCadExtensao.submenuExportarTodos.Set_Visible(True);
		frmCadExtensao.submenuExportarTodos.Set_Can_Focus(False);
		frmCadExtensao.submenuExportarTodos.Append(frmCadExtensao.menuExportarBitmap);
		frmCadExtensao.submenuExportarTodos.Append(frmCadExtensao.menuExportarIcone);
		frmCadExtensao.submenuExportarTodos.Append(frmCadExtensao.menuExportarGIF);
		frmCadExtensao.submenuExportarTodos.Append(frmCadExtensao.menuExportarJPEG);
		frmCadExtensao.submenuExportarTodos.Append(frmCadExtensao.menuExportarPNG);
		frmCadExtensao.submenuExportarTodos.Append(frmCadExtensao.menuExportarTIFF);
	
		frmCadExtensao.menuExportarTodos := Gtk_Menu_Item_New;
		frmCadExtensao.menuExportarTodos.Set_Name("menuExportarTodos");
		frmCadExtensao.menuExportarTodos.Set_Visible(True);
		frmCadExtensao.menuExportarTodos.Set_Can_Focus(False);
		frmCadExtensao.menuExportarTodos.Set_Label("exportar todos");
		frmCadExtensao.menuExportarTodos.Set_Use_Underline(True);
		frmCadExtensao.menuExportarTodos.Set_Submenu(frmCadExtensao.submenuExportarTodos);
	
		frmCadExtensao.menuExcluirTodasExtensoes := Gtk_Menu_Item_New;
		frmCadExtensao.menuExcluirTodasExtensoes.Set_Name("menuExcluirTodasExtensoes");
		frmCadExtensao.menuExcluirTodasExtensoes.Set_Visible(True);
		frmCadExtensao.menuExcluirTodasExtensoes.Set_Can_Focus(False);
		frmCadExtensao.menuExcluirTodasExtensoes.Set_Label("excluir todas extensões");
		frmCadExtensao.menuExcluirTodasExtensoes.Set_Use_Underline(True);
	
		frmCadExtensao.menuExcluirExtensao := Gtk_Menu_Item_New;
		frmCadExtensao.menuExcluirExtensao.Set_Name("menuExcluirExtensao");
		frmCadExtensao.menuExcluirExtensao.Set_Visible(True);
		frmCadExtensao.menuExcluirExtensao.Set_Can_Focus(False);
		frmCadExtensao.menuExcluirExtensao.Set_Label("excluir extensão");
		frmCadExtensao.menuExcluirExtensao.Set_Use_Underline(True);
	
		frmCadExtensao.menuIncluirExtensao := Gtk_Menu_Item_New;
		frmCadExtensao.menuIncluirExtensao.Set_Name("menuIncluirExtensao");
		frmCadExtensao.menuIncluirExtensao.Set_Visible(True);
		frmCadExtensao.menuIncluirExtensao.Set_Can_Focus(False);
		frmCadExtensao.menuIncluirExtensao.Set_Label("incluir extensão");
		frmCadExtensao.menuIncluirExtensao.Set_Use_Underline(True);
	
		frmCadExtensao.submenuExtensao := Gtk_Menu_New;
		frmCadExtensao.submenuExtensao.Set_Name("submenuExtensao");
		frmCadExtensao.submenuExtensao.Set_Visible(True);
		frmCadExtensao.submenuExtensao.Set_Can_Focus(False);
		frmCadExtensao.submenuExtensao.Append(frmCadExtensao.menuIncluirExtensao);
		frmCadExtensao.submenuExtensao.Append(frmCadExtensao.menuExcluirExtensao);
		frmCadExtensao.submenuExtensao.Append(frmCadExtensao.menuExcluirTodasExtensoes);
	
		frmCadExtensao.menuExtensao := Gtk_Menu_Item_New;
		frmCadExtensao.menuExtensao.Set_Name("menuExtensao");
		frmCadExtensao.menuExtensao.Set_Visible(True);
		frmCadExtensao.menuExtensao.Set_Can_Focus(False);
		frmCadExtensao.menuExtensao.Set_Label("_Extensão");
		frmCadExtensao.menuExtensao.Set_Use_Underline(True);
		frmCadExtensao.menuExtensao.Set_Submenu(frmCadExtensao.submenuExtensao);
	
		frmCadExtensao.barraMenu := Gtk_Menu_Bar_New;
		frmCadExtensao.barraMenu.Set_Name("barraMenu");
		frmCadExtensao.barraMenu.Set_Visible(True);
		frmCadExtensao.barraMenu.Set_Can_Focus(False);
		frmCadExtensao.barraMenu.Append(frmCadExtensao.menuExtensao);
		frmCadExtensao.barraMenu.Append(frmCadExtensao.menuExportarTodos);
		frmCadExtensao.barraMenu.Append(frmCadExtensao.menuImportarTodos);
	
		frmCadExtensao.vbox := Gtk_Vbox_New(False, 0);
		frmCadExtensao.vbox.Set_Name("vbox");
		frmCadExtensao.vbox.Set_Visible(True);
		frmCadExtensao.vbox.Set_Can_Focus(False);
		frmCadExtensao.vbox.Pack_Start(frmCadExtensao.barraMenu, False, True, 0);
		frmCadExtensao.vbox.Pack_Start(frmCadExtensao.scrollTabela, True, True, 0);
	
		frmCadExtensao.form_vbox := Gtk_Vbox_New(False, 0);
		frmCadExtensao.form_vbox.Set_Name("form_vbox");
		frmCadExtensao.form_vbox.Set_Visible(True);
		frmCadExtensao.form_vbox.Set_Can_Focus(False);
		frmCadExtensao.form_vbox.Set_Spacing(2);
		frmCadExtensao.form_vbox.Pack_Start(frmCadExtensao.vbox, True, True, 0);
		frmCadExtensao.form_vbox.Pack_Start(frmCadExtensao.form_area, False, True, 0);
	
		frmCadExtensao.Set_Name("frmCadExtensao");
		frmCadExtensao.Set_Size_Request(286, 418);
		frmCadExtensao.Set_Visible(True);
		frmCadExtensao.Set_Can_Focus(False);
		frmCadExtensao.Set_Border_Width(5);
		frmCadExtensao.Set_Title("cadastro de extensão de arquivo");
		frmCadExtensao.Set_Resizable(False);
		frmCadExtensao.Set_Modal(True);
		frmCadExtensao.Set_Position(Win_Pos_Center);
		frmCadExtensao.Get_Content_Area.Pack_Start(frmCadExtensao.form_vbox, True, True, 0);
	

		frmCadExtensao.menuIncluirExtensao.On_Activate(on_menuIncluirExtensao_activate'Access);
		frmCadExtensao.menuExcluirExtensao.On_Activate(on_menuExcluirExtensao_activate'Access);
		frmCadExtensao.menuExcluirTodasExtensoes.On_Activate(on_menuExcluirTodasExtensoes_activate'Access);
		frmCadExtensao.menuExportarBitmap.On_Activate(on_menuExportarBitmap_activate'Access);
		frmCadExtensao.menuExportarIcone.On_Activate(on_menuExportarIcone_activate'Access);
		frmCadExtensao.menuExportarGIF.On_Activate(on_menuExportarGIF_activate'Access);
		frmCadExtensao.menuExportarJPEG.On_Activate(on_menuExportarJPEG_activate'Access);
		frmCadExtensao.menuExportarPNG.On_Activate(on_menuExportarPNG_activate'Access);
		frmCadExtensao.menuExportarTIFF.On_Activate(on_menuExportarTIFF_activate'Access);
		frmCadExtensao.menuImportarIconesArquivos.On_Activate(on_menuImportarIconesArquivos_activate'Access);
		frmCadExtensao.menuExtrairIconesArquivos.On_Activate(on_menuExtrairIconesArquivos_activate'Access);
		frmCadExtensao.btnIncluir.On_Clicked(on_btnIncluir_clicked'Access);
		frmCadExtensao.btnExcluir.On_Clicked(on_btnExcluir_clicked'Access);
		
	end Inicializa;

	procedure Mostrar is
		retorno: Gtk_Response_Type;
		pragma Unreferenced(retorno);	
	begin
		Criar(frmCadExtensao);
		frmCadExtensao.Set_Position(Win_Pos_Center_Always);
		retorno := frmCadExtensao.Run;
		frmCadExtensao.Destroy;
	end Mostrar;

	procedure on_menuIncluirExtensao_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuIncluirExtensao_activate;

	procedure on_menuExcluirExtensao_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExcluirExtensao_activate;

	procedure on_menuExcluirTodasExtensoes_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExcluirTodasExtensoes_activate;

	procedure on_menuExportarBitmap_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExportarBitmap_activate;

	procedure on_menuExportarIcone_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExportarIcone_activate;

	procedure on_menuExportarGIF_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExportarGIF_activate;

	procedure on_menuExportarJPEG_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExportarJPEG_activate;

	procedure on_menuExportarPNG_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExportarPNG_activate;

	procedure on_menuExportarTIFF_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExportarTIFF_activate;

	procedure on_menuImportarIconesArquivos_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuImportarIconesArquivos_activate;

	procedure on_menuExtrairIconesArquivos_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExtrairIconesArquivos_activate;

	procedure on_btnIncluir_clicked(source: access Gtk_Button_Record'Class) is
	begin
		null;
	end on_btnIncluir_clicked;

	procedure on_btnExcluir_clicked(source: access Gtk_Button_Record'Class) is
	begin
		null;
	end on_btnExcluir_clicked;



end FrmCadExtensao;
