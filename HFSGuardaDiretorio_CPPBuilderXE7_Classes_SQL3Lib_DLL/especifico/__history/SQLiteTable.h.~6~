//---------------------------------------------------------------------------

#ifndef SQLiteTableH
#define SQLiteTableH
//---------------------------------------------------------------------------
#include "SQLiteDatabase.h"
#include <string>
#include <vector>
//---------------------------------------------------------------------------

struct TSQLiteColuna {
	int ordem;
	TTipoColuna tipo;
	std::string nome;

	__int64 integerValor;
	double doubleValor;
	std::string stringValor;
	TMemoryStream *blobValor;
	bool nuloValor;
};

class TSQLiteTable {
private: // User declarations

	unsigned int nLinhaAtual;
	unsigned int nQtdColunas;
	unsigned int nQtdLinhas;

	std::string *vetorNomeColunas;

	TTipoColuna *vetorTipoColunas;

	std::vector<std::vector<TSQLiteColuna> *> *matrizResultados;

public: // User declarations

	TSQLiteTable(TSQLiteDatabase *DB, const std::string sSQL);
	TSQLiteTable(TSQLiteDatabase *DB, const std::string sSQL,
		const TSQLiteParametro bindings[]);
	~TSQLiteTable();

	std::string Columns(int i);
	unsigned int Count();
	unsigned int ColCount();
	unsigned int Row();
	bool Next();
	bool Previous();
	bool MoveFirst();
	bool MoveLast();
	bool MoveTo(unsigned int posicao);
	bool getEOF();
	bool getBOF();
	std::string FieldByName(std::string sNomeCampo);
	int FieldIndex(std::string sNomeCampo);
	std::string Fields(unsigned int i);
	TMemoryStream* FieldAsBlob(unsigned int i);
	std::string FieldAsBlobText(unsigned int i);
	__int64 FieldAsInteger(unsigned int i);
	double FieldAsDouble(unsigned int i);
	std::string FieldAsString(unsigned int i);
	bool FieldIsNull(unsigned int i);
	// The property CountResult is used when you execute count(*) queries.
	// It returns 0 if (the result set is empty or the value of the
	// first field as an int.
	int CountResult();
};

//---------------------------------------------------------------------------
#endif
