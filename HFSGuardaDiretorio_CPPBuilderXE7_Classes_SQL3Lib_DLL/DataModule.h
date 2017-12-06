// ---------------------------------------------------------------------------

#ifndef DataModuleH
#define DataModuleH
// ---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include "SQLiteDatabase.h"
#include "SQLiteTable.h"
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
