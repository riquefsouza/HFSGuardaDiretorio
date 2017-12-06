//---------------------------------------------------------------------------

#ifndef InfoDiretorioH
#define InfoDiretorioH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include "Diretorio.h"
//---------------------------------------------------------------------------
class TFrmInfoDiretorio : public TForm
{
__published:	// IDE-managed Components
	TGroupBox *GroupBox1;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
	TLabel *Label5;
	TLabel *Label6;
	TStringGrid *sgInfo;
	TPanel *Panel1;
	TButton *btnOk;
	void __fastcall FormShow(TObject *Sender);
	void __fastcall sgInfoDrawCell(TObject *Sender, int ACol, int ARow, TRect &Rect,
          TGridDrawState State);
private:	// User declarations
public:		// User declarations
	TDiretorio diretorio;
	__fastcall TFrmInfoDiretorio(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmInfoDiretorio *FrmInfoDiretorio;
//---------------------------------------------------------------------------
#endif
