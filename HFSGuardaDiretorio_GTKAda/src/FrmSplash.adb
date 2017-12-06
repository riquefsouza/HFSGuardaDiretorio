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

package body FrmSplash is

	procedure Criar(frmSplash: out FrmSplash_Access) is
	begin
		frmSplash := new frmSplash_Record;
		Inicializa(frmSplash);
	end Criar;

	procedure Inicializa(frmSplash: access FrmSplash_Record'Class) is
		pragma Suppress(All_Checks);
		Num: Gint;
		pragma Unreferenced(Num);
		Text_Render: Gtk_Cell_Renderer_Text := Gtk_Cell_Renderer_Text_New;
	begin
		Window.Initialize(frmSplash, Window_TopLevel);

		frmSplash.pb1 := Gtk_Progress_Bar_New;
		frmSplash.pb1.Set_Name("pb1");
		frmSplash.pb1.Set_Visible(True);
		frmSplash.pb1.Set_Can_Focus(False);
	
		frmSplash.label5 := Gtk_Label_New;
		frmSplash.label5.Set_Name("label5");
		frmSplash.label5.Set_Visible(True);
		frmSplash.label5.Set_Can_Focus(False);
		frmSplash.label5.Set_Label("catalogador de diretórios");
	
		frmSplash.label4 := Gtk_Label_New;
		frmSplash.label4.Set_Name("label4");
		frmSplash.label4.Set_Visible(True);
		frmSplash.label4.Set_Can_Focus(False);
		frmSplash.label4.Set_Label("hfsguardadiretorio 2.0");
	
		frmSplash.vbox2 := Gtk_Vbox_New(False, 0);
		frmSplash.vbox2.Set_Name("vbox2");
		frmSplash.vbox2.Set_Visible(True);
		frmSplash.vbox2.Set_Can_Focus(False);
		frmSplash.vbox2.Pack_Start(frmSplash.label4, False, True, 0);
		frmSplash.vbox2.Pack_Start(frmSplash.label5, False, True, 0);
		frmSplash.vbox2.Pack_Start(frmSplash.pb1, False, True, 0);
	
		frmSplash.Set_Name("frmSplash");
		frmSplash.Set_Size_Request(375, 113);
		frmSplash.Set_Visible(True);
		frmSplash.Set_Can_Focus(False);
		frmSplash.Set_Modal(True);
		frmSplash.Set_Position(Win_Pos_Center_Always);
		frmSplash.Set_Default_Size(375, 113);
		frmSplash.Set_Decorated(False);
		frmSplash.Add(frmSplash.vbox2);
	

				
	end Inicializa;

	procedure Mostrar is
		retorno: Gtk_Response_Type;
		pragma Unreferenced(retorno);	
	begin
		Criar(frmSplash);
		frmSplash.Set_Position(Win_Pos_Center_Always);
		frmSplash.Show_All;
	end Mostrar;

	

end FrmSplash;
