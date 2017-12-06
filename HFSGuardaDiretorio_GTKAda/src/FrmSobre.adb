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

package body FrmSobre is

	procedure Criar(frmSobre: out FrmSobre_Access) is
	begin
		frmSobre := new frmSobre_Record;
		Inicializa(frmSobre);
	end Criar;

	procedure Inicializa(frmSobre: access FrmSobre_Record'Class) is
		pragma Suppress(All_Checks);
		Num: Gint;
		pragma Unreferenced(Num);
		Text_Render: Gtk_Cell_Renderer_Text := Gtk_Cell_Renderer_Text_New;
	begin
		Dialog.Initialize(frmSobre);

		frmSobre.btbOk := Gtk_Button_New_With_Label("_Ok");
		frmSobre.btbOk.Set_Name("btbOk");
		frmSobre.btbOk.Set_Label("_Ok");
		frmSobre.btbOk.Set_Visible(True);
		frmSobre.btbOk.Set_Can_Focus(True);
		frmSobre.btbOk.Set_Receives_Default(True);
		frmSobre.btbOk.Set_Use_Underline(True);
	
		frmSobre.dialog_action_area1 := Gtk_Hbutton_Box_New;
		frmSobre.dialog_action_area1.Set_Name("dialog_action_area1");
		frmSobre.dialog_action_area1.Set_Visible(True);
		frmSobre.dialog_action_area1.Set_Can_Focus(False);
		frmSobre.dialog_action_area1.Set_Layout(Buttonbox_Center);
		frmSobre.dialog_action_area1.Pack_Start(frmSobre.btbOk, False, False, 0);
	
		frmSobre.label10 := Gtk_Label_New;
		frmSobre.label10.Set_Name("label10");
		frmSobre.label10.Set_Visible(True);
		frmSobre.label10.Set_Can_Focus(False);
		frmSobre.label10.Set_Label("todos os direitos reservados, 2015");
	
		frmSobre.label9 := Gtk_Label_New;
		frmSobre.label9.Set_Name("label9");
		frmSobre.label9.Set_Visible(True);
		frmSobre.label9.Set_Can_Focus(False);
		frmSobre.label9.Set_Label("por henrique figueiredo de souza");
	
		frmSobre.label8 := Gtk_Label_New;
		frmSobre.label8.Set_Name("label8");
		frmSobre.label8.Set_Visible(True);
		frmSobre.label8.Set_Can_Focus(False);
		frmSobre.label8.Set_Label("desenvolvido em c com gtk, versão: 2.0");
	
		frmSobre.label := Gtk_Label_New;
		frmSobre.label.Set_Name("label");
		frmSobre.label.Set_Visible(True);
		frmSobre.label.Set_Can_Focus(False);
		frmSobre.label.Set_Label("hfsguardadir 2.0 - catalogador de diretórios");
	
		frmSobre.vbox4 := Gtk_Vbox_New(False, 0);
		frmSobre.vbox4.Set_Name("vbox4");
		frmSobre.vbox4.Set_Visible(True);
		frmSobre.vbox4.Set_Can_Focus(False);
		frmSobre.vbox4.Pack_Start(frmSobre.label, False, True, 0);
		frmSobre.vbox4.Pack_Start(frmSobre.label8, False, True, 0);
		frmSobre.vbox4.Pack_Start(frmSobre.label9, False, True, 0);
		frmSobre.vbox4.Pack_Start(frmSobre.label10, False, True, 0);
	
		frmSobre.dialog_vbox1 := Gtk_Vbox_New(False, 0);
		frmSobre.dialog_vbox1.Set_Name("dialog_vbox1");
		frmSobre.dialog_vbox1.Set_Visible(True);
		frmSobre.dialog_vbox1.Set_Can_Focus(False);
		frmSobre.dialog_vbox1.Set_Spacing(2);
		frmSobre.dialog_vbox1.Pack_Start(frmSobre.vbox4, True, True, 0);
		frmSobre.dialog_vbox1.Pack_Start(frmSobre.dialog_action_area1, False, True, 0);
	
		frmSobre.Set_Name("frmSobre");
		frmSobre.Set_Can_Focus(False);
		frmSobre.Set_Border_Width(5);
		frmSobre.Set_Title("sobre o catalogador");
		frmSobre.Set_Resizable(False);
		frmSobre.Set_Modal(True);
		frmSobre.Set_Position(Win_Pos_Center);
		frmSobre.Set_Default_Size(300, 150);
		frmSobre.Get_Content_Area.Pack_Start(frmSobre.dialog_vbox1, True, True, 0);
	

		frmSobre.btbOk.On_Clicked(on_btbOk_clicked'Access);
		
	end Inicializa;

	procedure Mostrar is
		retorno: Gtk_Response_Type;
		pragma Unreferenced(retorno);	
	begin
		Criar(frmSobre);
		frmSobre.Set_Position(Win_Pos_Center_Always);
		retorno := frmSobre.Run;
		frmSobre.Destroy;
	end Mostrar;

	procedure on_btbOk_clicked(source: access Gtk_Button_Record'Class) is
	begin
		null;
	end on_btbOk_clicked;



end FrmSobre;
