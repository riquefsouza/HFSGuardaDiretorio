// ---------------------------------------------------------------------------

#ifndef EscolherDirH
#define EscolherDirH
// ---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <FileCtrl.hpp>
#include <StdCtrls.hpp>
// ---------------------------------------------------------------------------
class TFrmEscolherDir : public TForm {
__published: // IDE-managed Components

	TDirectoryListBox *DirectoryListBox1;
	TDriveComboBox *DriveComboBox1;
	TButton *btnOk;
	TLabel *Label1;
	TLabel *labDiretorio;
	TShape *Shape1;
	TButton *btnCancelar;

private: // User declarations
		public : // User declarations

	__fastcall TFrmEscolherDir(TComponent* Owner);
};

// ---------------------------------------------------------------------------
extern PACKAGE TFrmEscolherDir *FrmEscolherDir;
// ---------------------------------------------------------------------------
#endif
