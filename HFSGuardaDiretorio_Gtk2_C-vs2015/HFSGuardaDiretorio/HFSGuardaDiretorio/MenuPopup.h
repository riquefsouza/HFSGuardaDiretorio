#ifndef MenuPopup_H
#define MenuPopup_H
// ---------------------------------------------------------------------------
#include "resource.h"
// ---------------------------------------------------------------------------
struct SMenuPopup {
	GtkWidget *menuInformacoesDiretorioArquivo; 
	GtkWidget *menuExcluirDiretorioSelecionado; 
	GtkWidget *menuExpandirDiretorios2; 
	GtkWidget *menuColapsarDiretorios2; 
	GtkWidget *separador2; 
	GtkWidget *menuIncluirNovaAba2; 
	GtkWidget *menuAlterarNomeAbaAtiva2; 
	GtkWidget *menuExcluirAbaAtiva2; 

	GtkWidget *menuPopup;
};
struct SMenuPopup MenuPopup;
// ---------------------------------------------------------------------------
	GtkWidget *MenuPopup_Criar();
	void MenuPopup_Mostrar();
	void on_MenuPopup_destroy(GtkObject *object, gpointer user_data);

	void on_menuInformacoesDiretorioArquivo_activate(GtkObject *object, gpointer user_data);
	void on_menuExcluirDiretorioSelecionado_activate(GtkObject *object, gpointer user_data);
	void on_menuExpandirDiretorios2_activate(GtkObject *object, gpointer user_data);
	void on_menuColapsarDiretorios2_activate(GtkObject *object, gpointer user_data);
	void on_menuIncluirNovaAba2_activate(GtkObject *object, gpointer user_data);
	void on_menuAlterarNomeAbaAtiva2_activate(GtkObject *object, gpointer user_data);
	void on_menuExcluirAbaAtiva2_activate(GtkObject *object, gpointer user_data);

// ---------------------------------------------------------------------------
#endif
// ---------------------------------------------------------------------------
