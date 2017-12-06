#include "Dialogo.h"
#include "hfsguardadir/comum/Rotinas.h"

gint Dialogo_MsgDlg(GtkWidget *pai, const gchar *sTitulo, 
	const gchar *sMensagem, GtkMessageType tipo, GtkButtonsType botoes) {
	GtkWidget *dialog;
	dialog = gtk_message_dialog_new(GTK_WINDOW(pai),
		GTK_DIALOG_MODAL | GTK_DIALOG_DESTROY_WITH_PARENT, tipo, botoes,
		"%s", Rotinas_retUTF8(sMensagem));
	gtk_window_set_title(GTK_WINDOW(dialog), sTitulo);
	gtk_window_set_position(GTK_WINDOW(dialog), GTK_WIN_POS_CENTER);
	gint ret = gtk_dialog_run(GTK_DIALOG(dialog));
	gtk_widget_destroy(dialog);

	return ret;
}

void Dialogo_mensagemErro2(GtkWidget *pai, const char* recurso, const GString* texto) {
	//GString *log = g_string_new("");
	GString *msg, *titulo;

	msg = Rotinas_getRecurso(recurso);
	msg = Rotinas_concatenar1(msg, " ", texto->str);

	titulo = Rotinas_getRecurso("Dialogo.erro");
	
	Dialogo_MsgDlg(pai, titulo->str, msg->str, GTK_MESSAGE_ERROR, GTK_BUTTONS_OK);

	//g_string_printf(log, "warning: %s\n", msg->str); 
	//OutputDebugString(log->str);
}

void Dialogo_mensagemErro(GtkWidget *pai, const char* recurso) {
	Dialogo_mensagemErro2(pai, recurso, g_string_new(""));
}

void Dialogo_mensagemInfo(GtkWidget *pai, const char* recurso) {
	//GString *log = g_string_new("");
	GString *msg, *titulo;

	msg = Rotinas_getRecurso(recurso);
	titulo = Rotinas_getRecurso("Dialogo.info");

	Dialogo_MsgDlg(pai, titulo->str, msg->str, GTK_MESSAGE_INFO, GTK_BUTTONS_OK);

	//g_string_printf(log, "info: %s\n", msg->str);
	//OutputDebugString(log->str);
}

gboolean Dialogo_confirma(GtkWidget *pai, const char* recurso) {
	GString *msg, *titulo;

	msg = Rotinas_getRecurso(recurso);
	titulo = Rotinas_getRecurso("Dialogo.confirma");

	return (Dialogo_MsgDlg(pai, titulo->str, msg->str,
		GTK_MESSAGE_QUESTION, GTK_BUTTONS_YES_NO) == GTK_RESPONSE_YES);
}

GString* Dialogo_entrada2(GtkWidget *pai, const char* recurso,
	const GString* valorInicial) {
	GString *titulo, *rotulo, *texto;

	GtkWidget *dialog;
	GtkWidget *hbox;
	GtkWidget *stock;
	GtkWidget *table;
	GtkWidget *local_entry1;
	GtkWidget *label;
	gint response;

	texto = g_string_new("");
	titulo = Rotinas_getRecurso("Dialogo.entrada");
	rotulo = Rotinas_getRecurso(recurso);

	dialog = gtk_dialog_new_with_buttons(titulo->str,
		GTK_WINDOW(pai),
		GTK_DIALOG_MODAL | GTK_DIALOG_DESTROY_WITH_PARENT,
		GTK_STOCK_OK,
		GTK_RESPONSE_OK,
		GTK_STOCK_CANCEL,
		GTK_RESPONSE_CANCEL,
		NULL);

	hbox = gtk_hbox_new(FALSE, 8);
	gtk_container_set_border_width(GTK_CONTAINER(hbox), 8);
	gtk_box_pack_start(GTK_BOX(GTK_DIALOG(dialog)->vbox), hbox, FALSE, FALSE, 0);

	stock = gtk_image_new_from_stock(GTK_STOCK_DIALOG_QUESTION, GTK_ICON_SIZE_DIALOG);
	gtk_box_pack_start(GTK_BOX(hbox), stock, FALSE, FALSE, 0);

	table = gtk_table_new(2, 2, FALSE);
	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
	gtk_table_set_col_spacings(GTK_TABLE(table), 4);
	gtk_box_pack_start(GTK_BOX(hbox), table, TRUE, TRUE, 0);
	label = gtk_label_new_with_mnemonic(rotulo->str);
	gtk_table_attach_defaults(GTK_TABLE(table),
		label,
		0, 1, 0, 1);
	local_entry1 = gtk_entry_new();
	gtk_entry_set_text(GTK_ENTRY(local_entry1), valorInicial->str);
	gtk_table_attach_defaults(GTK_TABLE(table), local_entry1, 1, 2, 0, 1);
	gtk_label_set_mnemonic_widget(GTK_LABEL(label), local_entry1);

	gtk_widget_show_all(hbox);
	response = gtk_dialog_run(GTK_DIALOG(dialog));

	if (response == GTK_RESPONSE_OK)
	{
		texto = g_string_new(gtk_entry_get_text(GTK_ENTRY(local_entry1)));
	}

	gtk_widget_destroy(dialog);

	return texto;
}

GString* Dialogo_entrada(GtkWidget *pai, const char* recurso) {
	return Dialogo_entrada2(pai, recurso, g_string_new(""));
}
