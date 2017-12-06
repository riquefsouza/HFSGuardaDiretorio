// ---------------------------------------------------------------------------

#ifndef SplashH
#define SplashH
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include "Rotinas.h"

// ---------------------------------------------------------------------------
class TFrmSplash : public TForm {
__published: // IDE-managed Components

	TLabel *Label1;
	TLabel *Label2;
	TProgressBar *pb;

private: // User declarations
public : // User declarations

	__fastcall TFrmSplash(TComponent* Owner);
	static void ProgressoLog(TProgresso progresso);        
};

// ---------------------------------------------------------------------------
extern PACKAGE TFrmSplash *FrmSplash;
// ---------------------------------------------------------------------------
#endif
