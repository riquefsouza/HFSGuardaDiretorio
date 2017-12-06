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

package body FrmInfoDiretorio is

	procedure Criar(frmInfoDiretorio: out FrmInfoDiretorio_Access) is
	begin
		frmInfoDiretorio := new frmInfoDiretorio_Record;
		Inicializa(frmInfoDiretorio);
	end Criar;

	procedure Inicializa(frmInfoDiretorio: access FrmInfoDiretorio_Record'Class) is
		pragma Suppress(All_Checks);
		Num: Gint;
		pragma Unreferenced(Num);
		Text_Render: Gtk_Cell_Renderer_Text := Gtk_Cell_Renderer_Text_New;
	begin
		Dialog.Initialize(frmInfoDiretorio);

		frmInfoDiretorio.btnOk := Gtk_Button_New_With_Label("gtk-ok");
		frmInfoDiretorio.btnOk.Set_Name("btnOk");
		frmInfoDiretorio.btnOk.Set_Label("gtk-ok");
		frmInfoDiretorio.btnOk.Set_Visible(True);
		frmInfoDiretorio.btnOk.Set_Can_Focus(True);
		frmInfoDiretorio.btnOk.Set_Receives_Default(True);
		frmInfoDiretorio.btnOk.Set_Use_Stock(True);
	
		frmInfoDiretorio.dialog_action_area3 := Gtk_Hbutton_Box_New;
		frmInfoDiretorio.dialog_action_area3.Set_Name("dialog_action_area3");
		frmInfoDiretorio.dialog_action_area3.Set_Visible(True);
		frmInfoDiretorio.dialog_action_area3.Set_Can_Focus(False);
		frmInfoDiretorio.dialog_action_area3.Set_Layout(Buttonbox_Center);
		frmInfoDiretorio.dialog_action_area3.Pack_Start(frmInfoDiretorio.btnOk, False, False, 0);
	
		frmInfoDiretorio.colunaInfoDescricao := Gtk_Tree_View_Column_New;
		frmInfoDiretorio.colunaInfoDescricao.Set_Resizable(True);
		frmInfoDiretorio.colunaInfoDescricao.Set_Sizing(Tree_View_Column_Autosize);
		frmInfoDiretorio.colunaInfoDescricao.Set_Title("descrição");
		frmInfoDiretorio.colunaInfoDescricao.Set_Sort_Column_Id(1);
	
		frmInfoDiretorio.colunaInfoItem := Gtk_Tree_View_Column_New;
		frmInfoDiretorio.colunaInfoItem.Set_Resizable(True);
		frmInfoDiretorio.colunaInfoItem.Set_Sizing(Tree_View_Column_Autosize);
		frmInfoDiretorio.colunaInfoItem.Set_Title("item");
		frmInfoDiretorio.colunaInfoItem.Set_Sort_Column_Id(1);
	
		frmInfoDiretorio.tabelaInfo := Gtk_Tree_View_New;
		frmInfoDiretorio.tabelaInfo.Set_Name("tabelaInfo");
		frmInfoDiretorio.tabelaInfo.Set_Visible(True);
		frmInfoDiretorio.tabelaInfo.Set_Can_Focus(True);
		frmInfoDiretorio.tabelaInfo.Set_Model(Rotinas.modelo_lsTabelaInfo);
		Num := frmInfoDiretorio.tabelaInfo.Append_Column(frmInfoDiretorio.colunaInfoItem);
		frmInfoDiretorio.colunaInfoItem.Pack_Start(Text_Render, True);
		frmInfoDiretorio.colunaInfoItem.Add_Attribute(Text_Render, "text", 0);
		Num := frmInfoDiretorio.tabelaInfo.Append_Column(frmInfoDiretorio.colunaInfoDescricao);
		frmInfoDiretorio.colunaInfoDescricao.Pack_Start(Text_Render, True);
		frmInfoDiretorio.colunaInfoDescricao.Add_Attribute(Text_Render, "text", 1);
	
		frmInfoDiretorio.scrollTabela1 := Gtk_Scrolled_Window_New;
		frmInfoDiretorio.scrollTabela1.Set_Name("scrollTabela1");
		frmInfoDiretorio.scrollTabela1.Set_Visible(True);
		frmInfoDiretorio.scrollTabela1.Set_Can_Focus(True);
		frmInfoDiretorio.scrollTabela1.Set_Policy(Policy_Automatic, Policy_Automatic);
		frmInfoDiretorio.scrollTabela1.Add(frmInfoDiretorio.tabelaInfo);
	
		frmInfoDiretorio.labArquivoSomenteLeitura := Gtk_Label_New;
		frmInfoDiretorio.labArquivoSomenteLeitura.Set_Name("labArquivoSomenteLeitura");
		frmInfoDiretorio.labArquivoSomenteLeitura.Set_Visible(True);
		frmInfoDiretorio.labArquivoSomenteLeitura.Set_Can_Focus(False);
		frmInfoDiretorio.labArquivoSomenteLeitura.Set_Label("[rol] - arquivo somente leitura");
	
		frmInfoDiretorio.labVolumeID := Gtk_Label_New;
		frmInfoDiretorio.labVolumeID.Set_Name("labVolumeID");
		frmInfoDiretorio.labVolumeID.Set_Visible(True);
		frmInfoDiretorio.labVolumeID.Set_Can_Focus(False);
		frmInfoDiretorio.labVolumeID.Set_Label("[vol] - volume id");
	
		frmInfoDiretorio.labLegendaDiretorio := Gtk_Label_New;
		frmInfoDiretorio.labLegendaDiretorio.Set_Name("labLegendaDiretorio");
		frmInfoDiretorio.labLegendaDiretorio.Set_Visible(True);
		frmInfoDiretorio.labLegendaDiretorio.Set_Can_Focus(False);
		frmInfoDiretorio.labLegendaDiretorio.Set_Label("[dir] - diretório");
	
		frmInfoDiretorio.labArquivoSistema := Gtk_Label_New;
		frmInfoDiretorio.labArquivoSistema.Set_Name("labArquivoSistema");
		frmInfoDiretorio.labArquivoSistema.Set_Visible(True);
		frmInfoDiretorio.labArquivoSistema.Set_Can_Focus(False);
		frmInfoDiretorio.labArquivoSistema.Set_Label("[sys] - arquivo de sistema");
	
		frmInfoDiretorio.labArquivoOculto := Gtk_Label_New;
		frmInfoDiretorio.labArquivoOculto.Set_Name("labArquivoOculto");
		frmInfoDiretorio.labArquivoOculto.Set_Visible(True);
		frmInfoDiretorio.labArquivoOculto.Set_Can_Focus(False);
		frmInfoDiretorio.labArquivoOculto.Set_Label("[hid] - arquivo oculto");
	
		frmInfoDiretorio.labArquivoComum := Gtk_Label_New;
		frmInfoDiretorio.labArquivoComum.Set_Name("labArquivoComum");
		frmInfoDiretorio.labArquivoComum.Set_Visible(True);
		frmInfoDiretorio.labArquivoComum.Set_Can_Focus(False);
		frmInfoDiretorio.labArquivoComum.Set_Label("[arq] - arquivo comum");
	
		frmInfoDiretorio.table1 := Gtk_Table_New(3, 2, true);
		frmInfoDiretorio.table1.Set_Name("table1");
		frmInfoDiretorio.table1.Set_Visible(True);
		frmInfoDiretorio.table1.Set_Can_Focus(False);
		frmInfoDiretorio.table1.Attach(frmInfoDiretorio.labArquivoComum, 0, 1, 0, 1, Fill, Fill, 5, 5);
		frmInfoDiretorio.table1.Attach(frmInfoDiretorio.labArquivoOculto, 1, 2, 0, 1, Fill, Fill, 5, 5);
		frmInfoDiretorio.table1.Attach(frmInfoDiretorio.labArquivoSistema, 0, 1, 1, 2, Fill, Fill, 5, 5);
		frmInfoDiretorio.table1.Attach(frmInfoDiretorio.labLegendaDiretorio, 1, 2, 1, 2, Fill, Fill, 5, 5);
		frmInfoDiretorio.table1.Attach(frmInfoDiretorio.labVolumeID, 0, 1, 2, 3, Fill, Fill, 5, 5);
		frmInfoDiretorio.table1.Attach(frmInfoDiretorio.labArquivoSomenteLeitura, 1, 2, 2, 3, Fill, Fill, 5, 5);
	
		frmInfoDiretorio.frame1 := Gtk_Frame_New;
		frmInfoDiretorio.frame1.Set_Name("frame1");
		frmInfoDiretorio.frame1.Set_Visible(True);
		frmInfoDiretorio.frame1.Set_Can_Focus(False);
		frmInfoDiretorio.frame1.Set_Label_Align(0.0, 0.0);
		frmInfoDiretorio.frame1.Add(frmInfoDiretorio.table1);
	
		frmInfoDiretorio.vbox3 := Gtk_Vbox_New(False, 0);
		frmInfoDiretorio.vbox3.Set_Name("vbox3");
		frmInfoDiretorio.vbox3.Set_Visible(True);
		frmInfoDiretorio.vbox3.Set_Can_Focus(False);
		frmInfoDiretorio.vbox3.Pack_Start(frmInfoDiretorio.frame1, False, True, 0);
		frmInfoDiretorio.vbox3.Pack_Start(frmInfoDiretorio.scrollTabela1, True, True, 0);
	
		frmInfoDiretorio.dialog_vbox3 := Gtk_Vbox_New(False, 0);
		frmInfoDiretorio.dialog_vbox3.Set_Name("dialog_vbox3");
		frmInfoDiretorio.dialog_vbox3.Set_Visible(True);
		frmInfoDiretorio.dialog_vbox3.Set_Can_Focus(False);
		frmInfoDiretorio.dialog_vbox3.Set_Spacing(2);
		frmInfoDiretorio.dialog_vbox3.Pack_Start(frmInfoDiretorio.vbox3, True, True, 0);
		frmInfoDiretorio.dialog_vbox3.Pack_Start(frmInfoDiretorio.dialog_action_area3, False, True, 0);
	
		frmInfoDiretorio.Set_Name("frmInfoDiretorio");
		frmInfoDiretorio.Set_Size_Request(369, 372);
		frmInfoDiretorio.Set_Visible(True);
		frmInfoDiretorio.Set_Can_Focus(False);
		frmInfoDiretorio.Set_Border_Width(5);
		frmInfoDiretorio.Set_Title("informações do diretório / arquivo");
		frmInfoDiretorio.Set_Resizable(False);
		frmInfoDiretorio.Set_Modal(True);
		frmInfoDiretorio.Set_Position(Win_Pos_Center);
		frmInfoDiretorio.Get_Content_Area.Pack_Start(frmInfoDiretorio.dialog_vbox3, True, True, 0);
	

		frmInfoDiretorio.btnOk.On_Clicked(on_btnOk_clicked'Access);
		
	end Inicializa;

	procedure Mostrar is
		retorno: Gtk_Response_Type;
		pragma Unreferenced(retorno);	
	begin
		Criar(frmInfoDiretorio);
		frmInfoDiretorio.Set_Position(Win_Pos_Center_Always);
		retorno := frmInfoDiretorio.Run;
		frmInfoDiretorio.Destroy;
	end Mostrar;

	procedure on_btnOk_clicked(source: access Gtk_Button_Record'Class) is
	begin
		null;
	end on_btnOk_clicked;



end FrmInfoDiretorio;
