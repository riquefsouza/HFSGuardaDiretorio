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
with FrmImportarDiretorio; use FrmImportarDiretorio;
with FrmSobre; use FrmSobre;
with FrmSplash; use FrmSplash;
with MenuPopup; use MenuPopup;
with FrmCadExtensao; use FrmCadExtensao;
with FrmInfoDiretorio; use FrmInfoDiretorio;
with FrmCompararDiretorio; use FrmCompararDiretorio;

package body FrmPrincipal is

	procedure Criar(frmPrincipal: out FrmPrincipal_Access) is
	begin
		frmPrincipal := new frmPrincipal_Record;
		Inicializa(frmPrincipal);
	end Criar;

	procedure Inicializa(frmPrincipal: access FrmPrincipal_Record'Class) is
		pragma Suppress(All_Checks);
		Num: Gint;
		pragma Unreferenced(Num);
		Text_Render: Gtk_Cell_Renderer_Text := Gtk_Cell_Renderer_Text_New;
	begin
		Window.Initialize(frmPrincipal, Window_TopLevel);

		frmPrincipal.barraStatus211 := Gtk_Status_Bar_New;
		frmPrincipal.barraStatus211.Set_Name("barraStatus211");
		frmPrincipal.barraStatus211.Set_Visible(True);
		frmPrincipal.barraStatus211.Set_Can_Focus(False);
		frmPrincipal.barraStatus211.Set_Spacing(2);
	
		frmPrincipal.barraStatus111 := Gtk_Status_Bar_New;
		frmPrincipal.barraStatus111.Set_Name("barraStatus111");
		frmPrincipal.barraStatus111.Set_Size_Request(300, -1);
		frmPrincipal.barraStatus111.Set_Visible(True);
		frmPrincipal.barraStatus111.Set_Can_Focus(False);
		frmPrincipal.barraStatus111.Set_Spacing(2);
	
		frmPrincipal.hbox6 := Gtk_Hbox_New(False, 0);
		frmPrincipal.hbox6.Set_Name("hbox6");
		frmPrincipal.hbox6.Set_Visible(True);
		frmPrincipal.hbox6.Set_Can_Focus(False);
		frmPrincipal.hbox6.Pack_Start(frmPrincipal.barraStatus111, False, True, 0);
		frmPrincipal.hbox6.Pack_Start(frmPrincipal.barraStatus211, True, True, 0);
	
		frmPrincipal.colunaTabelaPesquisaAba := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaPesquisaAba.Set_Resizable(True);
		frmPrincipal.colunaTabelaPesquisaAba.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaPesquisaAba.Set_Title("aba");
		frmPrincipal.colunaTabelaPesquisaAba.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaPesquisaAba.Set_Sort_Column_Id(7);
	
		frmPrincipal.colunaTabelaPesquisaCaminho := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaPesquisaCaminho.Set_Resizable(True);
		frmPrincipal.colunaTabelaPesquisaCaminho.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaPesquisaCaminho.Set_Title("caminho");
		frmPrincipal.colunaTabelaPesquisaCaminho.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaPesquisaCaminho.Set_Sort_Column_Id(6);
	
		frmPrincipal.colunaTabelaPesquisaAtributos := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaPesquisaAtributos.Set_Resizable(True);
		frmPrincipal.colunaTabelaPesquisaAtributos.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaPesquisaAtributos.Set_Title("atributos");
		frmPrincipal.colunaTabelaPesquisaAtributos.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaPesquisaAtributos.Set_Sort_Column_Id(5);
	
		frmPrincipal.colunaTabelaPesquisaModificado := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaPesquisaModificado.Set_Resizable(True);
		frmPrincipal.colunaTabelaPesquisaModificado.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaPesquisaModificado.Set_Title("modificado");
		frmPrincipal.colunaTabelaPesquisaModificado.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaPesquisaModificado.Set_Sort_Column_Id(4);
	
		frmPrincipal.colunaTabelaPesquisaTipo := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaPesquisaTipo.Set_Resizable(True);
		frmPrincipal.colunaTabelaPesquisaTipo.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaPesquisaTipo.Set_Title("tipo");
		frmPrincipal.colunaTabelaPesquisaTipo.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaPesquisaTipo.Set_Sort_Column_Id(3);
	
		frmPrincipal.colunaTabelaPesquisaTamanho := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaPesquisaTamanho.Set_Resizable(True);
		frmPrincipal.colunaTabelaPesquisaTamanho.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaPesquisaTamanho.Set_Title("tamanho");
		frmPrincipal.colunaTabelaPesquisaTamanho.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaPesquisaTamanho.Set_Sort_Column_Id(2);
	
		frmPrincipal.colunaTabelaPesquisaNome := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaPesquisaNome.Set_Resizable(True);
		frmPrincipal.colunaTabelaPesquisaNome.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaPesquisaNome.Set_Title("nome");
		frmPrincipal.colunaTabelaPesquisaNome.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaPesquisaNome.Set_Sort_Column_Id(1);
	
		frmPrincipal.tabelaPesquisa := Gtk_Tree_View_New;
		frmPrincipal.tabelaPesquisa.Set_Name("tabelaPesquisa");
		frmPrincipal.tabelaPesquisa.Set_Visible(True);
		frmPrincipal.tabelaPesquisa.Set_Can_Focus(True);
		frmPrincipal.tabelaPesquisa.Set_Model(Rotinas.modelo_lsTabelaPesquisa);
		Num := frmPrincipal.tabelaPesquisa.Append_Column(frmPrincipal.colunaTabelaPesquisaNome);
		frmPrincipal.colunaTabelaPesquisaNome.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaPesquisaNome.Add_Attribute(Text_Render, "text", 0);
		Num := frmPrincipal.tabelaPesquisa.Append_Column(frmPrincipal.colunaTabelaPesquisaTamanho);
		frmPrincipal.colunaTabelaPesquisaTamanho.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaPesquisaTamanho.Add_Attribute(Text_Render, "text", 1);
		Num := frmPrincipal.tabelaPesquisa.Append_Column(frmPrincipal.colunaTabelaPesquisaTipo);
		frmPrincipal.colunaTabelaPesquisaTipo.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaPesquisaTipo.Add_Attribute(Text_Render, "text", 2);
		Num := frmPrincipal.tabelaPesquisa.Append_Column(frmPrincipal.colunaTabelaPesquisaModificado);
		frmPrincipal.colunaTabelaPesquisaModificado.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaPesquisaModificado.Add_Attribute(Text_Render, "text", 3);
		Num := frmPrincipal.tabelaPesquisa.Append_Column(frmPrincipal.colunaTabelaPesquisaAtributos);
		frmPrincipal.colunaTabelaPesquisaAtributos.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaPesquisaAtributos.Add_Attribute(Text_Render, "text", 4);
		Num := frmPrincipal.tabelaPesquisa.Append_Column(frmPrincipal.colunaTabelaPesquisaCaminho);
		frmPrincipal.colunaTabelaPesquisaCaminho.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaPesquisaCaminho.Add_Attribute(Text_Render, "text", 5);
		Num := frmPrincipal.tabelaPesquisa.Append_Column(frmPrincipal.colunaTabelaPesquisaAba);
		frmPrincipal.colunaTabelaPesquisaAba.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaPesquisaAba.Add_Attribute(Text_Render, "text", 6);
	
		frmPrincipal.scrollPesquisa := Gtk_Scrolled_Window_New;
		frmPrincipal.scrollPesquisa.Set_Name("scrollPesquisa");
		frmPrincipal.scrollPesquisa.Set_Visible(True);
		frmPrincipal.scrollPesquisa.Set_Can_Focus(True);
		frmPrincipal.scrollPesquisa.Set_Policy(Policy_Automatic, Policy_Automatic);
		frmPrincipal.scrollPesquisa.Add(frmPrincipal.tabelaPesquisa);
	
		frmPrincipal.label3 := Gtk_Label_New;
		frmPrincipal.label3.Set_Name("label3");
		frmPrincipal.label3.Set_Visible(True);
		frmPrincipal.label3.Set_Can_Focus(False);
		frmPrincipal.label3.Set_Label("page 3");
	
		frmPrincipal.label2 := Gtk_Label_New;
		frmPrincipal.label2.Set_Name("label2");
		frmPrincipal.label2.Set_Visible(True);
		frmPrincipal.label2.Set_Can_Focus(False);
		frmPrincipal.label2.Set_Label("page 2");
	
		frmPrincipal.labAbaFixa := Gtk_Label_New;
		frmPrincipal.labAbaFixa.Set_Name("labAbaFixa");
		frmPrincipal.labAbaFixa.Set_Visible(True);
		frmPrincipal.labAbaFixa.Set_Can_Focus(False);
		frmPrincipal.labAbaFixa.Set_Label("disco1");
	
		frmPrincipal.colunaTabelaFixaCaminho := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaFixaCaminho.Set_Resizable(True);
		frmPrincipal.colunaTabelaFixaCaminho.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaFixaCaminho.Set_Title("caminho");
		frmPrincipal.colunaTabelaFixaCaminho.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaFixaCaminho.Set_Sort_Column_Id(6);
	
		frmPrincipal.colunaTabelaFixaAtributos := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaFixaAtributos.Set_Resizable(True);
		frmPrincipal.colunaTabelaFixaAtributos.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaFixaAtributos.Set_Title("atributos");
		frmPrincipal.colunaTabelaFixaAtributos.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaFixaAtributos.Set_Sort_Column_Id(5);
	
		frmPrincipal.colunaTabelaFixaModificado := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaFixaModificado.Set_Resizable(True);
		frmPrincipal.colunaTabelaFixaModificado.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaFixaModificado.Set_Title("modificado");
		frmPrincipal.colunaTabelaFixaModificado.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaFixaModificado.Set_Sort_Column_Id(4);
	
		frmPrincipal.colunaTabelaFixaTipo := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaFixaTipo.Set_Resizable(True);
		frmPrincipal.colunaTabelaFixaTipo.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaFixaTipo.Set_Title("tipo");
		frmPrincipal.colunaTabelaFixaTipo.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaFixaTipo.Set_Sort_Column_Id(3);
	
		frmPrincipal.colunaTabelaFixaTamanho := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaFixaTamanho.Set_Resizable(True);
		frmPrincipal.colunaTabelaFixaTamanho.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaFixaTamanho.Set_Title("tamanho");
		frmPrincipal.colunaTabelaFixaTamanho.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaFixaTamanho.Set_Sort_Column_Id(2);
	
		frmPrincipal.colunaTabelaFixaNome := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaTabelaFixaNome.Set_Resizable(True);
		frmPrincipal.colunaTabelaFixaNome.Set_Sizing(Tree_View_Column_Autosize);
		frmPrincipal.colunaTabelaFixaNome.Set_Title("nome");
		frmPrincipal.colunaTabelaFixaNome.Set_Sort_Indicator(True);
		frmPrincipal.colunaTabelaFixaNome.Set_Sort_Column_Id(1);
	
		frmPrincipal.tabelaFixa := Gtk_Tree_View_New;
		frmPrincipal.tabelaFixa.Set_Name("tabelaFixa");
		frmPrincipal.tabelaFixa.Set_Visible(True);
		frmPrincipal.tabelaFixa.Set_Can_Focus(True);
		frmPrincipal.tabelaFixa.Set_Model(Rotinas.modelo_lsTabelaFixa);
		Num := frmPrincipal.tabelaFixa.Append_Column(frmPrincipal.colunaTabelaFixaNome);
		frmPrincipal.colunaTabelaFixaNome.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaFixaNome.Add_Attribute(Text_Render, "text", 0);
		Num := frmPrincipal.tabelaFixa.Append_Column(frmPrincipal.colunaTabelaFixaTamanho);
		frmPrincipal.colunaTabelaFixaTamanho.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaFixaTamanho.Add_Attribute(Text_Render, "text", 1);
		Num := frmPrincipal.tabelaFixa.Append_Column(frmPrincipal.colunaTabelaFixaTipo);
		frmPrincipal.colunaTabelaFixaTipo.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaFixaTipo.Add_Attribute(Text_Render, "text", 2);
		Num := frmPrincipal.tabelaFixa.Append_Column(frmPrincipal.colunaTabelaFixaModificado);
		frmPrincipal.colunaTabelaFixaModificado.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaFixaModificado.Add_Attribute(Text_Render, "text", 3);
		Num := frmPrincipal.tabelaFixa.Append_Column(frmPrincipal.colunaTabelaFixaAtributos);
		frmPrincipal.colunaTabelaFixaAtributos.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaFixaAtributos.Add_Attribute(Text_Render, "text", 4);
		Num := frmPrincipal.tabelaFixa.Append_Column(frmPrincipal.colunaTabelaFixaCaminho);
		frmPrincipal.colunaTabelaFixaCaminho.Pack_Start(Text_Render, True);
		frmPrincipal.colunaTabelaFixaCaminho.Add_Attribute(Text_Render, "text", 5);
	
		frmPrincipal.scrollTabelaFixa := Gtk_Scrolled_Window_New;
		frmPrincipal.scrollTabelaFixa.Set_Name("scrollTabelaFixa");
		frmPrincipal.scrollTabelaFixa.Set_Visible(True);
		frmPrincipal.scrollTabelaFixa.Set_Can_Focus(True);
		frmPrincipal.scrollTabelaFixa.Set_Policy(Policy_Automatic, Policy_Automatic);
		frmPrincipal.scrollTabelaFixa.Set_Shadow_Type(Shadow_Etched_Out);
		frmPrincipal.scrollTabelaFixa.Add(frmPrincipal.tabelaFixa);
	
		frmPrincipal.colunaArvoreFixa := Gtk_Tree_View_Column_New;
		frmPrincipal.colunaArvoreFixa.Set_Title("coluna");
	
		frmPrincipal.arvoreFixa := Gtk_Tree_View_New;
		frmPrincipal.arvoreFixa.Set_Name("arvoreFixa");
		frmPrincipal.arvoreFixa.Set_Visible(True);
		frmPrincipal.arvoreFixa.Set_Can_Focus(True);
		frmPrincipal.arvoreFixa.Set_Model(Rotinas.modelo_tsArvoreFixa);
		frmPrincipal.arvoreFixa.Set_Headers_Visible(False);
		Num := frmPrincipal.arvoreFixa.Append_Column(frmPrincipal.colunaArvoreFixa);
		frmPrincipal.colunaArvoreFixa.Pack_Start(Text_Render, True);
		frmPrincipal.colunaArvoreFixa.Add_Attribute(Text_Render, "text", 0);
	
		frmPrincipal.scrollArvore := Gtk_Scrolled_Window_New;
		frmPrincipal.scrollArvore.Set_Name("scrollArvore");
		frmPrincipal.scrollArvore.Set_Visible(True);
		frmPrincipal.scrollArvore.Set_Can_Focus(True);
		frmPrincipal.scrollArvore.Set_Policy(Policy_Automatic, Policy_Automatic);
		frmPrincipal.scrollArvore.Set_Shadow_Type(Shadow_In);
		frmPrincipal.scrollArvore.Add(frmPrincipal.arvoreFixa);
	
		frmPrincipal.sp := Gtk_Hpaned_New;
		frmPrincipal.sp.Set_Name("sp");
		frmPrincipal.sp.Set_Visible(True);
		frmPrincipal.sp.Set_Can_Focus(True);
		frmPrincipal.sp.Set_Position(250);
		frmPrincipal.sp.Add(frmPrincipal.scrollArvore);
		frmPrincipal.sp.Add(frmPrincipal.scrollTabelaFixa);
	
		frmPrincipal.notebook1 := Gtk_Notebook_New;
		frmPrincipal.notebook1.Set_Name("notebook1");
		frmPrincipal.notebook1.Set_Visible(True);
		frmPrincipal.notebook1.Set_Can_Focus(True);
		frmPrincipal.notebook1.Add(frmPrincipal.sp);
		frmPrincipal.notebook1.Add(frmPrincipal.labAbaFixa);
		frmPrincipal.notebook1.Add(frmPrincipal.label2);
		frmPrincipal.notebook1.Add(frmPrincipal.label3);
	
		frmPrincipal.spPesquisa := Gtk_Vpaned_New;
		frmPrincipal.spPesquisa.Set_Name("spPesquisa");
		frmPrincipal.spPesquisa.Set_Visible(True);
		frmPrincipal.spPesquisa.Set_Can_Focus(True);
		frmPrincipal.spPesquisa.Set_Position(250);
		frmPrincipal.spPesquisa.Add(frmPrincipal.notebook1);
		frmPrincipal.spPesquisa.Add(frmPrincipal.scrollPesquisa);
	
		frmPrincipal.btnPesquisa := Gtk_Button_New_With_Label("pesquisar");
		frmPrincipal.btnPesquisa.Set_Name("btnPesquisa");
		frmPrincipal.btnPesquisa.Set_Label("pesquisar");
		frmPrincipal.btnPesquisa.Set_Visible(True);
		frmPrincipal.btnPesquisa.Set_Can_Focus(False);
		frmPrincipal.btnPesquisa.Set_Receives_Default(False);
		frmPrincipal.btnPesquisa.Set_Use_Underline(True);
	
		frmPrincipal.toolbutton4 := Gtk_Tool_Item_New;
		frmPrincipal.toolbutton4.Set_Name("toolbutton4");
		frmPrincipal.toolbutton4.Set_Visible(True);
		frmPrincipal.toolbutton4.Set_Can_Focus(False);
		frmPrincipal.toolbutton4.Add(frmPrincipal.btnPesquisa);
	
		frmPrincipal.edtPesquisa := Gtk_Entry_New;
		frmPrincipal.edtPesquisa.Set_Name("edtPesquisa");
		frmPrincipal.edtPesquisa.Set_Size_Request(325, -1);
		frmPrincipal.edtPesquisa.Set_Visible(True);
		frmPrincipal.edtPesquisa.Set_Can_Focus(True);
		frmPrincipal.edtPesquisa.Set_Max_Length(10);
		frmPrincipal.edtPesquisa.Set_Icon_Activatable(Gtk_Entry_Icon_Primary, False);
		frmPrincipal.edtPesquisa.Set_Icon_Activatable(Gtk_Entry_Icon_Secondary, False);
		frmPrincipal.edtPesquisa.Set_Icon_Sensitive(Gtk_Entry_Icon_Primary, True);
		frmPrincipal.edtPesquisa.Set_Icon_Sensitive(Gtk_Entry_Icon_Secondary, True);
	
		frmPrincipal.toolbutton3 := Gtk_Tool_Item_New;
		frmPrincipal.toolbutton3.Set_Name("toolbutton3");
		frmPrincipal.toolbutton3.Set_Visible(True);
		frmPrincipal.toolbutton3.Set_Can_Focus(False);
		frmPrincipal.toolbutton3.Add(frmPrincipal.edtPesquisa);
	
		frmPrincipal.pb := Gtk_Progress_Bar_New;
		frmPrincipal.pb.Set_Name("pb");
		frmPrincipal.pb.Set_Size_Request(385, -1);
		frmPrincipal.pb.Set_Visible(True);
		frmPrincipal.pb.Set_Can_Focus(False);
	
		frmPrincipal.toolbutton2 := Gtk_Tool_Item_New;
		frmPrincipal.toolbutton2.Set_Name("toolbutton2");
		frmPrincipal.toolbutton2.Set_Size_Request(222, -1);
		frmPrincipal.toolbutton2.Set_Visible(True);
		frmPrincipal.toolbutton2.Set_Can_Focus(False);
		frmPrincipal.toolbutton2.Add(frmPrincipal.pb);
	
		frmPrincipal.btnImportarDiretorio := Gtk_Button_New_With_Label("importar diretorio");
		frmPrincipal.btnImportarDiretorio.Set_Name("btnImportarDiretorio");
		frmPrincipal.btnImportarDiretorio.Set_Label("importar diretorio");
		frmPrincipal.btnImportarDiretorio.Set_Visible(True);
		frmPrincipal.btnImportarDiretorio.Set_Can_Focus(False);
		frmPrincipal.btnImportarDiretorio.Set_Receives_Default(False);
		frmPrincipal.btnImportarDiretorio.Set_Use_Underline(True);
	
		frmPrincipal.toolbutton1 := Gtk_Tool_Item_New;
		frmPrincipal.toolbutton1.Set_Name("toolbutton1");
		frmPrincipal.toolbutton1.Set_Visible(True);
		frmPrincipal.toolbutton1.Set_Can_Focus(False);
		frmPrincipal.toolbutton1.Add(frmPrincipal.btnImportarDiretorio);
	
		frmPrincipal.toolbar1 := Gtk_Toolbar_New;
		frmPrincipal.toolbar1.Set_Name("toolbar1");
		frmPrincipal.toolbar1.Set_Visible(True);
		frmPrincipal.toolbar1.Set_Can_Focus(False);
		frmPrincipal.toolbar1.Add(frmPrincipal.toolbutton1);
		frmPrincipal.toolbar1.Add(frmPrincipal.toolbutton2);
		frmPrincipal.toolbar1.Add(frmPrincipal.toolbutton3);
		frmPrincipal.toolbar1.Add(frmPrincipal.toolbutton4);
	
		frmPrincipal.menuSobreCatalogador := Gtk_Menu_Item_New;
		frmPrincipal.menuSobreCatalogador.Set_Name("menuSobreCatalogador");
		frmPrincipal.menuSobreCatalogador.Set_Visible(True);
		frmPrincipal.menuSobreCatalogador.Set_Can_Focus(False);
		frmPrincipal.menuSobreCatalogador.Set_Label("sobre o catalogador");
		frmPrincipal.menuSobreCatalogador.Set_Use_Underline(True);
	
		frmPrincipal.submenuSobre := Gtk_Menu_New;
		frmPrincipal.submenuSobre.Set_Name("submenuSobre");
		frmPrincipal.submenuSobre.Set_Visible(True);
		frmPrincipal.submenuSobre.Set_Can_Focus(False);
		frmPrincipal.submenuSobre.Append(frmPrincipal.menuSobreCatalogador);
	
		frmPrincipal.menuSobre := Gtk_Menu_Item_New;
		frmPrincipal.menuSobre.Set_Name("menuSobre");
		frmPrincipal.menuSobre.Set_Visible(True);
		frmPrincipal.menuSobre.Set_Can_Focus(False);
		frmPrincipal.menuSobre.Set_Label("sobre");
		frmPrincipal.menuSobre.Set_Use_Underline(True);
		frmPrincipal.menuSobre.Set_Submenu(frmPrincipal.submenuSobre);
	
		frmPrincipal.menuMostrarOcultarListaItensPesquisados := Gtk_Menu_Item_New;
		frmPrincipal.menuMostrarOcultarListaItensPesquisados.Set_Name("menuMostrarOcultarListaItensPesquisados");
		frmPrincipal.menuMostrarOcultarListaItensPesquisados.Set_Visible(True);
		frmPrincipal.menuMostrarOcultarListaItensPesquisados.Set_Can_Focus(False);
		frmPrincipal.menuMostrarOcultarListaItensPesquisados.Set_Label("mostrar/ocultar lista de itens pesquisados");
		frmPrincipal.menuMostrarOcultarListaItensPesquisados.Set_Use_Underline(True);
	
		frmPrincipal.menuMostrarOcultarArvoreDirAbaAtiva := Gtk_Menu_Item_New;
		frmPrincipal.menuMostrarOcultarArvoreDirAbaAtiva.Set_Name("menuMostrarOcultarArvoreDirAbaAtiva");
		frmPrincipal.menuMostrarOcultarArvoreDirAbaAtiva.Set_Visible(True);
		frmPrincipal.menuMostrarOcultarArvoreDirAbaAtiva.Set_Can_Focus(False);
		frmPrincipal.menuMostrarOcultarArvoreDirAbaAtiva.Set_Label("mostrar/ocultar árvore de diretórios da aba ativa");
		frmPrincipal.menuMostrarOcultarArvoreDirAbaAtiva.Set_Use_Underline(True);
	
		frmPrincipal.submenuVisao := Gtk_Menu_New;
		frmPrincipal.submenuVisao.Set_Name("submenuVisao");
		frmPrincipal.submenuVisao.Set_Visible(True);
		frmPrincipal.submenuVisao.Set_Can_Focus(False);
		frmPrincipal.submenuVisao.Append(frmPrincipal.menuMostrarOcultarArvoreDirAbaAtiva);
		frmPrincipal.submenuVisao.Append(frmPrincipal.menuMostrarOcultarListaItensPesquisados);
	
		frmPrincipal.menuVisao := Gtk_Menu_Item_New;
		frmPrincipal.menuVisao.Set_Name("menuVisao");
		frmPrincipal.menuVisao.Set_Visible(True);
		frmPrincipal.menuVisao.Set_Can_Focus(False);
		frmPrincipal.menuVisao.Set_Label("visão");
		frmPrincipal.menuVisao.Set_Submenu(frmPrincipal.submenuVisao);
	
		frmPrincipal.menuGravarLogImportacao := Gtk_Check_Menu_Item_New_With_Label("gravar log da importação");
		frmPrincipal.menuGravarLogImportacao.Set_Name("menuGravarLogImportacao");
		frmPrincipal.menuGravarLogImportacao.Set_Visible(True);
		frmPrincipal.menuGravarLogImportacao.Set_Can_Focus(False);
		frmPrincipal.menuGravarLogImportacao.Set_Label("gravar log da importação");
		frmPrincipal.menuGravarLogImportacao.Set_Use_Underline(True);
	
		frmPrincipal.menuImportarDiretoriosViaXML := Gtk_Menu_Item_New;
		frmPrincipal.menuImportarDiretoriosViaXML.Set_Name("menuImportarDiretoriosViaXML");
		frmPrincipal.menuImportarDiretoriosViaXML.Set_Visible(True);
		frmPrincipal.menuImportarDiretoriosViaXML.Set_Can_Focus(False);
		frmPrincipal.menuImportarDiretoriosViaXML.Set_Label("importar diretórios via xml");
		frmPrincipal.menuImportarDiretoriosViaXML.Set_Use_Underline(True);
	
		frmPrincipal.menuSQL := Gtk_Menu_Item_New;
		frmPrincipal.menuSQL.Set_Name("menuSQL");
		frmPrincipal.menuSQL.Set_Visible(True);
		frmPrincipal.menuSQL.Set_Can_Focus(False);
		frmPrincipal.menuSQL.Set_Label("sql");
		frmPrincipal.menuSQL.Set_Use_Underline(True);
	
		frmPrincipal.menuXML := Gtk_Menu_Item_New;
		frmPrincipal.menuXML.Set_Name("menuXML");
		frmPrincipal.menuXML.Set_Visible(True);
		frmPrincipal.menuXML.Set_Can_Focus(False);
		frmPrincipal.menuXML.Set_Label("xml");
		frmPrincipal.menuXML.Set_Use_Underline(True);
	
		frmPrincipal.menuHTML := Gtk_Menu_Item_New;
		frmPrincipal.menuHTML.Set_Name("menuHTML");
		frmPrincipal.menuHTML.Set_Visible(True);
		frmPrincipal.menuHTML.Set_Can_Focus(False);
		frmPrincipal.menuHTML.Set_Label("html");
		frmPrincipal.menuHTML.Set_Use_Underline(True);
	
		frmPrincipal.menuCSV := Gtk_Menu_Item_New;
		frmPrincipal.menuCSV.Set_Name("menuCSV");
		frmPrincipal.menuCSV.Set_Visible(True);
		frmPrincipal.menuCSV.Set_Can_Focus(False);
		frmPrincipal.menuCSV.Set_Label("csv");
		frmPrincipal.menuCSV.Set_Use_Underline(True);
	
		frmPrincipal.menuTXT := Gtk_Menu_Item_New;
		frmPrincipal.menuTXT.Set_Name("menuTXT");
		frmPrincipal.menuTXT.Set_Visible(True);
		frmPrincipal.menuTXT.Set_Can_Focus(False);
		frmPrincipal.menuTXT.Set_Label("txt");
		frmPrincipal.menuTXT.Set_Use_Underline(True);
	
		frmPrincipal.menu2 := Gtk_Menu_New;
		frmPrincipal.menu2.Set_Name("menu2");
		frmPrincipal.menu2.Set_Visible(True);
		frmPrincipal.menu2.Set_Can_Focus(False);
		frmPrincipal.menu2.Append(frmPrincipal.menuTXT);
		frmPrincipal.menu2.Append(frmPrincipal.menuCSV);
		frmPrincipal.menu2.Append(frmPrincipal.menuHTML);
		frmPrincipal.menu2.Append(frmPrincipal.menuXML);
		frmPrincipal.menu2.Append(frmPrincipal.menuSQL);
	
		frmPrincipal.menuExportarDiretoriosAbaAtiva := Gtk_Menu_Item_New;
		frmPrincipal.menuExportarDiretoriosAbaAtiva.Set_Name("menuExportarDiretoriosAbaAtiva");
		frmPrincipal.menuExportarDiretoriosAbaAtiva.Set_Visible(True);
		frmPrincipal.menuExportarDiretoriosAbaAtiva.Set_Can_Focus(False);
		frmPrincipal.menuExportarDiretoriosAbaAtiva.Set_Label("exportar diretórios da aba ativa");
		frmPrincipal.menuExportarDiretoriosAbaAtiva.Set_Use_Underline(True);
		frmPrincipal.menuExportarDiretoriosAbaAtiva.Set_Submenu(frmPrincipal.menu2);
	
		frmPrincipal.menuColapsarDiretorios := Gtk_Menu_Item_New;
		frmPrincipal.menuColapsarDiretorios.Set_Name("menuColapsarDiretorios");
		frmPrincipal.menuColapsarDiretorios.Set_Visible(True);
		frmPrincipal.menuColapsarDiretorios.Set_Can_Focus(False);
		frmPrincipal.menuColapsarDiretorios.Set_Label("colapsar diretórios");
		frmPrincipal.menuColapsarDiretorios.Set_Use_Underline(True);
	
		frmPrincipal.menuExpandirDiretorios := Gtk_Menu_Item_New;
		frmPrincipal.menuExpandirDiretorios.Set_Name("menuExpandirDiretorios");
		frmPrincipal.menuExpandirDiretorios.Set_Visible(True);
		frmPrincipal.menuExpandirDiretorios.Set_Can_Focus(False);
		frmPrincipal.menuExpandirDiretorios.Set_Label("expandir diretórios");
		frmPrincipal.menuExpandirDiretorios.Set_Use_Underline(True);
	
		frmPrincipal.menuseparador1 := Gtk_Separator_Menu_Item_New;
		frmPrincipal.menuseparador1.Set_Name("menuseparador1");
		frmPrincipal.menuseparador1.Set_Visible(True);
		frmPrincipal.menuseparador1.Set_Can_Focus(False);
	
		frmPrincipal.menuCadastrarExtensaoArquivo := Gtk_Menu_Item_New;
		frmPrincipal.menuCadastrarExtensaoArquivo.Set_Name("menuCadastrarExtensaoArquivo");
		frmPrincipal.menuCadastrarExtensaoArquivo.Set_Visible(True);
		frmPrincipal.menuCadastrarExtensaoArquivo.Set_Can_Focus(False);
		frmPrincipal.menuCadastrarExtensaoArquivo.Set_Label("cadastrar extensão de arquivo");
		frmPrincipal.menuCadastrarExtensaoArquivo.Set_Use_Underline(True);
	
		frmPrincipal.menuCompararDiretorios := Gtk_Menu_Item_New;
		frmPrincipal.menuCompararDiretorios.Set_Name("menuCompararDiretorios");
		frmPrincipal.menuCompararDiretorios.Set_Visible(True);
		frmPrincipal.menuCompararDiretorios.Set_Can_Focus(False);
		frmPrincipal.menuCompararDiretorios.Set_Label("comparar diretórios");
		frmPrincipal.menuCompararDiretorios.Set_Use_Underline(True);
	
		frmPrincipal.menuImportarSubDiretorios := Gtk_Menu_Item_New;
		frmPrincipal.menuImportarSubDiretorios.Set_Name("menuImportarSubDiretorios");
		frmPrincipal.menuImportarSubDiretorios.Set_Visible(True);
		frmPrincipal.menuImportarSubDiretorios.Set_Can_Focus(False);
		frmPrincipal.menuImportarSubDiretorios.Set_Label("importar subdiretórios");
		frmPrincipal.menuImportarSubDiretorios.Set_Use_Underline(True);
	
		frmPrincipal.menuImportarDiretorio := Gtk_Menu_Item_New;
		frmPrincipal.menuImportarDiretorio.Set_Name("menuImportarDiretorio");
		frmPrincipal.menuImportarDiretorio.Set_Visible(True);
		frmPrincipal.menuImportarDiretorio.Set_Can_Focus(False);
		frmPrincipal.menuImportarDiretorio.Set_Label("importar diretório");
		frmPrincipal.menuImportarDiretorio.Set_Use_Underline(True);
	
		frmPrincipal.submenuDiretorio := Gtk_Menu_New;
		frmPrincipal.submenuDiretorio.Set_Name("submenuDiretorio");
		frmPrincipal.submenuDiretorio.Set_Visible(True);
		frmPrincipal.submenuDiretorio.Set_Can_Focus(False);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuImportarDiretorio);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuImportarSubDiretorios);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuCompararDiretorios);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuCadastrarExtensaoArquivo);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuseparador1);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuExpandirDiretorios);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuColapsarDiretorios);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuExportarDiretoriosAbaAtiva);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuImportarDiretoriosViaXML);
		frmPrincipal.submenuDiretorio.Append(frmPrincipal.menuGravarLogImportacao);
	
		frmPrincipal.menuDiretorio := Gtk_Menu_Item_New;
		frmPrincipal.menuDiretorio.Set_Name("menuDiretorio");
		frmPrincipal.menuDiretorio.Set_Visible(True);
		frmPrincipal.menuDiretorio.Set_Can_Focus(False);
		frmPrincipal.menuDiretorio.Set_Label("diretório");
		frmPrincipal.menuDiretorio.Set_Submenu(frmPrincipal.submenuDiretorio);
	
		frmPrincipal.menuExcluirAbaAtiva := Gtk_Menu_Item_New;
		frmPrincipal.menuExcluirAbaAtiva.Set_Name("menuExcluirAbaAtiva");
		frmPrincipal.menuExcluirAbaAtiva.Set_Visible(True);
		frmPrincipal.menuExcluirAbaAtiva.Set_Can_Focus(False);
		frmPrincipal.menuExcluirAbaAtiva.Set_Label("excluir aba ativa");
		frmPrincipal.menuExcluirAbaAtiva.Set_Use_Underline(True);
	
		frmPrincipal.menuAlterarNomeAbaAtiva := Gtk_Menu_Item_New;
		frmPrincipal.menuAlterarNomeAbaAtiva.Set_Name("menuAlterarNomeAbaAtiva");
		frmPrincipal.menuAlterarNomeAbaAtiva.Set_Visible(True);
		frmPrincipal.menuAlterarNomeAbaAtiva.Set_Can_Focus(False);
		frmPrincipal.menuAlterarNomeAbaAtiva.Set_Label("alterar nome da aba ativa");
		frmPrincipal.menuAlterarNomeAbaAtiva.Set_Use_Underline(True);
	
		frmPrincipal.menuIncluirNovaAba := Gtk_Menu_Item_New;
		frmPrincipal.menuIncluirNovaAba.Set_Name("menuIncluirNovaAba");
		frmPrincipal.menuIncluirNovaAba.Set_Visible(True);
		frmPrincipal.menuIncluirNovaAba.Set_Can_Focus(False);
		frmPrincipal.menuIncluirNovaAba.Set_Label("incluir nova aba");
		frmPrincipal.menuIncluirNovaAba.Set_Use_Underline(True);
	
		frmPrincipal.submenuAba := Gtk_Menu_New;
		frmPrincipal.submenuAba.Set_Name("submenuAba");
		frmPrincipal.submenuAba.Set_Visible(True);
		frmPrincipal.submenuAba.Set_Can_Focus(False);
		frmPrincipal.submenuAba.Append(frmPrincipal.menuIncluirNovaAba);
		frmPrincipal.submenuAba.Append(frmPrincipal.menuAlterarNomeAbaAtiva);
		frmPrincipal.submenuAba.Append(frmPrincipal.menuExcluirAbaAtiva);
	
		frmPrincipal.menuAba := Gtk_Menu_Item_New;
		frmPrincipal.menuAba.Set_Name("menuAba");
		frmPrincipal.menuAba.Set_Visible(True);
		frmPrincipal.menuAba.Set_Can_Focus(False);
		frmPrincipal.menuAba.Set_Label("aba");
		frmPrincipal.menuAba.Set_Submenu(frmPrincipal.submenuAba);
	
		frmPrincipal.barraMenu1 := Gtk_Menu_Bar_New;
		frmPrincipal.barraMenu1.Set_Name("barraMenu1");
		frmPrincipal.barraMenu1.Set_Visible(True);
		frmPrincipal.barraMenu1.Set_Can_Focus(False);
		frmPrincipal.barraMenu1.Append(frmPrincipal.menuAba);
		frmPrincipal.barraMenu1.Append(frmPrincipal.menuDiretorio);
		frmPrincipal.barraMenu1.Append(frmPrincipal.menuVisao);
		frmPrincipal.barraMenu1.Append(frmPrincipal.menuSobre);
	
		frmPrincipal.vbox1 := Gtk_Vbox_New(False, 0);
		frmPrincipal.vbox1.Set_Name("vbox1");
		frmPrincipal.vbox1.Set_Visible(True);
		frmPrincipal.vbox1.Set_Can_Focus(False);
		frmPrincipal.vbox1.Pack_Start(frmPrincipal.barraMenu1, False, True, 0);
		frmPrincipal.vbox1.Pack_Start(frmPrincipal.toolbar1, False, True, 0);
		frmPrincipal.vbox1.Pack_Start(frmPrincipal.spPesquisa, True, True, 0);
		frmPrincipal.vbox1.Pack_Start(frmPrincipal.hbox6, False, True, 0);
	
		frmPrincipal.Set_Name("frmPrincipal");
		frmPrincipal.Set_Size_Request(900, 500);
		frmPrincipal.Set_Visible(True);
		frmPrincipal.Set_Can_Focus(False);
		frmPrincipal.Set_Title("hfsguardadiretorio 2.0 - catalogador de diretórios");
		frmPrincipal.Set_Position(Win_Pos_Center_Always);
		frmPrincipal.Set_Default_Size(950, 718);
		frmPrincipal.Add(frmPrincipal.vbox1);
	

		frmPrincipal.menuIncluirNovaAba.On_Activate(on_menuIncluirNovaAba_activate'Access);
		frmPrincipal.menuAlterarNomeAbaAtiva.On_Activate(on_menuAlterarNomeAbaAtiva_activate'Access);
		frmPrincipal.menuExcluirAbaAtiva.On_Activate(on_menuExcluirAbaAtiva_activate'Access);
		frmPrincipal.menuImportarDiretorio.On_Activate(on_menuImportarDiretorio_activate'Access);
		frmPrincipal.menuImportarSubDiretorios.On_Activate(on_menuImportarSubDiretorios_activate'Access);
		frmPrincipal.menuCompararDiretorios.On_Activate(on_menuCompararDiretorios_activate'Access);
		frmPrincipal.menuCadastrarExtensaoArquivo.On_Activate(on_menuCadastrarExtensaoArquivo_activate'Access);
		frmPrincipal.menuExpandirDiretorios.On_Activate(on_menuExpandirDiretorios_activate'Access);
		frmPrincipal.menuColapsarDiretorios.On_Activate(on_menuColapsarDiretorios_activate'Access);
		frmPrincipal.menuExportarDiretoriosAbaAtiva.On_Activate(on_menuExportarDiretoriosAbaAtiva_activate'Access);
		frmPrincipal.menuTXT.On_Activate(on_menuTXT_activate'Access);
		frmPrincipal.menuCSV.On_Activate(on_menuCSV_activate'Access);
		frmPrincipal.menuHTML.On_Activate(on_menuHTML_activate'Access);
		frmPrincipal.menuXML.On_Activate(on_menuXML_activate'Access);
		frmPrincipal.menuSQL.On_Activate(on_menuSQL_activate'Access);
		frmPrincipal.menuImportarDiretoriosViaXML.On_Activate(on_menuImportarDiretoriosViaXML_activate'Access);
		frmPrincipal.menuMostrarOcultarArvoreDirAbaAtiva.On_Activate(on_menuMostrarOcultarArvoreDirAbaAtiva_activate'Access);
		frmPrincipal.menuMostrarOcultarListaItensPesquisados.On_Activate(on_menuMostrarOcultarListaItensPesquisados_activate'Access);
		frmPrincipal.menuSobreCatalogador.On_Activate(on_menuSobreCatalogador_activate'Access);
		frmPrincipal.btnImportarDiretorio.On_Clicked(on_btnImportarDiretorio_clicked'Access);
		frmPrincipal.btnPesquisa.On_Clicked(on_btnPesquisa_clicked'Access);
		Notebook_Callback.Connect(frmPrincipal.notebook1, "switch_page", Notebook_Callback.To_Marshaller(on_notebook1_switch_page'Access), False); 
		frmPrincipal.arvoreFixa.On_Row_Collapsed(on_arvoreFixa_row_collapsed'Access);
		frmPrincipal.arvoreFixa.On_Button_Release_Event(on_arvoreFixa_button_release_event'Access);
		frmPrincipal.arvoreFixa.On_Row_Expanded(on_arvoreFixa_row_expanded'Access);
		frmPrincipal.tabelaFixa.On_Button_Release_Event(on_tabelaFixa_button_release_event'Access);
		frmPrincipal.tabelaFixa.On_Row_Activated(on_tabelaFixa_row_activated'Access);
		frmPrincipal.tabelaPesquisa.On_Button_Release_Event(on_tabelaPesquisa_button_release_event'Access);
		frmPrincipal.On_Delete_Event(on_FrmPrincipal_delete_event'Access);
		
	end Inicializa;

   procedure Mostrar is
      retorno: Gtk_Response_Type;
      pragma Unreferenced(retorno);
	begin
		Criar(frmPrincipal);
		frmPrincipal.Show_All;
	end Mostrar;

	procedure on_menuIncluirNovaAba_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuIncluirNovaAba_activate;

	procedure on_menuAlterarNomeAbaAtiva_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuAlterarNomeAbaAtiva_activate;

	procedure on_menuExcluirAbaAtiva_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExcluirAbaAtiva_activate;

	procedure on_menuImportarDiretorio_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuImportarDiretorio_activate;

	procedure on_menuImportarSubDiretorios_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		FrmSplash.Mostrar;
	end on_menuImportarSubDiretorios_activate;

	procedure on_menuCompararDiretorios_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		FrmCompararDiretorio.Mostrar;
	end on_menuCompararDiretorios_activate;

	procedure on_menuCadastrarExtensaoArquivo_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		FrmCadExtensao.Mostrar;
	end on_menuCadastrarExtensaoArquivo_activate;

	procedure on_menuExpandirDiretorios_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExpandirDiretorios_activate;

	procedure on_menuColapsarDiretorios_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuColapsarDiretorios_activate;

	procedure on_menuExportarDiretoriosAbaAtiva_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuExportarDiretoriosAbaAtiva_activate;

	procedure on_menuTXT_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuTXT_activate;

	procedure on_menuCSV_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuCSV_activate;

	procedure on_menuHTML_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuHTML_activate;

	procedure on_menuXML_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuXML_activate;

	procedure on_menuSQL_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuSQL_activate;

	procedure on_menuImportarDiretoriosViaXML_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuImportarDiretoriosViaXML_activate;

	procedure on_menuMostrarOcultarArvoreDirAbaAtiva_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuMostrarOcultarArvoreDirAbaAtiva_activate;

	procedure on_menuMostrarOcultarListaItensPesquisados_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		null;
	end on_menuMostrarOcultarListaItensPesquisados_activate;

	procedure on_menuSobreCatalogador_activate(source: access Gtk_Menu_Item_Record'Class) is
	begin
		FrmSobre.Mostrar;
	end on_menuSobreCatalogador_activate;

	procedure on_btnImportarDiretorio_clicked(source: access Gtk_Button_Record'Class) is
	begin
		FrmImportarDiretorio.Mostrar;
	end on_btnImportarDiretorio_clicked;

	procedure on_btnPesquisa_clicked(source: access Gtk_Button_Record'Class) is
	begin
		FrmInfoDiretorio.Mostrar;
	end on_btnPesquisa_clicked;

	procedure on_notebook1_switch_page(source: access Gtk_Notebook_Record'Class; pageNum: Guint) is
	begin
		null;
	end on_notebook1_switch_page;

	procedure on_arvoreFixa_row_collapsed(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path) is
	begin
		null;
	end on_arvoreFixa_row_collapsed;

	function on_arvoreFixa_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean is
	begin
		return False;
	end on_arvoreFixa_button_release_event;

	procedure on_arvoreFixa_row_expanded(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path) is
	begin
		null;
	end on_arvoreFixa_row_expanded;

	function on_tabelaFixa_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean is
	begin
		return False;
	end on_tabelaFixa_button_release_event;

	procedure on_tabelaFixa_row_activated(source: access Gtk_Tree_View_Record'Class; path: Gtk_Tree_Path; column: not null access Gtk_Tree_View_Column_Record'Class) is
	begin
		null;
	end on_tabelaFixa_row_activated;

	function on_tabelaPesquisa_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean is
	begin
		return False;
	end on_tabelaPesquisa_button_release_event;

	function on_FrmPrincipal_delete_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event) return Boolean is
	begin
		Gtk.Main.Main_Quit;
		return False;
	end on_FrmPrincipal_delete_event;



end FrmPrincipal;
