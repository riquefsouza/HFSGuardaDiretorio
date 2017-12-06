#include "HFSGuardaDiretorio.h"
#include "FrmPrincipal.h"
#include "hfsguardadir/comum/Rotinas.h"
#include "hfsguardadir/objetosdao/AbaDAO.h"
#include "hfsguardadir/catalogador/Catalogador.h"
// ---------------------------------------------------------------------------

void testarDAO() {
	GString* sApp = Rotinas_AppDirPath();
	sApp = g_string_append(sApp, "GuardaDir.db");
	Rotinas_BancoConectar(sApp);

	ListaAba lista = AbaDAO_consultarTudo(NULL);

	guint tamlista = ListaAba_conta(lista);
	Aba aba1 = Aba_new();
	GString *saida = g_string_new("");
	if (tamlista > 0) {
		for (unsigned int i = 0; i < tamlista; i++) {
			aba1 = ListaAba_pesquisaItemOrd(lista, i);

			g_string_printf(saida, "sDir: [%s]\n", aba1->nome->str);
			OutputDebugString(saida->str);
		}
	}

	ListaAba_removeTodos(&lista);

	tamlista = ListaAba_conta(lista);

	Aba aba = Aba_new();
	aba->codigo = 3;
	aba->nome = g_string_new("DISCO3");
	aba->ordem = 3;
	AbaDAO_incluir(aba);
	
	Rotinas_BancoDesconectar();

	Aba_free(&aba1);
	Aba_free(&aba);
}


int main(int argc, char *argv[]) {

  Rotinas_argumentos(argc, argv);

#ifdef G_OS_WIN32
    package_prefix = g_win32_get_package_installation_directory(NULL, NULL);
    package_datadir = g_strdup_printf("%s%s", package_prefix, "");
#endif

#ifdef ENABLE_NLS
  #ifdef G_OS_WIN32
     gchar *temp;

     temp = g_strdup_printf("%s%s", package_prefix, "/lib/locale");
     bindtextdomain(GETTEXT_PACKAGE, temp);
     g_free(temp);
  #else
     //bindtextdomain (GETTEXT_PACKAGE, PACKAGE_LOCALE_DIR);
     bindtextdomain (GETTEXT_PACKAGE, "/usr/local/share/locale");
  #endif
  bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
  textdomain(GETTEXT_PACKAGE);
#endif
// ---------------------------------------------------------------------------
  gtk_set_locale();
  gtk_init(&argc, &argv);

  //Rotinas_testar();
  //testarDAO();

  Catalogador_iniciarSistema();
  FrmPrincipal_Mostrar();
  gtk_main();

// ---------------------------------------------------------------------------
#ifdef G_OS_WIN32
    g_free(package_prefix);
    g_free(package_datadir);
#endif
// ---------------------------------------------------------------------------
    return 0;
}
// ---------------------------------------------------------------------------
