// ---------------------------------------------------------------------------

#ifndef RotinasH
#define RotinasH
// ---------------------------------------------------------------------------
#include <Classes.hpp>
#include <SysUtils.hpp>
#include <StrUtils.hpp>
#include <Math.hpp>
#include <DateUtils.hpp>
#include <ComCtrls.hpp>
#include <Graphics.hpp>
#include <DB.hpp>
#include <Controls.hpp>
//#include <GIFImg.hpp>
#include <Jpeg.hpp>
//#include <pngimage.hpp>
#include "Windows.h"
#include "ShellAPI.h"
#include "DataModule.h"
// ---------------------------------------------------------------------------
const char BARRA_NORMAL = '\\';
const char BARRA_INVERTIDA = '/';

enum TTipoExportarExtensao {
	teNUL, teBMP, teICO, teGIF, teJPG, tePNG, teTIF
};

struct TProgresso {
	int minimo;
	int maximo;
	int posicao;
	int passo;
};

typedef void TProgressoLog(TProgresso);

class TRotinas {
private: // User declarations
public : // User declarations
	TRotinas();
	bool criarVisao(String visao);
	bool execConsulta(String sSQL, bool bComTransacao);
	bool atribuirParamsConexao();
	String NomeVolumeDrive(const char Drive, String Path);
	TIcon* extrairIconeArquivo(String sNomeArquivo);
//	bool blobParaGIF(TDataSet* ds, TBlobField* campo, TGIFImage* imagem);
//	TPngImage* blobParaPNG(TDataSet* ds, TBlobField* campo);
//	void GIFParaBlob(TGIFImage* imagem, TDataSet* ds, TBlobField* campo);
//	void PNGParaBlob(TPngImage* imagem, TDataSet* ds, TBlobField* campo);
	TJPEGImage* blobParaJPG(TDataSet* ds, TBlobField* campo);
	void JPGParaBlob(TJPEGImage* imagem, TDataSet* ds, TBlobField* campo);
	TIcon* blobParaIcone(TDataSet* ds, TBlobField* campo);
	Graphics::TBitmap* blobParaBMP(TDataSet* ds, TBlobField* campo);
	void IconeParaBlob(TIcon* imagem, TDataSet* ds, TBlobField* campo);
	void BMPParaBlob(Graphics::TBitmap* imagem, TDataSet* ds,
		TBlobField* campo);
	Graphics::TBitmap* IconeParaBmp(TIcon* Icone, int nTamanho);
	TIcon* BmpParaIcone(Graphics::TBitmap* Bitmap);
//	TGIFImage* BMPParaGIF(Graphics::TBitmap* bmp);
//	Graphics::TBitmap* GIFParaBMP(TGIFImage* gif, int nTamanho);
	TJPEGImage* BMPParaJPG(Graphics::TBitmap* bmp);
	Graphics::TBitmap* JPGParaBMP(TJPEGImage* jpg, int nTamanho);
//	TPngImage* BMPParaPNG(Graphics::TBitmap* bmp);
//	Graphics::TBitmap* PNGParaBMP(TPngImage* png, int nTamanho);
	void BMPParaTIF(Graphics::TBitmap* bmp, String sArquivo);
	TTipoExportarExtensao DetectImage(const String InputFileName,
		Graphics::TBitmap* BM);
	TIcon* StreamParaIcone(TMemoryStream* ms);
//	TGIFImage* StreamParaGIF(TMemoryStream* ms);
	TJPEGImage* StreamParaJPG(TMemoryStream* ms);
	TMemoryStream* JPGParaStream(TJPEGImage* imagem);
	void StreamParaBlob(TMemoryStream* ms, TDataSet* ds, TBlobField* campo);
	Graphics::TBitmap* RedimensionarBMP(Graphics::TBitmap* imagem,
		int nTamanho);
	Graphics::TBitmap* StreamParaBMP(TMemoryStream* ms);
        int CompareTextAsInteger(const String s1, const String s2);
        int CompareTextAsDateTime(const String s1, const String s2);
};

// ---------------------------------------------------------------------------
extern PACKAGE TRotinas *Rotinas;
// ---------------------------------------------------------------------------
#endif
