// ---------------------------------------------------------------------------

#ifndef ImportarDiretorioH
#define ImportarDiretorioH
// ---------------------------------------------------------------------------
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <vector>
#include "Importar.h"
#include "Diretorio.h"

// ---------------------------------------------------------------------------
class TFrmImportarDiretorio : public TForm {
__published: // IDE-managed Components

	TMemo *memoImportaDir;
	TStatusBar *barraStatus;
	TProgressBar *pbImportar;

	void __fastcall FormActivate(TObject *Sender);
	void __fastcall memoImportaDirChange(TObject *Sender);

private: // User declarations
	static void ProgressoLog(TProgresso progresso);
public : // User declarations
	bool bSubDiretorio;
	std::vector<TImportar> *listaImportar;
	std::vector<TDiretorio> *listaDiretorio;
	__fastcall TFrmImportarDiretorio(TComponent* Owner);
};

// ---------------------------------------------------------------------------
extern PACKAGE TFrmImportarDiretorio *FrmImportarDiretorio;
// ---------------------------------------------------------------------------
#endif
