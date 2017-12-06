#ifndef FrmSobre_H
#define FrmSobre_H
// ---------------------------------------------------------------------------
#include "resource.h"
// ---------------------------------------------------------------------------
struct SFrmSobre {
	GtkWidget *dialog_vbox1; 
	GtkWidget *vbox4; 
	GtkWidget *label; 
	GtkWidget *label8; 
	GtkWidget *label9; 
	GtkWidget *label10; 
	GtkWidget *dialog_action_area1; 
	GtkWidget *btbOk; 

	GtkWidget *frmSobre;
};
struct SFrmSobre FrmSobre;
// ---------------------------------------------------------------------------
	GtkWidget *FrmSobre_Criar();
	void FrmSobre_Mostrar();
	void on_FrmSobre_destroy(GtkObject *object, gpointer user_data);

	void on_btbOk_clicked(GtkObject *object, gpointer user_data);

// ---------------------------------------------------------------------------
#endif
// ---------------------------------------------------------------------------
