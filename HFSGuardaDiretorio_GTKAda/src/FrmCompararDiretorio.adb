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

package body FrmCompararDiretorio is

	procedure Criar(frmCompararDiretorio: out FrmCompararDiretorio_Access) is
	begin
		frmCompararDiretorio := new frmCompararDiretorio_Record;
		Inicializa(frmCompararDiretorio);
	end Criar;

	procedure Inicializa(frmCompararDiretorio: access FrmCompararDiretorio_Record'Class) is
		pragma Suppress(All_Checks);
		Num: Gint;
		pragma Unreferenced(Num);
		Text_Render: Gtk_Cell_Renderer_Text := Gtk_Cell_Renderer_Text_New;
	begin
		Window.Initialize(frmCompararDiretorio, Window_TopLevel);

		frmCompararDiretorio.barraStatus21 := Gtk_Status_Bar_New;
		frmCompararDiretorio.barraStatus21.Set_Name("barraStatus21");
		frmCompararDiretorio.barraStatus21.Set_Visible(True);
		frmCompararDiretorio.barraStatus21.Set_Can_Focus(False);
		frmCompararDiretorio.barraStatus21.Set_Spacing(2);
	
		frmCompararDiretorio.barraStatus11 := Gtk_Status_Bar_New;
		frmCompararDiretorio.barraStatus11.Set_Name("barraStatus11");
		frmCompararDiretorio.barraStatus11.Set_Size_Request(300, -1);
		frmCompararDiretorio.barraStatus11.Set_Visible(True);
		frmCompararDiretorio.barraStatus11.Set_Can_Focus(False);
		frmCompararDiretorio.barraStatus11.Set_Spacing(2);
	
		frmCompararDiretorio.hbox5 := Gtk_Hbox_New(False, 0);
		frmCompararDiretorio.hbox5.Set_Name("hbox5");
		frmCompararDiretorio.hbox5.Set_Visible(True);
		frmCompararDiretorio.hbox5.Set_Can_Focus(False);
		frmCompararDiretorio.hbox5.Pack_Start(frmCompararDiretorio.barraStatus11, False, True, 0);
		frmCompararDiretorio.hbox5.Pack_Start(frmCompararDiretorio.barraStatus21, True, True, 0);
	
		frmCompararDiretorio.colunaComparaCaminho := Gtk_Tree_View_Column_New;
		frmCompararDiretorio.colunaComparaCaminho.Set_Resizable(True);
		frmCompararDiretorio.colunaComparaCaminho.Set_Sizing(Tree_View_Column_Autosize);
		frmCompararDiretorio.colunaComparaCaminho.Set_Title("caminho");
		frmCompararDiretorio.colunaComparaCaminho.Set_Sort_Indicator(True);
		frmCompararDiretorio.colunaComparaCaminho.Set_Sort_Column_Id(6);
	
		frmCompararDiretorio.colunaComparaAtributos := Gtk_Tree_View_Column_New;
		frmCompararDiretorio.colunaComparaAtributos.Set_Resizable(True);
		frmCompararDiretorio.colunaComparaAtributos.Set_Sizing(Tree_View_Column_Autosize);
		frmCompararDiretorio.colunaComparaAtributos.Set_Title("atributos");
		frmCompararDiretorio.colunaComparaAtributos.Set_Sort_Indicator(True);
		frmCompararDiretorio.colunaComparaAtributos.Set_Sort_Column_Id(5);
	
		frmCompararDiretorio.colunaComparaModificado := Gtk_Tree_View_Column_New;
		frmCompararDiretorio.colunaComparaModificado.Set_Resizable(True);
		frmCompararDiretorio.colunaComparaModificado.Set_Sizing(Tree_View_Column_Autosize);
		frmCompararDiretorio.colunaComparaModificado.Set_Title("modificado");
		frmCompararDiretorio.colunaComparaModificado.Set_Sort_Indicator(True);
		frmCompararDiretorio.colunaComparaModificado.Set_Sort_Column_Id(4);
	
		frmCompararDiretorio.colunaComparaTipo := Gtk_Tree_View_Column_New;
		frmCompararDiretorio.colunaComparaTipo.Set_Resizable(True);
		frmCompararDiretorio.colunaComparaTipo.Set_Sizing(Tree_View_Column_Autosize);
		frmCompararDiretorio.colunaComparaTipo.Set_Title("tipo");
		frmCompararDiretorio.colunaComparaTipo.Set_Sort_Indicator(True);
		frmCompararDiretorio.colunaComparaTipo.Set_Sort_Column_Id(3);
	
		frmCompararDiretorio.colunaComparaTamanho := Gtk_Tree_View_Column_New;
		frmCompararDiretorio.colunaComparaTamanho.Set_Resizable(True);
		frmCompararDiretorio.colunaComparaTamanho.Set_Sizing(Tree_View_Column_Autosize);
		frmCompararDiretorio.colunaComparaTamanho.Set_Title("tamanho");
		frmCompararDiretorio.colunaComparaTamanho.Set_Sort_Indicator(True);
		frmCompararDiretorio.colunaComparaTamanho.Set_Sort_Column_Id(2);
	
		frmCompararDiretorio.colunaComparaNome := Gtk_Tree_View_Column_New;
		frmCompararDiretorio.colunaComparaNome.Set_Resizable(True);
		frmCompararDiretorio.colunaComparaNome.Set_Sizing(Tree_View_Column_Autosize);
		frmCompararDiretorio.colunaComparaNome.Set_Title("nome");
		frmCompararDiretorio.colunaComparaNome.Set_Sort_Indicator(True);
		frmCompararDiretorio.colunaComparaNome.Set_Sort_Column_Id(1);
	
		frmCompararDiretorio.tabelaCompara := Gtk_Tree_View_New;
		frmCompararDiretorio.tabelaCompara.Set_Name("tabelaCompara");
		frmCompararDiretorio.tabelaCompara.Set_Visible(True);
		frmCompararDiretorio.tabelaCompara.Set_Can_Focus(True);
		frmCompararDiretorio.tabelaCompara.Set_Model(Rotinas.modelo_lsTabelaCompara);
		Num := frmCompararDiretorio.tabelaCompara.Append_Column(frmCompararDiretorio.colunaComparaNome);
		frmCompararDiretorio.colunaComparaNome.Pack_Start(Text_Render, True);
		frmCompararDiretorio.colunaComparaNome.Add_Attribute(Text_Render, "text", 0);
		Num := frmCompararDiretorio.tabelaCompara.Append_Column(frmCompararDiretorio.colunaComparaTamanho);
		frmCompararDiretorio.colunaComparaTamanho.Pack_Start(Text_Render, True);
		frmCompararDiretorio.colunaComparaTamanho.Add_Attribute(Text_Render, "text", 1);
		Num := frmCompararDiretorio.tabelaCompara.Append_Column(frmCompararDiretorio.colunaComparaTipo);
		frmCompararDiretorio.colunaComparaTipo.Pack_Start(Text_Render, True);
		frmCompararDiretorio.colunaComparaTipo.Add_Attribute(Text_Render, "text", 2);
		Num := frmCompararDiretorio.tabelaCompara.Append_Column(frmCompararDiretorio.colunaComparaModificado);
		frmCompararDiretorio.colunaComparaModificado.Pack_Start(Text_Render, True);
		frmCompararDiretorio.colunaComparaModificado.Add_Attribute(Text_Render, "text", 3);
		Num := frmCompararDiretorio.tabelaCompara.Append_Column(frmCompararDiretorio.colunaComparaAtributos);
		frmCompararDiretorio.colunaComparaAtributos.Pack_Start(Text_Render, True);
		frmCompararDiretorio.colunaComparaAtributos.Add_Attribute(Text_Render, "text", 4);
		Num := frmCompararDiretorio.tabelaCompara.Append_Column(frmCompararDiretorio.colunaComparaCaminho);
		frmCompararDiretorio.colunaComparaCaminho.Pack_Start(Text_Render, True);
		frmCompararDiretorio.colunaComparaCaminho.Add_Attribute(Text_Render, "text", 5);
	
		frmCompararDiretorio.scrollTabela12 := Gtk_Scrolled_Window_New;
		frmCompararDiretorio.scrollTabela12.Set_Name("scrollTabela12");
		frmCompararDiretorio.scrollTabela12.Set_Visible(True);
		frmCompararDiretorio.scrollTabela12.Set_Can_Focus(True);
		frmCompararDiretorio.scrollTabela12.Set_Policy(Policy_Automatic, Policy_Automatic);
		frmCompararDiretorio.scrollTabela12.Add(frmCompararDiretorio.tabelaCompara);
	
		frmCompararDiretorio.labDiferencasEncontradas := Gtk_Label_New;
		frmCompararDiretorio.labDiferencasEncontradas.Set_Name("labDiferencasEncontradas");
		frmCompararDiretorio.labDiferencasEncontradas.Set_Visible(True);
		frmCompararDiretorio.labDiferencasEncontradas.Set_Can_Focus(False);
		frmCompararDiretorio.labDiferencasEncontradas.Set_Label("diferenças encontradas");
	
		frmCompararDiretorio.hbox4 := Gtk_Hbox_New(False, 0);
		frmCompararDiretorio.hbox4.Set_Name("hbox4");
		frmCompararDiretorio.hbox4.Set_Visible(True);
		frmCompararDiretorio.hbox4.Set_Can_Focus(False);
		frmCompararDiretorio.hbox4.Pack_Start(frmCompararDiretorio.labDiferencasEncontradas, False, True, 0);
	
		frmCompararDiretorio.label6 := Gtk_Label_New;
		frmCompararDiretorio.label6.Set_Name("label6");
		frmCompararDiretorio.label6.Set_Visible(True);
		frmCompararDiretorio.label6.Set_Can_Focus(False);
		frmCompararDiretorio.label6.Set_Label("<b>diretório 2</b>");
		frmCompararDiretorio.label6.Set_Use_Markup(True);
	
		frmCompararDiretorio.colunaArvoreDiretorio2 := Gtk_Tree_View_Column_New;
		frmCompararDiretorio.colunaArvoreDiretorio2.Set_Title("column");
	
		frmCompararDiretorio.tvDiretorio2 := Gtk_Tree_View_New;
		frmCompararDiretorio.tvDiretorio2.Set_Name("tvDiretorio2");
		frmCompararDiretorio.tvDiretorio2.Set_Visible(True);
		frmCompararDiretorio.tvDiretorio2.Set_Can_Focus(True);
		frmCompararDiretorio.tvDiretorio2.Set_Model(Rotinas.modelo_tsArvoreDiretorio2);
		frmCompararDiretorio.tvDiretorio2.Set_Headers_Visible(False);
		Num := frmCompararDiretorio.tvDiretorio2.Append_Column(frmCompararDiretorio.colunaArvoreDiretorio2);
		frmCompararDiretorio.colunaArvoreDiretorio2.Pack_Start(Text_Render, True);
		frmCompararDiretorio.colunaArvoreDiretorio2.Add_Attribute(Text_Render, "text", 0);
	
		frmCompararDiretorio.scrolledwindow4 := Gtk_Scrolled_Window_New;
		frmCompararDiretorio.scrolledwindow4.Set_Name("scrolledwindow4");
		frmCompararDiretorio.scrolledwindow4.Set_Visible(True);
		frmCompararDiretorio.scrolledwindow4.Set_Can_Focus(True);
		frmCompararDiretorio.scrolledwindow4.Set_Policy(Policy_Automatic, Policy_Automatic);
		frmCompararDiretorio.scrolledwindow4.Add(frmCompararDiretorio.tvDiretorio2);
	
		frmCompararDiretorio.cmbAba2 := Gtk_Combo_Box_New;
		frmCompararDiretorio.cmbAba2.Set_Name("cmbAba2");
		frmCompararDiretorio.cmbAba2.Set_Visible(True);
		frmCompararDiretorio.cmbAba2.Set_Can_Focus(False);
	
		frmCompararDiretorio.vbox7 := Gtk_Vbox_New(False, 0);
		frmCompararDiretorio.vbox7.Set_Name("vbox7");
		frmCompararDiretorio.vbox7.Set_Visible(True);
		frmCompararDiretorio.vbox7.Set_Can_Focus(False);
		frmCompararDiretorio.vbox7.Pack_Start(frmCompararDiretorio.cmbAba2, False, True, 0);
		frmCompararDiretorio.vbox7.Pack_Start(frmCompararDiretorio.scrolledwindow4, True, True, 0);
	
		frmCompararDiretorio.alignment2 := Gtk_Alignment_New(0.0, 0.0, 1.0, 1.0);
		frmCompararDiretorio.alignment2.Set_Name("alignment2");
		frmCompararDiretorio.alignment2.Set_Visible(True);
		frmCompararDiretorio.alignment2.Set_Can_Focus(False);
		frmCompararDiretorio.alignment2.Set_Padding(0, 0, 12, 0);
		frmCompararDiretorio.alignment2.Add(frmCompararDiretorio.vbox7);
	
		frmCompararDiretorio.frame3 := Gtk_Frame_New;
		frmCompararDiretorio.frame3.Set_Name("frame3");
		frmCompararDiretorio.frame3.Set_Visible(True);
		frmCompararDiretorio.frame3.Set_Can_Focus(False);
		frmCompararDiretorio.frame3.Set_Label_Align(0.0, 0.0);
		frmCompararDiretorio.frame3.Set_Shadow_Type(Shadow_None);
		frmCompararDiretorio.frame3.Add(frmCompararDiretorio.alignment2);
		frmCompararDiretorio.frame3.Set_Label_Widget(frmCompararDiretorio.label6);
	
		frmCompararDiretorio.labDiretorio1 := Gtk_Label_New;
		frmCompararDiretorio.labDiretorio1.Set_Name("labDiretorio1");
		frmCompararDiretorio.labDiretorio1.Set_Visible(True);
		frmCompararDiretorio.labDiretorio1.Set_Can_Focus(False);
		frmCompararDiretorio.labDiretorio1.Set_Label("<b>diretório 1</b>");
		frmCompararDiretorio.labDiretorio1.Set_Use_Markup(True);
	
		frmCompararDiretorio.colunaArvoreDiretorio1 := Gtk_Tree_View_Column_New;
		frmCompararDiretorio.colunaArvoreDiretorio1.Set_Title("coluna");
	
		frmCompararDiretorio.tvDiretorio1 := Gtk_Tree_View_New;
		frmCompararDiretorio.tvDiretorio1.Set_Name("tvDiretorio1");
		frmCompararDiretorio.tvDiretorio1.Set_Visible(True);
		frmCompararDiretorio.tvDiretorio1.Set_Can_Focus(True);
		frmCompararDiretorio.tvDiretorio1.Set_Model(Rotinas.modelo_tsArvoreDiretorio1);
		frmCompararDiretorio.tvDiretorio1.Set_Headers_Visible(False);
		Num := frmCompararDiretorio.tvDiretorio1.Append_Column(frmCompararDiretorio.colunaArvoreDiretorio1);
		frmCompararDiretorio.colunaArvoreDiretorio1.Pack_Start(Text_Render, True);
		frmCompararDiretorio.colunaArvoreDiretorio1.Add_Attribute(Text_Render, "text", 0);
	
		frmCompararDiretorio.scrolledwindow3 := Gtk_Scrolled_Window_New;
		frmCompararDiretorio.scrolledwindow3.Set_Name("scrolledwindow3");
		frmCompararDiretorio.scrolledwindow3.Set_Visible(True);
		frmCompararDiretorio.scrolledwindow3.Set_Can_Focus(True);
		frmCompararDiretorio.scrolledwindow3.Set_Policy(Policy_Automatic, Policy_Automatic);
		frmCompararDiretorio.scrolledwindow3.Add(frmCompararDiretorio.tvDiretorio1);
	
		frmCompararDiretorio.cmbAba1 := Gtk_Combo_Box_New;
		frmCompararDiretorio.cmbAba1.Set_Name("cmbAba1");
		frmCompararDiretorio.cmbAba1.Set_Visible(True);
		frmCompararDiretorio.cmbAba1.Set_Can_Focus(False);
	
		frmCompararDiretorio.vbox6 := Gtk_Vbox_New(False, 0);
		frmCompararDiretorio.vbox6.Set_Name("vbox6");
		frmCompararDiretorio.vbox6.Set_Visible(True);
		frmCompararDiretorio.vbox6.Set_Can_Focus(False);
		frmCompararDiretorio.vbox6.Pack_Start(frmCompararDiretorio.cmbAba1, False, True, 0);
		frmCompararDiretorio.vbox6.Pack_Start(frmCompararDiretorio.scrolledwindow3, True, True, 0);
	
		frmCompararDiretorio.alignment1 := Gtk_Alignment_New(0.0, 0.0, 1.0, 1.0);
		frmCompararDiretorio.alignment1.Set_Name("alignment1");
		frmCompararDiretorio.alignment1.Set_Visible(True);
		frmCompararDiretorio.alignment1.Set_Can_Focus(False);
		frmCompararDiretorio.alignment1.Set_Padding(0, 0, 12, 0);
		frmCompararDiretorio.alignment1.Add(frmCompararDiretorio.vbox6);
	
		frmCompararDiretorio.frame2 := Gtk_Frame_New;
		frmCompararDiretorio.frame2.Set_Name("frame2");
		frmCompararDiretorio.frame2.Set_Visible(True);
		frmCompararDiretorio.frame2.Set_Can_Focus(False);
		frmCompararDiretorio.frame2.Set_Label_Align(0.0, 0.0);
		frmCompararDiretorio.frame2.Set_Shadow_Type(Shadow_None);
		frmCompararDiretorio.frame2.Add(frmCompararDiretorio.alignment1);
		frmCompararDiretorio.frame2.Set_Label_Widget(frmCompararDiretorio.labDiretorio1);
	
		frmCompararDiretorio.hbox2 := Gtk_Hbox_New(False, 0);
		frmCompararDiretorio.hbox2.Set_Name("hbox2");
		frmCompararDiretorio.hbox2.Set_Visible(True);
		frmCompararDiretorio.hbox2.Set_Can_Focus(False);
		frmCompararDiretorio.hbox2.Pack_Start(frmCompararDiretorio.frame2, True, True, 0);
		frmCompararDiretorio.hbox2.Pack_Start(frmCompararDiretorio.frame3, True, True, 0);
	
		frmCompararDiretorio.btnSalvarLog := Gtk_Button_New_With_Label("salvar log");
		frmCompararDiretorio.btnSalvarLog.Set_Name("btnSalvarLog");
		frmCompararDiretorio.btnSalvarLog.Set_Label("salvar log");
		frmCompararDiretorio.btnSalvarLog.Set_Visible(True);
		frmCompararDiretorio.btnSalvarLog.Set_Can_Focus(True);
		frmCompararDiretorio.btnSalvarLog.Set_Receives_Default(True);
	
		frmCompararDiretorio.pb2 := Gtk_Progress_Bar_New;
		frmCompararDiretorio.pb2.Set_Name("pb2");
		frmCompararDiretorio.pb2.Set_Visible(True);
		frmCompararDiretorio.pb2.Set_Can_Focus(False);
	
		frmCompararDiretorio.btnCompararDiretorios := Gtk_Button_New_With_Label("comparar diretórios");
		frmCompararDiretorio.btnCompararDiretorios.Set_Name("btnCompararDiretorios");
		frmCompararDiretorio.btnCompararDiretorios.Set_Label("comparar diretórios");
		frmCompararDiretorio.btnCompararDiretorios.Set_Visible(True);
		frmCompararDiretorio.btnCompararDiretorios.Set_Can_Focus(True);
		frmCompararDiretorio.btnCompararDiretorios.Set_Receives_Default(True);
	
		frmCompararDiretorio.hbox1 := Gtk_Hbox_New(False, 0);
		frmCompararDiretorio.hbox1.Set_Name("hbox1");
		frmCompararDiretorio.hbox1.Set_Visible(True);
		frmCompararDiretorio.hbox1.Set_Can_Focus(False);
		frmCompararDiretorio.hbox1.Pack_Start(frmCompararDiretorio.btnCompararDiretorios, False, True, 0);
		frmCompararDiretorio.hbox1.Pack_Start(frmCompararDiretorio.pb2, True, True, 0);
		frmCompararDiretorio.hbox1.Pack_Start(frmCompararDiretorio.btnSalvarLog, False, True, 0);
	
		frmCompararDiretorio.vbox5 := Gtk_Vbox_New(False, 0);
		frmCompararDiretorio.vbox5.Set_Name("vbox5");
		frmCompararDiretorio.vbox5.Set_Visible(True);
		frmCompararDiretorio.vbox5.Set_Can_Focus(False);
		frmCompararDiretorio.vbox5.Pack_Start(frmCompararDiretorio.hbox1, False, False, 0);
		frmCompararDiretorio.vbox5.Pack_Start(frmCompararDiretorio.hbox2, True, True, 0);
		frmCompararDiretorio.vbox5.Pack_Start(frmCompararDiretorio.hbox4, False, True, 0);
		frmCompararDiretorio.vbox5.Pack_Start(frmCompararDiretorio.scrollTabela12, True, True, 0);
		frmCompararDiretorio.vbox5.Pack_Start(frmCompararDiretorio.hbox5, False, True, 0);
	
		frmCompararDiretorio.Set_Name("frmCompararDiretorio");
		frmCompararDiretorio.Set_Size_Request(700, 600);
		frmCompararDiretorio.Set_Visible(True);
		frmCompararDiretorio.Set_Can_Focus(False);
		frmCompararDiretorio.Set_Title("comparar diretórios");
		frmCompararDiretorio.Set_Resizable(False);
		frmCompararDiretorio.Set_Modal(True);
		frmCompararDiretorio.Set_Position(Win_Pos_Center);
		frmCompararDiretorio.Set_Default_Size(700, 600);
		frmCompararDiretorio.Add(frmCompararDiretorio.vbox5);
	

		frmCompararDiretorio.btnCompararDiretorios.On_Clicked(on_btnCompararDiretorios_clicked'Access);
		frmCompararDiretorio.btnSalvarLog.On_Clicked(btnSalvarLog_clicked_cb'Access);
		frmCompararDiretorio.cmbAba1.On_Changed(on_cmbAba1_changed'Access);
		frmCompararDiretorio.tvDiretorio1.On_Row_Collapsed(on_tvDiretorio1_row_collapsed'Access);
		frmCompararDiretorio.tvDiretorio1.On_Row_Expanded(on_tvDiretorio1_row_expanded'Access);
		frmCompararDiretorio.tvDiretorio1.On_Button_Release_Event(on_tvDiretorio1_button_release_event'Access);
		frmCompararDiretorio.cmbAba2.On_Changed(on_cmbAba2_changed'Access);
		frmCompararDiretorio.tvDiretorio2.On_Row_Collapsed(on_tvDiretorio2_row_collapsed'Access);
		frmCompararDiretorio.tvDiretorio2.On_Row_Expanded(on_tvDiretorio2_row_expanded'Access);
		frmCompararDiretorio.tvDiretorio2.On_Button_Release_Event(on_tvDiretorio2_button_release_event'Access);
		frmCompararDiretorio.tabelaCompara.On_Row_Activated(on_tabelaCompara_row_activated'Access);
		frmCompararDiretorio.tabelaCompara.On_Button_Release_Event(on_tabelaCompara_button_release_event'Access);
		
	end Inicializa;

	procedure Mostrar is
		retorno: Gtk_Response_Type;
		pragma Unreferenced(retorno);	
	begin
		Criar(frmCompararDiretorio);
		frmCompararDiretorio.Set_Position(Win_Pos_Center_Always);
		frmCompararDiretorio.Show_All;
	end Mostrar;

	procedure on_btnCompararDiretorios_clicked(source: access Gtk_Button_Record'Class) is
	begin
		null;
	end on_btnCompararDiretorios_clicked;

	procedure btnSalvarLog_clicked_cb(source: access Gtk_Button_Record'Class) is
	begin
		null;
	end btnSalvarLog_clicked_cb;

	procedure on_cmbAba1_changed(source: access Gtk_Combo_Box_Record'Class) is
	begin
		null;
	end on_cmbAba1_changed;

	procedure on_tvDiretorio1_row_collapsed(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path) is
	begin
		null;
	end on_tvDiretorio1_row_collapsed;

	procedure on_tvDiretorio1_row_expanded(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path) is
	begin
		null;
	end on_tvDiretorio1_row_expanded;

	function on_tvDiretorio1_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean is
	begin
		return False;
	end on_tvDiretorio1_button_release_event;

	procedure on_cmbAba2_changed(source: access Gtk_Combo_Box_Record'Class) is
	begin
		null;
	end on_cmbAba2_changed;

	procedure on_tvDiretorio2_row_collapsed(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path) is
	begin
		null;
	end on_tvDiretorio2_row_collapsed;

	procedure on_tvDiretorio2_row_expanded(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path) is
	begin
		null;
	end on_tvDiretorio2_row_expanded;

	function on_tvDiretorio2_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean is
	begin
		return False;
	end on_tvDiretorio2_button_release_event;

	procedure on_tabelaCompara_row_activated(source: access Gtk_Tree_View_Record'Class; path: Gtk_Tree_Path; column: not null access Gtk_Tree_View_Column_Record'Class) is
	begin
		null;
	end on_tabelaCompara_row_activated;

	function on_tabelaCompara_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean is
	begin
		return False;
	end on_tabelaCompara_button_release_event;



end FrmCompararDiretorio;
