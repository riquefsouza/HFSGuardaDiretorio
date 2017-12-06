// ---------------------------------------------------------------------------

#ifndef SobreH
#define SobreH
// ---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>

// ---------------------------------------------------------------------------
class TFrmSobre : public TForm {
__published: // IDE-managed Components

	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
	TButton *btnOk;

private: // User declarations
		public : // User declarations

	__fastcall TFrmSobre(TComponent* Owner);
};

// ---------------------------------------------------------------------------
extern PACKAGE TFrmSobre *FrmSobre;
// ---------------------------------------------------------------------------
#endif
