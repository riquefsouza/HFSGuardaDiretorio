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

package body FrmImportarDiretorio is

	procedure Criar(frmImportarDiretorio: out FrmImportarDiretorio_Access) is
	begin
		frmImportarDiretorio := new frmImportarDiretorio_Record;
		Inicializa(frmImportarDiretorio);
	end Criar;

	procedure Inicializa(frmImportarDiretorio: access FrmImportarDiretorio_Record'Class) is
		pragma Suppress(All_Checks);
		Num: Gint;
		pragma Unreferenced(Num);
		Text_Render: Gtk_Cell_Renderer_Text := Gtk_Cell_Renderer_Text_New;
	begin
		Window.Initialize(frmImportarDiretorio, Window_TopLevel);

		frmImportarDiretorio.barraStatus2 := Gtk_Status_Bar_New;
		frmImportarDiretorio.barraStatus2.Set_Name("barraStatus2");
		frmImportarDiretorio.barraStatus2.Set_Visible(True);
		frmImportarDiretorio.barraStatus2.Set_Can_Focus(False);
		frmImportarDiretorio.barraStatus2.Set_Spacing(2);
	
		frmImportarDiretorio.barraStatus1 := Gtk_Status_Bar_New;
		frmImportarDiretorio.barraStatus1.Set_Name("barraStatus1");
		frmImportarDiretorio.barraStatus1.Set_Visible(True);
		frmImportarDiretorio.barraStatus1.Set_Can_Focus(False);
		frmImportarDiretorio.barraStatus1.Set_Spacing(2);
	
		frmImportarDiretorio.hbox3 := Gtk_Hbox_New(False, 0);
		frmImportarDiretorio.hbox3.Set_Name("hbox3");
		frmImportarDiretorio.hbox3.Set_Visible(True);
		frmImportarDiretorio.hbox3.Set_Can_Focus(False);
		frmImportarDiretorio.hbox3.Pack_Start(frmImportarDiretorio.barraStatus1, False, True, 0);
		frmImportarDiretorio.hbox3.Pack_Start(frmImportarDiretorio.barraStatus2, True, True, 0);
	
		frmImportarDiretorio.pbImportar := Gtk_Progress_Bar_New;
		frmImportarDiretorio.pbImportar.Set_Name("pbImportar");
		frmImportarDiretorio.pbImportar.Set_Visible(True);
		frmImportarDiretorio.pbImportar.Set_Can_Focus(False);
	
		frmImportarDiretorio.memoImportaDir := Gtk_Text_View_New;
		frmImportarDiretorio.memoImportaDir.Set_Name("memoImportaDir");
		frmImportarDiretorio.memoImportaDir.Set_Visible(True);
		frmImportarDiretorio.memoImportaDir.Set_Can_Focus(True);
	
		frmImportarDiretorio.scrollMemo := Gtk_Scrolled_Window_New;
		frmImportarDiretorio.scrollMemo.Set_Name("scrollMemo");
		frmImportarDiretorio.scrollMemo.Set_Visible(True);
		frmImportarDiretorio.scrollMemo.Set_Can_Focus(True);
		frmImportarDiretorio.scrollMemo.Set_Policy(Policy_Automatic, Policy_Automatic);
		frmImportarDiretorio.scrollMemo.Add(frmImportarDiretorio.memoImportaDir);
	
		frmImportarDiretorio.form_vbox1 := Gtk_Vbox_New(False, 0);
		frmImportarDiretorio.form_vbox1.Set_Name("form_vbox1");
		frmImportarDiretorio.form_vbox1.Set_Visible(True);
		frmImportarDiretorio.form_vbox1.Set_Can_Focus(False);
		frmImportarDiretorio.form_vbox1.Pack_Start(frmImportarDiretorio.scrollMemo, True, True, 0);
		frmImportarDiretorio.form_vbox1.Pack_Start(frmImportarDiretorio.pbImportar, False, True, 0);
		frmImportarDiretorio.form_vbox1.Pack_Start(frmImportarDiretorio.hbox3, False, True, 0);
	
		frmImportarDiretorio.Set_Name("frmImportarDiretorio");
		frmImportarDiretorio.Set_Size_Request(895, 572);
		frmImportarDiretorio.Set_Visible(True);
		frmImportarDiretorio.Set_Can_Focus(False);
		frmImportarDiretorio.Set_Title("importando diretório");
		frmImportarDiretorio.Set_Resizable(False);
		frmImportarDiretorio.Set_Modal(True);
		frmImportarDiretorio.Set_Position(Win_Pos_Center);
		frmImportarDiretorio.Set_Default_Size(895, 572);
		frmImportarDiretorio.Set_Decorated(False);
		frmImportarDiretorio.Add(frmImportarDiretorio.form_vbox1);
	

				
	end Inicializa;

	procedure Mostrar is
		retorno: Gtk_Response_Type;
		pragma Unreferenced(retorno);	
	begin
		Criar(frmImportarDiretorio);
		frmImportarDiretorio.Set_Position(Win_Pos_Center_Always);
		frmImportarDiretorio.Show_All;
	end Mostrar;

	

end FrmImportarDiretorio;
