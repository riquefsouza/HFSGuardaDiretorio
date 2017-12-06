// ---------------------------------------------------------------------------

#ifndef DataModuleH
#define DataModuleH
// ---------------------------------------------------------------------------
#include "SQLiteTable3.h"
// ---------------------------------------------------------------------------
class Tdm : public TDataModule {
__published: // IDE-managed Components

private: // User declarations
		public : // User declarations
	__fastcall Tdm(TComponent* Owner);
	TSQLiteDatabase *conexao;
	TSQLiteTable *tabelaExtensoes, *tabelaAbas;
	AnsiString SQLDiretorios, SQLExtensoes, SQLAbas;
	AnsiString consultaDirPai, consultaDirFilho, consultaArquivo;
};

// ---------------------------------------------------------------------------
extern PACKAGE Tdm *dm;
// ---------------------------------------------------------------------------
#endif
