#include "MenuPopup.h"
#include "hfsguardadir/comum/Rotinas.h"
// ---------------------------------------------------------------------------
GtkWidget *MenuPopup_Criar()
{
	MenuPopup.menuPopup = gtk_menu_new();

	MenuPopup.menuExcluirAbaAtiva2 = gtk_menu_item_new();
	gtk_widget_set_name(GTK_WIDGET(MenuPopup.menuExcluirAbaAtiva2), "menuExcluirAbaAtiva2");
	gtk_widget_set_visible(MenuPopup.menuExcluirAbaAtiva2, TRUE);
	gtk_widget_set_can_focus(MenuPopup.menuExcluirAbaAtiva2, FALSE);
	gtk_menu_item_set_label(GTK_MENU_ITEM(MenuPopup.menuExcluirAbaAtiva2), "Excluir aba ativa");
	gtk_menu_item_set_use_underline(GTK_MENU_ITEM(MenuPopup.menuExcluirAbaAtiva2), TRUE);
	
	MenuPopup.menuAlterarNomeAbaAtiva2 = gtk_menu_item_new();
	gtk_widget_set_name(GTK_WIDGET(MenuPopup.menuAlterarNomeAbaAtiva2), "menuAlterarNomeAbaAtiva2");
	gtk_widget_set_visible(MenuPopup.menuAlterarNomeAbaAtiva2, TRUE);
	gtk_widget_set_can_focus(MenuPopup.menuAlterarNomeAbaAtiva2, FALSE);
	gtk_menu_item_set_label(GTK_MENU_ITEM(MenuPopup.menuAlterarNomeAbaAtiva2), "Alterar nome da aba ativa");
	gtk_menu_item_set_use_underline(GTK_MENU_ITEM(MenuPopup.menuAlterarNomeAbaAtiva2), TRUE);
	
	MenuPopup.menuIncluirNovaAba2 = gtk_menu_item_new();
	gtk_widget_set_name(GTK_WIDGET(MenuPopup.menuIncluirNovaAba2), "menuIncluirNovaAba2");
	gtk_widget_set_visible(MenuPopup.menuIncluirNovaAba2, TRUE);
	gtk_widget_set_can_focus(MenuPopup.menuIncluirNovaAba2, FALSE);
	gtk_menu_item_set_label(GTK_MENU_ITEM(MenuPopup.menuIncluirNovaAba2), "Incluir nova aba");
	gtk_menu_item_set_use_underline(GTK_MENU_ITEM(MenuPopup.menuIncluirNovaAba2), TRUE);
	
	MenuPopup.separador2 = gtk_separator_menu_item_new();
	gtk_widget_set_name(GTK_WIDGET(MenuPopup.separador2), "separador2");
	gtk_widget_set_visible(MenuPopup.separador2, TRUE);
	gtk_widget_set_can_focus(MenuPopup.separador2, FALSE);
	
	MenuPopup.menuColapsarDiretorios2 = gtk_menu_item_new();
	gtk_widget_set_name(GTK_WIDGET(MenuPopup.menuColapsarDiretorios2), "menuColapsarDiretorios2");
	gtk_widget_set_visible(MenuPopup.menuColapsarDiretorios2, TRUE);
	gtk_widget_set_can_focus(MenuPopup.menuColapsarDiretorios2, FALSE);
	gtk_menu_item_set_label(GTK_MENU_ITEM(MenuPopup.menuColapsarDiretorios2), "Colapsar Diretórios");
	gtk_menu_item_set_use_underline(GTK_MENU_ITEM(MenuPopup.menuColapsarDiretorios2), TRUE);
	
	MenuPopup.menuExpandirDiretorios2 = gtk_menu_item_new();
	gtk_widget_set_name(GTK_WIDGET(MenuPopup.menuExpandirDiretorios2), "menuExpandirDiretorios2");
	gtk_widget_set_visible(MenuPopup.menuExpandirDiretorios2, TRUE);
	gtk_widget_set_can_focus(MenuPopup.menuExpandirDiretorios2, FALSE);
	gtk_menu_item_set_label(GTK_MENU_ITEM(MenuPopup.menuExpandirDiretorios2), "Expandir Diretórios");
	gtk_menu_item_set_use_underline(GTK_MENU_ITEM(MenuPopup.menuExpandirDiretorios2), TRUE);
	
	MenuPopup.menuExcluirDiretorioSelecionado = gtk_menu_item_new();
	gtk_widget_set_name(GTK_WIDGET(MenuPopup.menuExcluirDiretorioSelecionado), "menuExcluirDiretorioSelecionado");
	gtk_widget_set_visible(MenuPopup.menuExcluirDiretorioSelecionado, TRUE);
	gtk_widget_set_can_focus(MenuPopup.menuExcluirDiretorioSelecionado, FALSE);
	gtk_menu_item_set_label(GTK_MENU_ITEM(MenuPopup.menuExcluirDiretorioSelecionado), "Excluir Diretório Selecionado");
	gtk_menu_item_set_use_underline(GTK_MENU_ITEM(MenuPopup.menuExcluirDiretorioSelecionado), TRUE);
	
	MenuPopup.menuInformacoesDiretorioArquivo = gtk_menu_item_new();
	gtk_widget_set_name(GTK_WIDGET(MenuPopup.menuInformacoesDiretorioArquivo), "menuInformacoesDiretorioArquivo");
	gtk_widget_set_visible(MenuPopup.menuInformacoesDiretorioArquivo, TRUE);
	gtk_widget_set_can_focus(MenuPopup.menuInformacoesDiretorioArquivo, FALSE);
	gtk_menu_item_set_label(GTK_MENU_ITEM(MenuPopup.menuInformacoesDiretorioArquivo), "Informações do Diretório / Arquivo");
	gtk_menu_item_set_use_underline(GTK_MENU_ITEM(MenuPopup.menuInformacoesDiretorioArquivo), TRUE);
	
	gtk_widget_set_name(MenuPopup.menuPopup, "menuPopup");
	gtk_widget_set_visible(MenuPopup.menuPopup, TRUE);
	gtk_widget_set_can_focus(MenuPopup.menuPopup, FALSE);
	gtk_container_add(GTK_CONTAINER(MenuPopup.menuPopup), GTK_WIDGET(MenuPopup.menuInformacoesDiretorioArquivo));
	gtk_container_add(GTK_CONTAINER(MenuPopup.menuPopup), GTK_WIDGET(MenuPopup.menuExcluirDiretorioSelecionado));
	gtk_container_add(GTK_CONTAINER(MenuPopup.menuPopup), GTK_WIDGET(MenuPopup.menuExpandirDiretorios2));
	gtk_container_add(GTK_CONTAINER(MenuPopup.menuPopup), GTK_WIDGET(MenuPopup.menuColapsarDiretorios2));
	gtk_container_add(GTK_CONTAINER(MenuPopup.menuPopup), GTK_WIDGET(MenuPopup.separador2));
	gtk_container_add(GTK_CONTAINER(MenuPopup.menuPopup), GTK_WIDGET(MenuPopup.menuIncluirNovaAba2));
	gtk_container_add(GTK_CONTAINER(MenuPopup.menuPopup), GTK_WIDGET(MenuPopup.menuAlterarNomeAbaAtiva2));
	gtk_container_add(GTK_CONTAINER(MenuPopup.menuPopup), GTK_WIDGET(MenuPopup.menuExcluirAbaAtiva2));
	

	g_signal_connect((gpointer) MenuPopup.menuInformacoesDiretorioArquivo, "activate", G_CALLBACK(on_menuInformacoesDiretorioArquivo_activate), NULL); 
	g_signal_connect((gpointer) MenuPopup.menuExcluirDiretorioSelecionado, "activate", G_CALLBACK(on_menuExcluirDiretorioSelecionado_activate), NULL); 
	g_signal_connect((gpointer) MenuPopup.menuExpandirDiretorios2, "activate", G_CALLBACK(on_menuExpandirDiretorios2_activate), NULL); 
	g_signal_connect((gpointer) MenuPopup.menuColapsarDiretorios2, "activate", G_CALLBACK(on_menuColapsarDiretorios2_activate), NULL); 
	g_signal_connect((gpointer) MenuPopup.menuIncluirNovaAba2, "activate", G_CALLBACK(on_menuIncluirNovaAba2_activate), NULL); 
	g_signal_connect((gpointer) MenuPopup.menuAlterarNomeAbaAtiva2, "activate", G_CALLBACK(on_menuAlterarNomeAbaAtiva2_activate), NULL); 
	g_signal_connect((gpointer) MenuPopup.menuExcluirAbaAtiva2, "activate", G_CALLBACK(on_menuExcluirAbaAtiva2_activate), NULL); 

		
	g_signal_connect ((gpointer) MenuPopup.menuPopup, "destroy", 
		G_CALLBACK (on_MenuPopup_destroy), NULL);

	return MenuPopup.menuPopup;
}
// ---------------------------------------------------------------------------
void MenuPopup_Mostrar() 
{
    
}
// ---------------------------------------------------------------------------
void on_MenuPopup_destroy(GtkObject *object, gpointer user_data) {
	
}
// ---------------------------------------------------------------------------
void on_menuInformacoesDiretorioArquivo_activate(GtkObject *object, gpointer user_data){

}

void on_menuExcluirDiretorioSelecionado_activate(GtkObject *object, gpointer user_data){
		
}

void on_menuExpandirDiretorios2_activate(GtkObject *object, gpointer user_data){
		
}

void on_menuColapsarDiretorios2_activate(GtkObject *object, gpointer user_data){
		
}

void on_menuIncluirNovaAba2_activate(GtkObject *object, gpointer user_data){
		
}

void on_menuAlterarNomeAbaAtiva2_activate(GtkObject *object, gpointer user_data){
		
}

void on_menuExcluirAbaAtiva2_activate(GtkObject *object, gpointer user_data){
		
}


// ---------------------------------------------------------------------------
