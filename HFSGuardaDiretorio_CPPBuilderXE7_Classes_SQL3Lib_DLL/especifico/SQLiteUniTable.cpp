//---------------------------------------------------------------------------

#pragma hdrstop

#include "SQLiteUniTable.h"
#include "Funcoes.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
// ---------------------------------------------------------------------------
TSQLiteUniTable::TSQLiteUniTable(TSQLiteDatabase *DB, const std::string sSQL) {
	new TSQLiteUniTable(DB, sSQL, NULL);
}

// ---------------------------------------------------------------------------
TSQLiteUniTable::TSQLiteUniTable(TSQLiteDatabase *DB, const std::string sSQL,
	const TSQLiteParametro bindings[]) {
	const char *NextSQLStatement;

	this->localDB = DB;
	this->bEOF = false;
	this->nUniLinhaAtual = 0;
	this->nUniQtdColunas = 0;
	this->sql = sSQL;

	if (sqlite3_prepare_v2(DB->dbHandle, sSQL.c_str(), -1, &this->stmt,
		&NextSQLStatement) != SQLITE_OK) {
		DB->RaiseError("N�o consegui preparar o SQL", sSQL);
	}
	if (stmt == NULL) {
		DB->RaiseError("N�o consegui preparar o SQL", sSQL);
	}

	DB->DoQuery(sSQL);
	DB->SetParams(stmt);
	if (bindings != NULL) {
		DB->BindData(stmt, bindings);
	}

	this->nUniQtdColunas = sqlite3_column_count(stmt);
	this->vetorUniNomeColunas = new std::string[this->nUniQtdColunas];
	for (unsigned int i = 0; i < this->nUniQtdColunas; i++) {
		this->vetorUniNomeColunas[i] = sqlite3_column_name(stmt, i);
	}

	this->Next();
}

// ---------------------------------------------------------------------------
TSQLiteUniTable::~TSQLiteUniTable() {
	if (this->stmt == NULL) {
		sqlite3_finalize(this->stmt);
	}
	if (this->vetorUniNomeColunas != NULL) {
		delete[] this->vetorUniNomeColunas;
	}
}

// ---------------------------------------------------------------------------
std::string TSQLiteUniTable::Columns(int i) {
	return this->vetorUniNomeColunas[i];
}

// ---------------------------------------------------------------------------
unsigned int TSQLiteUniTable::ColCount() {
	return this->nUniQtdColunas;
}

// ---------------------------------------------------------------------------
unsigned int TSQLiteUniTable::Row() {
	return this->nUniLinhaAtual;
}

// ---------------------------------------------------------------------------
bool TSQLiteUniTable::Next() {
	int nResultadoPasso;

	this->bEOF = true;
	nResultadoPasso = sqlite3_step(this->stmt);
	switch (nResultadoPasso) {
	case SQLITE_ROW: {
			this->bEOF = false;
			this->nUniLinhaAtual++;
		} break;
	case SQLITE_DONE:
		// we are on the end of dataset
		// return EOF=true only
		{
		} break;
	default: {
			sqlite3_reset(this->stmt);
			localDB->RaiseError("N�o consegui recuperar os dados", this->sql);
		}
	}
	return (!this->bEOF);

}

// ---------------------------------------------------------------------------
bool TSQLiteUniTable::getEOF() {
	return this->bEOF;
}

// ---------------------------------------------------------------------------
std::string TSQLiteUniTable::FieldByName(std::string sNomeCampo) {
	return Fields(this->FieldIndex(sNomeCampo));
}

// ---------------------------------------------------------------------------
int TSQLiteUniTable::FieldIndex(std::string sNomeCampo) {
	std::stringstream ex;
	int resultado = -1;
	std::string sNomeColuna;

	if (this->vetorUniNomeColunas == NULL) {
		ex << "Campo " << sNomeCampo <<
			" N�o encontrado. Conjunto de dados Vazio";
		throw std::logic_error(ex.str().c_str());
	}

	if (this->nUniQtdColunas == 0) {
		ex << "Campo " << sNomeCampo <<
			" N�o encontrado. Conjunto de dados Vazio";
		throw std::logic_error(ex.str().c_str());
	}

	for (unsigned int i = 0; i < this->nUniQtdColunas; i++) {
		sNomeColuna = this->vetorUniNomeColunas[i];
		if (cppUpperCase(sNomeColuna) == cppUpperCase(sNomeCampo)) {
			resultado = i;
			break;
		}
	}

	if (resultado < 0) {
		ex << "Campo " << sNomeCampo << " N�o encontrado no Conjunto de dados";
		throw std::logic_error(ex.str().c_str());
	}

	return resultado;
}

// ---------------------------------------------------------------------------
std::string TSQLiteUniTable::Fields(unsigned int i) {
	char* texto;
	std::string retorno;

	texto = (char*)sqlite3_column_text(this->stmt, i);
	retorno = texto;

	return retorno;
}

// ---------------------------------------------------------------------------
TMemoryStream* TSQLiteUniTable::FieldAsBlob(unsigned int i) {
	int nQtdBytes;
	TMemoryStream *retorno;
	const void *ponteiro;

	retorno = new TMemoryStream();

	nQtdBytes = sqlite3_column_bytes(this->stmt, i);
	if (nQtdBytes > 0) {
		ponteiro = sqlite3_column_blob(this->stmt, i);
		retorno->WriteBuffer(ponteiro, nQtdBytes);
		retorno->Position = 0;
	}
	return retorno;
}

// ---------------------------------------------------------------------------
std::string TSQLiteUniTable::FieldAsBlobText(unsigned int i) {
	TMemoryStream *MemStream;
	char *Buffer;
	std::string *resultado = new std::string();

	(*resultado) = "";
	MemStream = this->FieldAsBlob(i);
	if (MemStream != NULL) {
		if (MemStream->Size > 0) {
			MemStream->Position = 0;
#ifdef __UNICODE
			Buffer = Ansistrings::AnsiStrAlloc(MemStream->Size + 1);
#else
			Buffer = (PAnsiChar)StrAlloc(MemStream->Size + 1);
			//Buffer = cppNewStr(MemStream->Size + 1);
#endif
			MemStream->ReadBuffer(Buffer, (int)MemStream->Size);
			(*(Buffer + (int)MemStream->Size)) = char(0);
			// SetString(resultado, Buffer, MemStream->Size);
			resultado = new std::string(Buffer, MemStream->Size);
			// Ansistrings::StrDispose(Buffer);
			delete Buffer;
		}
		MemStream->Free();
	}
	return (*resultado);

}

// ---------------------------------------------------------------------------
__int64 TSQLiteUniTable::FieldAsInteger(unsigned int i) {
	return sqlite3_column_int64(this->stmt, i);
}

// ---------------------------------------------------------------------------
double TSQLiteUniTable::FieldAsDouble(unsigned int i) {
	return sqlite3_column_double(this->stmt, i);
}

// ---------------------------------------------------------------------------
std::string TSQLiteUniTable::FieldAsString(unsigned int i) {
	return this->Fields(i);
}

// ---------------------------------------------------------------------------
bool TSQLiteUniTable::FieldIsNull(unsigned int i) {
	return (sqlite3_column_text(this->stmt, i) == NULL);
}

// ---------------------------------------------------------------------------
const void* TSQLiteUniTable::FieldAsBlobPtr(unsigned int i, int *iNumBytes) {
	(*iNumBytes) = sqlite3_column_bytes(this->stmt, i);
	return sqlite3_column_blob(this->stmt, i);
}
// ---------------------------------------------------------------------------

