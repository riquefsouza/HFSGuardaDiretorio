with Glib; use Glib;
with Glib.Object; use Glib.Object;
with Glib.Values; use Glib.Values;
with Gtkada.Intl; use Gtkada.Intl;
with Gtk.Enums; use Gtk.Enums;

package body Rotinas is

   procedure Destroy_Window(Win : access Gtk.Window.Gtk_Window_Record'Class;
                            Ptr : Gtk_Window_Access)
   is
      pragma Unreferenced (Win);
   begin
      Ptr.all := null;
   end Destroy_Window;

   procedure Destroy_Dialog(Win : access Gtk.Dialog.Gtk_Dialog_Record'Class;
                            Ptr : Gtk_Dialog_Access)
   is
      pragma Unreferenced (Win);
   begin
      Ptr.all := null;
   end Destroy_Dialog;
   
   procedure MsgDlg(sMensagem: String; tipo: Gtk_Message_Type)
   is
      pragma Suppress(All_Checks);      
      dialog: Gtk_Message_Dialog;
      retorno: Gtk_Response_Type;
   begin
		dialog := Gtk_Message_Dialog_New(Parent   => null,
									   Flags    => Destroy_With_Parent,
									   The_Type => tipo,
									   Buttons  => Buttons_Ok,
									   Message  =>  "%s", 
									   Arg5     => sMensagem'Address);
   	    dialog.Set_Position(Win_Pos_Center);
   	    retorno := dialog.Run;
		dialog.Destroy;
   end MsgDlg;

		function modelo_lsTabelaCompara return Gtk_Tree_Model
	is
		modelolsTabelaCompara: Gtk_Tree_Model;
		lsTabelaCompara: Gtk_Tree_Store;
		iter: Gtk_Tree_Iter := Null_Iter;
		parentIter: Gtk_Tree_Iter := Null_Iter;
	begin
		Gtk_New(lsTabelaCompara, (GType_String, GType_String, GType_String, GType_String, GType_String, GType_String));
		modelolsTabelaCompara := +lsTabelaCompara;
	
		lsTabelaCompara.Append(iter, parentIter);
		lsTabelaCompara.Set(iter, 0, "Nome");
		lsTabelaCompara.Set(iter, 1, "tamanho");
		lsTabelaCompara.Set(iter, 2, "tipo");
		lsTabelaCompara.Set(iter, 3, "Modificado");
		lsTabelaCompara.Set(iter, 4, "Atributos");
		lsTabelaCompara.Set(iter, 5, "Caminho");

		lsTabelaCompara.Append(iter, parentIter);
		lsTabelaCompara.Set(iter, 0, "Nome2");
		lsTabelaCompara.Set(iter, 1, "tamanho2");
		lsTabelaCompara.Set(iter, 2, "tipo2");
		lsTabelaCompara.Set(iter, 3, "Modificado2");
		lsTabelaCompara.Set(iter, 4, "Atributos2");
		lsTabelaCompara.Set(iter, 5, "Caminho2");

		
		return modelolsTabelaCompara;
	end modelo_lsTabelaCompara;
	
	function modelo_lsTabelaExtensao return Gtk_Tree_Model
	is
		modelolsTabelaExtensao: Gtk_Tree_Model;
		lsTabelaExtensao: Gtk_Tree_Store;
		iter: Gtk_Tree_Iter := Null_Iter;
		parentIter: Gtk_Tree_Iter := Null_Iter;
	begin
		Gtk_New(lsTabelaExtensao, (GType_String, GType_String));
		modelolsTabelaExtensao := +lsTabelaExtensao;
	
		lsTabelaExtensao.Append(iter, parentIter);
		lsTabelaExtensao.Set(iter, 0, "Extensao1");
		lsTabelaExtensao.Set(iter, 1, "Icone1");

		lsTabelaExtensao.Append(iter, parentIter);
		lsTabelaExtensao.Set(iter, 0, "Extensao2");
		lsTabelaExtensao.Set(iter, 1, "Icone2");

		
		return modelolsTabelaExtensao;
	end modelo_lsTabelaExtensao;
	
	function modelo_lsTabelaFixa return Gtk_Tree_Model
	is
		modelolsTabelaFixa: Gtk_Tree_Model;
		lsTabelaFixa: Gtk_Tree_Store;
		iter: Gtk_Tree_Iter := Null_Iter;
		parentIter: Gtk_Tree_Iter := Null_Iter;
	begin
		Gtk_New(lsTabelaFixa, (GType_String, GType_String, GType_String, GType_String, GType_String, GType_String));
		modelolsTabelaFixa := +lsTabelaFixa;
	
		lsTabelaFixa.Append(iter, parentIter);
		lsTabelaFixa.Set(iter, 0, "Nome");
		lsTabelaFixa.Set(iter, 1, "tamanho");
		lsTabelaFixa.Set(iter, 2, "tipo");
		lsTabelaFixa.Set(iter, 3, "Modificado");
		lsTabelaFixa.Set(iter, 4, "Atributos");
		lsTabelaFixa.Set(iter, 5, "Caminho");

		lsTabelaFixa.Append(iter, parentIter);
		lsTabelaFixa.Set(iter, 0, "Nome2");
		lsTabelaFixa.Set(iter, 1, "tamanho2");
		lsTabelaFixa.Set(iter, 2, "tipo2");
		lsTabelaFixa.Set(iter, 3, "Modificado2");
		lsTabelaFixa.Set(iter, 4, "Atributos2");
		lsTabelaFixa.Set(iter, 5, "Caminho2");

		
		return modelolsTabelaFixa;
	end modelo_lsTabelaFixa;
	
	function modelo_lsTabelaInfo return Gtk_Tree_Model
	is
		modelolsTabelaInfo: Gtk_Tree_Model;
		lsTabelaInfo: Gtk_Tree_Store;
		iter: Gtk_Tree_Iter := Null_Iter;
		parentIter: Gtk_Tree_Iter := Null_Iter;
	begin
		Gtk_New(lsTabelaInfo, (GType_String, GType_String));
		modelolsTabelaInfo := +lsTabelaInfo;
	
		lsTabelaInfo.Append(iter, parentIter);
		lsTabelaInfo.Set(iter, 0, "Aba:");
		lsTabelaInfo.Set(iter, 1, "Descricao1");

		lsTabelaInfo.Append(iter, parentIter);
		lsTabelaInfo.Set(iter, 0, "Nome:");
		lsTabelaInfo.Set(iter, 1, "Descricao2");

		lsTabelaInfo.Append(iter, parentIter);
		lsTabelaInfo.Set(iter, 0, "Tamanho:");
		lsTabelaInfo.Set(iter, 1, "Descricao3");

		lsTabelaInfo.Append(iter, parentIter);
		lsTabelaInfo.Set(iter, 0, "Tipo:");
		lsTabelaInfo.Set(iter, 1, "Descricao4");

		lsTabelaInfo.Append(iter, parentIter);
		lsTabelaInfo.Set(iter, 0, "Modificado:");
		lsTabelaInfo.Set(iter, 1, "Descricao5");

		lsTabelaInfo.Append(iter, parentIter);
		lsTabelaInfo.Set(iter, 0, "Atributos:");
		lsTabelaInfo.Set(iter, 1, "Descricao6");

		lsTabelaInfo.Append(iter, parentIter);
		lsTabelaInfo.Set(iter, 0, "Caminho:");
		lsTabelaInfo.Set(iter, 1, "Descricao7");

		
		return modelolsTabelaInfo;
	end modelo_lsTabelaInfo;
	
	function modelo_lsTabelaPesquisa return Gtk_Tree_Model
	is
		modelolsTabelaPesquisa: Gtk_Tree_Model;
		lsTabelaPesquisa: Gtk_Tree_Store;
		iter: Gtk_Tree_Iter := Null_Iter;
		parentIter: Gtk_Tree_Iter := Null_Iter;
	begin
		Gtk_New(lsTabelaPesquisa, (GType_String, GType_String, GType_String, GType_String, GType_String, GType_String, GType_String));
		modelolsTabelaPesquisa := +lsTabelaPesquisa;
	
		lsTabelaPesquisa.Append(iter, parentIter);
		lsTabelaPesquisa.Set(iter, 0, "Nome");
		lsTabelaPesquisa.Set(iter, 1, "tamanho");
		lsTabelaPesquisa.Set(iter, 2, "tipo");
		lsTabelaPesquisa.Set(iter, 3, "Modificado");
		lsTabelaPesquisa.Set(iter, 4, "Atributos");
		lsTabelaPesquisa.Set(iter, 5, "Caminho");
		lsTabelaPesquisa.Set(iter, 6, "Aba");

		lsTabelaPesquisa.Append(iter, parentIter);
		lsTabelaPesquisa.Set(iter, 0, "Nome2");
		lsTabelaPesquisa.Set(iter, 1, "tamanho2");
		lsTabelaPesquisa.Set(iter, 2, "tipo2");
		lsTabelaPesquisa.Set(iter, 3, "Modificado2");
		lsTabelaPesquisa.Set(iter, 4, "Atributos2");
		lsTabelaPesquisa.Set(iter, 5, "Caminho2");
		lsTabelaPesquisa.Set(iter, 6, "Aba2");

		
		return modelolsTabelaPesquisa;
	end modelo_lsTabelaPesquisa;
	
	function modelo_tsArvoreDiretorio1 return Gtk_Tree_Model
	is
		modelotsArvoreDiretorio1: Gtk_Tree_Model;
		tsArvoreDiretorio1: Gtk_Tree_Store;
		iter: Gtk_Tree_Iter := Null_Iter;
		parentIter: Gtk_Tree_Iter := Null_Iter;
	begin
		Gtk_New(tsArvoreDiretorio1, (GType_String, GType_String));
		modelotsArvoreDiretorio1 := +tsArvoreDiretorio1;
	
				
		return modelotsArvoreDiretorio1;
	end modelo_tsArvoreDiretorio1;
	
	function modelo_tsArvoreDiretorio2 return Gtk_Tree_Model
	is
		modelotsArvoreDiretorio2: Gtk_Tree_Model;
		tsArvoreDiretorio2: Gtk_Tree_Store;
		iter: Gtk_Tree_Iter := Null_Iter;
		parentIter: Gtk_Tree_Iter := Null_Iter;
	begin
		Gtk_New(tsArvoreDiretorio2, (GType_String, GType_String));
		modelotsArvoreDiretorio2 := +tsArvoreDiretorio2;
	
				
		return modelotsArvoreDiretorio2;
	end modelo_tsArvoreDiretorio2;
	
	function modelo_tsArvoreFixa return Gtk_Tree_Model
	is
		modelotsArvoreFixa: Gtk_Tree_Model;
		tsArvoreFixa: Gtk_Tree_Store;
		iter: Gtk_Tree_Iter := Null_Iter;
		parentIter: Gtk_Tree_Iter := Null_Iter;
	begin
		Gtk_New(tsArvoreFixa, (GType_String, GType_String));
		modelotsArvoreFixa := +tsArvoreFixa;
	
				
		return modelotsArvoreFixa;
	end modelo_tsArvoreFixa;
	

end Rotinas;
