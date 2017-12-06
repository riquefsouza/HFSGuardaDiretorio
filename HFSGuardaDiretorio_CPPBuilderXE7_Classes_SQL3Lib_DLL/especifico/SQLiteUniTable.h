//---------------------------------------------------------------------------

#ifndef SQLiteUniTableH
#define SQLiteUniTableH
//---------------------------------------------------------------------------
#include "SQLiteDatabase.h"
#include <string>
#include <vector>
//---------------------------------------------------------------------------
class TSQLiteUniTable {
private: // User declarations
	unsigned int nUniLinhaAtual;
	unsigned int nUniQtdColunas;
	std::string *vetorUniNomeColunas;
	bool bEOF;
	sqlite3_stmt *stmt;
	TSQLiteDatabase *localDB;
	std::string sql;
public: // User declarations
	TSQLiteUniTable(TSQLiteDatabase *DB, const std::string sSQL);
	TSQLiteUniTable(TSQLiteDatabase *DB, const std::string sSQL,
		const TSQLiteParametro bindings[]);
	~TSQLiteUniTable();

	std::string Columns(int i);
	unsigned int ColCount();
	unsigned int Row();
	bool Next();
	bool getEOF();
	std::string FieldByName(std::string sNomeCampo);
	int FieldIndex(std::string sNomeCampo);
	std::string Fields(unsigned int i);
	TMemoryStream* FieldAsBlob(unsigned int i);
	std::string FieldAsBlobText(unsigned int i);
	__int64 FieldAsInteger(unsigned int i);
	double FieldAsDouble(unsigned int i);
	std::string FieldAsString(unsigned int i);
	bool FieldIsNull(unsigned int i);

	const void* FieldAsBlobPtr(unsigned int i, int *iNumBytes);

};
//---------------------------------------------------------------------------
#endif
