#include "FrmSplash.h"
// ---------------------------------------------------------------------------
GtkWidget *FrmSplash_Criar()
{
	FrmSplash.frmSplash = gtk_window_new(GTK_WINDOW_TOPLEVEL);

	FrmSplash.pb1 = gtk_progress_bar_new();
	gtk_widget_set_name(GTK_WIDGET(FrmSplash.pb1), "pb1");
	gtk_widget_set_visible(FrmSplash.pb1, TRUE);
	gtk_widget_set_can_focus(FrmSplash.pb1, FALSE);
	
	FrmSplash.label5 = gtk_label_new("Catalogador de Diretórios");
	gtk_widget_set_name(GTK_WIDGET(FrmSplash.label5), "label5");
	gtk_widget_set_visible(FrmSplash.label5, TRUE);
	gtk_widget_set_can_focus(FrmSplash.label5, FALSE);
	gtk_label_set_label(GTK_LABEL(FrmSplash.label5), Rotinas_retUTF8("Catalogador de Diretórios"));
	
	FrmSplash.label4 = gtk_label_new("HFSGuardaDiretorio 2.0");
	gtk_widget_set_name(GTK_WIDGET(FrmSplash.label4), "label4");
	gtk_widget_set_visible(FrmSplash.label4, TRUE);
	gtk_widget_set_can_focus(FrmSplash.label4, FALSE);
	gtk_label_set_label(GTK_LABEL(FrmSplash.label4), "HFSGuardaDiretorio 2.0");

	PangoFontDescription* pfd20 = pango_font_description_from_string("Bold 20");
	PangoFontDescription* pfd15 = pango_font_description_from_string("Bold 15");
	gtk_widget_modify_font(FrmSplash.label4, pfd20);
	gtk_widget_modify_font(FrmSplash.label5, pfd15);
	
	FrmSplash.vbox2 = gtk_vbox_new(FALSE, 0);
	gtk_widget_set_name(GTK_WIDGET(FrmSplash.vbox2), "vbox2");
	gtk_widget_set_visible(FrmSplash.vbox2, TRUE);
	gtk_widget_set_can_focus(FrmSplash.vbox2, FALSE);
	gtk_box_set_spacing(GTK_BOX(FrmSplash.vbox2), 6);
	gtk_container_set_border_width(GTK_CONTAINER(FrmSplash.vbox2), 1);
	gtk_container_add(GTK_CONTAINER(FrmSplash.vbox2), FrmSplash.label4);
	gtk_box_set_child_packing(GTK_BOX(FrmSplash.vbox2), FrmSplash.label4, FALSE, TRUE, 0, GTK_PACK_START);
	gtk_container_add(GTK_CONTAINER(FrmSplash.vbox2), FrmSplash.label5);
	gtk_box_set_child_packing(GTK_BOX(FrmSplash.vbox2), FrmSplash.label5, FALSE, TRUE, 0, GTK_PACK_START);
	gtk_container_add(GTK_CONTAINER(FrmSplash.vbox2), FrmSplash.pb1);
	gtk_box_set_child_packing(GTK_BOX(FrmSplash.vbox2), FrmSplash.pb1, FALSE, TRUE, 0, GTK_PACK_START);
	
	gtk_widget_set_name(FrmSplash.frmSplash, "frmSplash");
	gtk_widget_set_size_request(FrmSplash.frmSplash, 375, 113);
	gtk_widget_set_visible(FrmSplash.frmSplash, TRUE);
	gtk_widget_set_can_focus(FrmSplash.frmSplash, FALSE);
	gtk_window_set_modal(GTK_WINDOW(FrmSplash.frmSplash), TRUE);
	gtk_window_set_resizable(GTK_WINDOW(FrmSplash.frmSplash), FALSE);
	gtk_window_set_position(GTK_WINDOW(FrmSplash.frmSplash), GTK_WIN_POS_CENTER_ALWAYS);
	gtk_window_set_default_size(GTK_WINDOW(FrmSplash.frmSplash), 375, 113);
	gtk_window_set_decorated(GTK_WINDOW(FrmSplash.frmSplash), FALSE);
	gtk_container_add(GTK_CONTAINER(FrmSplash.frmSplash), GTK_WIDGET(FrmSplash.vbox2));
	
	g_signal_connect ((gpointer) FrmSplash.frmSplash, "destroy", 
		G_CALLBACK (on_FrmSplash_destroy), NULL);

	return FrmSplash.frmSplash;
}
// ---------------------------------------------------------------------------
void FrmSplash_Mostrar() 
{
    FrmSplash.frmSplash = FrmSplash_Criar();
	gtk_window_set_position (GTK_WINDOW(FrmSplash.frmSplash), GTK_WIN_POS_CENTER_ALWAYS);
	gtk_widget_show_all(FrmSplash.frmSplash);
}

void FrmSplash_Fechar()
{
	gtk_widget_hide(FrmSplash.frmSplash);
	gtk_widget_destroy(FrmSplash.frmSplash);
}

void FrmSplash_ProgressoLog(Progresso progresso)
{
	if (FrmSplash.frmSplash != NULL) {
		if (progresso.posicao == 0) {
			gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(FrmSplash.pb1), progresso.minimo);
			gtk_progress_bar_set_pulse_step(GTK_PROGRESS_BAR(FrmSplash.pb1), 0.1); //progresso.passo
		}
		gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(FrmSplash.pb1),
			Rotinas_calculaProgresso(progresso.maximo, progresso.posicao));

		while (gtk_events_pending()) {
			gtk_main_iteration();
		}
	}

}

void on_FrmSplash_destroy(GtkObject *object, gpointer user_data) {
	
}

// ---------------------------------------------------------------------------
