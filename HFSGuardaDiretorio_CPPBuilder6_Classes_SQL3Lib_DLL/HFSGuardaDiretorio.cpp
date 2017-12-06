//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "Splash.h"
// ---------------------------------------------------------------------------
USEFORM("Splash.cpp", FrmSplash);
USEFORM("CadExtensao.cpp", FrmCadExtensao);
USEFORM("CompararDiretorio.cpp", FrmCompararDiretorio);
USEFORM("DataModule.cpp", dm); /* TDataModule: File Type */
USEFORM("EscolherDir.cpp", FrmEscolherDir);
USEFORM("ImportarDiretorio.cpp", FrmImportarDiretorio);
USEFORM("InfoDiretorio.cpp", FrmInfoDiretorio);
USEFORM("Principal.cpp", FrmPrincipal);
USEFORM("Sobre.cpp", FrmSobre);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();

 		 // Application->CreateForm(__classid(TFrmSplash), &FrmSplash);
		 FrmSplash = new TFrmSplash(Application);
		 FrmSplash->Show();
		 FrmSplash->Update();

		 Application->CreateForm(__classid(TFrmPrincipal), &FrmPrincipal);
                 Application->CreateForm(__classid(Tdm), &dm);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        catch (...)
        {
                 try
                 {
                         throw Exception("");
                 }
                 catch (Exception &exception)
                 {
                         Application->ShowException(&exception);
                 }
        }
        return 0;
}
//---------------------------------------------------------------------------
