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

package body MenuPopup is

	procedure Criar(menuPopup: out MenuPopup_Access) is
	begin
		menuPopup := new menuPopup_Record;
		Inicializa(menuPopup);
	end Criar;

	procedure Inicializa(menuPopup: access MenuPopup_Record'Class) is
		pragma Suppress(All_Checks);
		Num: Gint;
		pragma Unreferenced(Num);
		Text_Render: Gtk_Cell_Renderer_Text := Gtk_Cell_Renderer_Text_New;
	begin
		Menu.Initialize(menuPopup);

		menuPopup.menuExcluirAbaAtiva2 := Gtk_Menu_Item_New;
		menuPopup.menuExcluirAbaAtiva2.Set_Name("menuExcluirAbaAtiva2");
		menuPopup.menuExcluirAbaAtiva2.Set_Visible(True);
		menuPopup.menuExcluirAbaAtiva2.Set_Can_Focus(False);
		menuPopup.menuExcluirAbaAtiva2.Set_Label("excluir aba ativa");
		menuPopup.menuExcluirAbaAtiva2.Set_Use_Underline(True);
	
		menuPopup.menuAlterarNomeAbaAtiva2 := Gtk_Menu_Item_New;
		menuPopup.menuAlterarNomeAbaAtiva2.Set_Name("menuAlterarNomeAbaAtiva2");
		menuPopup.menuAlterarNomeAbaAtiva2.Set_Visible(True);
		menuPopup.menuAlterarNomeAbaAtiva2.Set_Can_Focus(False);
		menuPopup.menuAlterarNomeAbaAtiva2.Set_Label("alterar nome da aba ativa");
		menuPopup.menuAlterarNomeAbaAtiva2.Set_Use_Underline(True);
	
		menuPopup.menuIncluirNovaAba2 := Gtk_Menu_Item_New;
		menuPopup.menuIncluirNovaAba2.Set_Name("menuIncluirNovaAba2");
		menuPopup.menuIncluirNovaAba2.Set_Visible(True);
		menuPopup.menuIncluirNovaAba2.Set_Can_Focus(False);
		menuPopup.menuIncluirNovaAba2.Set_Label("incluir nova aba");
		menuPopup.menuIncluirNovaAba2.Set_Use_Underline(True);
	
		menuPopup.separador2 := Gtk_Separator_Menu_Item_New;
		menuPopup.separador2.Set_Name("separador2");
		menuPopup.separador2.Set_Visible(True);
		menuPopup.separador2.Set_Can_Focus(False);
	
		menuPopup.menuColapsarDiretorios2 := Gtk_Menu_Item_New;
		menuPopup.menuColapsarDiretorios2.Set_Name("menuColapsarDiretorios2");
		menuPopup.menuColapsarDiretorios2.Set_Visible(True);
		menuPopup.menuColapsarDiretorios2.Set_Can_Focus(False);
		menuPopup.menuColapsarDiretorios2.Set_Label("colapsar diretórios");
		menuPopup.menuColapsarDiretorios2.Set_Use_Underline(True);
	
		menuPopup.menuExpandirDiretorios2 := Gtk_Menu_Item_New;
		menuPopup.menuExpandirDiretorios2.Set_Name("menuExpandirDiretorios2");
		menuPopup.menuExpandirDiretorios2.Set_Visible(True);
		menuPopup.menuExpandirDiretorios2.Set_Can_Focus(False);
		menuPopup.menuExpandirDiretorios2.Set_Label("expandir diretórios");
		menuPopup.menuExpandirDiretorios2.Set_Use_Underline(True);
	
		menuPopup.menuExcluirDiretorioSelecionado := Gtk_Menu_Item_New;
		menuPopup.menuExcluirDiretorioSelecionado.Set_Name("menuExcluirDiretorioSelecionado");
		menuPopup.menuExcluirDiretorioSelecionado.Set_Visible(True);
		menuPopup.menuExcluirDiretorioSelecionado.Set_Can_Focus(False);
		menuPopup.menuExcluirDiretorioSelecionado.Set_Label("excluir diretório selecionado");
		menuPopup.menuExcluirDiretorioSelecionado.Set_Use_Underline(True);
	
		menuPopup.menuInformacoesDiretorioArquivo := Gtk_Menu_Item_New;
		menuPopup.menuInformacoesDiretorioArquivo.Set_Name("menuInformacoesDiretorioArquivo");
		menuPopup.menuInformacoesDiretorioArquivo.Set_Visible(True);
		menuPopup.menuInformacoesDiretorioArquivo.Set_Can_Focus(False);
		menuPopup.menuInformacoesDiretorioArquivo.Set_Label("informações do diretório / arquivo");
		menuPopup.menuInformacoesDiretorioArquivo.Set_Use_Underline(True);
	
		menuPopup.Set_Name("menuPopup");
		menuPopup.Set_Visible(True);
		menuPopup.Set_Can_Focus(False);
		menuPopup.Add(menuPopup.menuInformacoesDiretorioArquivo);
		menuPopup.Add(menuPopup.menuExcluirDiretorioSelecionado);
		menuPopup.Add(menuPopup.menuExpandirDiretorios2);
		menuPopup.Add(menuPopup.menuColapsarDiretorios2);
		menuPopup.Add(menuPopup.separador2);
		menuPopup.Add(menuPopup.menuIncluirNovaAba2);
		menuPopup.Add(menuPopup.menuAlterarNomeAbaAtiva2);
		menuPopup.Add(menuPopup.menuExcluirAbaAtiva2);
	

		menuPopup.menuInformacoesDiretorioArquivo.On_Activate(on_menuInformacoesDiretorioArquivo_activate'Access);
		menuPopup.menuExcluirDiretorioSelecionado.On_Activate(on_menuExcluirDiretorioSelecionado_activate'Access);
		menuPopup.menuExpandirDiretorios2.On_Activate(on_menuExpandirDiretorios2_activate'Access);
		menuPopup.menuColapsarDiretorios2.On_Activate(on_menuColapsarDiretorios2_activate'Access);
		menuPopup.menuIncluirNovaAba2.On_Activate(on_menuIncluirNovaAba2_activate'Access);
		menuPopup.menuAlterarNomeAbaAtiva2.On_Activate(on_menuAlterarNomeAbaAtiva2_activate'Access);
		menuPopup.menuExcluirAbaAtiva2.On_Activate(on_menuExcluirAbaAtiva2_activate'Access);
		
	end Inicializa;

	procedure Mostrar is
		retorno: Gtk_Response_Type;
		pragma Unreferenced(retorno);	
	begin
		Criar(menuPopup);
		menuPopup.Show_All;
	end Mostrar;

	procedure on_menuInformacoesDiretorioArquivo_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuInformacoesDiretorioArquivo_activate;

	procedure on_menuExcluirDiretorioSelecionado_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExcluirDiretorioSelecionado_activate;

	procedure on_menuExpandirDiretorios2_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExpandirDiretorios2_activate;

	procedure on_menuColapsarDiretorios2_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuColapsarDiretorios2_activate;

	procedure on_menuIncluirNovaAba2_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuIncluirNovaAba2_activate;

	procedure on_menuAlterarNomeAbaAtiva2_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuAlterarNomeAbaAtiva2_activate;

	procedure on_menuExcluirAbaAtiva2_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExcluirAbaAtiva2_activate;



end MenuPopup;
