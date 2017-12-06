//---------------------------------------------------------------------------

#pragma hdrstop

#include "SQLiteTable.h"
#include "Funcoes.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
// ---------------------------------------------------------------------------
TSQLiteTable::TSQLiteTable(TSQLiteDatabase *DB, const std::string sSQL) {
	new TSQLiteTable(DB, sSQL, NULL);
}

// ------------------------------------------------------------------------------
TSQLiteTable::TSQLiteTable(TSQLiteDatabase *DB, const std::string sSQL,
	const TSQLiteParametro bindings[]) {
	std::stringstream ex;
	sqlite3_stmt *stmt;
	const char *NextSQLStatement;
	int nResultadoPasso;
	TTipoColuna tipoColuna;
	int tipoColunaAtual, nQtdBytes;
	const char *tipoColunaDeclarada;
	std::string sTipoColunaDeclarada;
	TSQLiteColuna coluna;
	TMemoryStream *blobValor;
	const void *ponteiro;
	std::vector<TSQLiteColuna> *vetorColunas;

	this->nQtdLinhas = 0;
	this->nQtdColunas = 0;

	this->matrizResultados = new std::vector<std::vector<TSQLiteColuna> *>();

	if (sqlite3_prepare_v2(DB->dbHandle, sSQL.c_str(), -1, &stmt,
		&NextSQLStatement) != SQLITE_OK) {
		DB->RaiseError("Não consegui preparar o SQL", sSQL);
	}
	if (stmt == NULL) {
		DB->RaiseError("Não consegui preparar o SQL", sSQL);
	}

	DB->DoQuery(sSQL);
	DB->SetParams(stmt);
	if (bindings != NULL) {
		DB->BindData(stmt, bindings);
	}

	nResultadoPasso = sqlite3_step(stmt);
	while (nResultadoPasso != SQLITE_DONE) {
		switch (nResultadoPasso) {
		case SQLITE_ROW: {

				this->nQtdLinhas++;

				if (this->nQtdLinhas == 1) {
					this->nQtdColunas = sqlite3_column_count(stmt);

					this->vetorNomeColunas = new std::string[this->nQtdColunas];
					this->vetorTipoColunas = new TTipoColuna[this->nQtdColunas];

					for (unsigned int i = 0; i < this->nQtdColunas; i++) {
						this->vetorNomeColunas[i] =
							sqlite3_column_name(stmt, i);
					}

					for (unsigned int i = 0; i < this->nQtdColunas; i++) {
						tipoColunaDeclarada = sqlite3_column_decltype(stmt, i);
						sTipoColunaDeclarada = tipoColunaDeclarada;
						sTipoColunaDeclarada =
							cppUpperCase(sTipoColunaDeclarada);

						if (tipoColunaDeclarada == NULL) {
							tipoColuna =
								(TTipoColuna)sqlite3_column_type(stmt, i);
						}
						else if ((sTipoColunaDeclarada == "INTEGER") ||
							(sTipoColunaDeclarada == "BOOLEAN"))
							tipoColuna = SQLITE_INTEGER;
						else if ((sTipoColunaDeclarada == "NUMERIC") ||
							(sTipoColunaDeclarada == "FLOAT") ||
							(sTipoColunaDeclarada == "DOUBLE") ||
							(sTipoColunaDeclarada == "REAL"))
							tipoColuna = SQLITE_FLOAT;
						else if (sTipoColunaDeclarada == "BLOB")
							tipoColuna = SQLITE_BLOB;
						else
							tipoColuna = SQLITE_TEXT;
						this->vetorTipoColunas[i] = tipoColuna;
					}
				}

				vetorColunas = new std::vector<TSQLiteColuna>();
				for (unsigned int nColuna = 0; nColuna < this->nQtdColunas;
				nColuna++) {

					tipoColunaAtual = sqlite3_column_type(stmt, nColuna);

					coluna.ordem = nColuna;
					coluna.tipo = this->vetorTipoColunas[nColuna];
					coluna.nome = this->vetorNomeColunas[nColuna];
					coluna.integerValor = -1;
					coluna.doubleValor = -1;
					coluna.stringValor = "";
					coluna.blobValor = NULL;
					coluna.nuloValor = false;

					if (tipoColunaAtual == SQLITE_NULL) {
						coluna.nuloValor = true;
					}
					else if (coluna.tipo == SQLITE_INTEGER) {
						coluna.integerValor =
							sqlite3_column_int64(stmt, nColuna);
					}
					else if (coluna.tipo == SQLITE_FLOAT) {
						coluna.doubleValor =
							sqlite3_column_double(stmt, nColuna);
					}
					else if (coluna.tipo == SQLITE_BLOB) {
						nQtdBytes = sqlite3_column_bytes(stmt, nColuna);

						if (nQtdBytes == 0)
							blobValor = NULL;
						else {
							blobValor = new TMemoryStream();
							blobValor->Position = 0;

							ponteiro = sqlite3_column_blob(stmt, nColuna);

							blobValor->WriteBuffer(ponteiro, nQtdBytes);
						}
						coluna.blobValor = blobValor;
					}
					else {
						coluna.stringValor =
							(char*)sqlite3_column_text(stmt, nColuna);
					}

					vetorColunas->push_back(coluna);
				}

				matrizResultados->push_back(vetorColunas);

			} break;
		case SQLITE_BUSY: {
				ex << "Não consegui preparar o SQL: " << sSQL <<
					", SQLite está Ocupado";
				throw std::logic_error(ex.str().c_str());
			}
		default: {
				sqlite3_reset(stmt);
				DB->RaiseError("Não consegui recuperar dados", sSQL);
			}
		}
		nResultadoPasso = sqlite3_step(stmt);
	}
	this->nLinhaAtual = 0;

	if (stmt != NULL) {
		sqlite3_finalize(stmt);
	}
}

// ------------------------------------------------------------------------------
TSQLiteTable::~TSQLiteTable() {
	TTipoColuna tipo;

	if (this->matrizResultados != NULL) {
		for (unsigned int nLinha = 0; nLinha < this->nQtdLinhas; nLinha++) {
			for (unsigned int nColuna = 0; nColuna < this->nQtdColunas;
			nColuna++) {
				tipo = this->matrizResultados->at(nLinha)->at(nColuna).tipo;

				if (tipo == SQLITE_BLOB) {
					this->matrizResultados->at(nLinha)->at(nColuna)
						.blobValor->Free();
				}
			}
		}

		for (unsigned int nLinha = 0; nLinha < this->nQtdLinhas; nLinha++) {
			this->matrizResultados->at(nLinha)->clear();
			delete this->matrizResultados->at(nLinha);
		}
		this->matrizResultados->clear();
		delete this->matrizResultados;
	}
	if (this->vetorNomeColunas != NULL) {
		delete[]this->vetorNomeColunas;
	}
	if (this->vetorTipoColunas != NULL) {
		delete[]this->vetorTipoColunas;
	}
}

// ---------------------------------------------------------------------------
std::string TSQLiteTable::Columns(int i) {
	return this->vetorNomeColunas[i];
}

// ---------------------------------------------------------------------------
unsigned int TSQLiteTable::Count() {
	return this->nQtdLinhas;
}

// ---------------------------------------------------------------------------
unsigned int TSQLiteTable::ColCount() {
	return this->nQtdColunas;
}

// ---------------------------------------------------------------------------
unsigned int TSQLiteTable::Row() {
	return this->nLinhaAtual;
}

// ---------------------------------------------------------------------------
bool TSQLiteTable::Next() {
	if (!getEOF()) {
		this->nLinhaAtual++;
		return true;
	}
	return false;
}

// ---------------------------------------------------------------------------
bool TSQLiteTable::Previous() {
	if (!getBOF()) {
		this->nLinhaAtual--;
		return true;
	}
	return false;
}

// ---------------------------------------------------------------------------
bool TSQLiteTable::MoveFirst() {
	if (this->nQtdLinhas > 0) {
		this->nLinhaAtual = 0;
		return true;
	}
	return false;
}

// ---------------------------------------------------------------------------
bool TSQLiteTable::MoveLast() {
	if (this->Count() > 0) {
		this->nLinhaAtual = this->nQtdLinhas - 1;
		return true;
	}
	return false;
}

// ---------------------------------------------------------------------------
bool TSQLiteTable::MoveTo(unsigned int posicao) {
	if ((this->nQtdLinhas > 0) && (this->nQtdLinhas > posicao)) {
		this->nLinhaAtual = posicao;
		return true;
	}
	return false;
}

// ---------------------------------------------------------------------------
bool TSQLiteTable::getEOF() {
	return (this->nLinhaAtual >= this->nQtdLinhas);
}

// ---------------------------------------------------------------------------
bool TSQLiteTable::getBOF() {
	return (this->nLinhaAtual <= 0);
}

// ---------------------------------------------------------------------------
std::string TSQLiteTable::FieldByName(std::string sNomeCampo) {
	return Fields(this->FieldIndex(sNomeCampo));
}

// ---------------------------------------------------------------------------
int TSQLiteTable::FieldIndex(std::string sNomeCampo) {
	std::stringstream ex;
	int resultado = -1;
	std::string sNomeColuna;

	if (this->vetorNomeColunas == NULL) {
		ex << "Campo " << sNomeCampo <<
			" Não encontrado. Conjunto de dados Vazio";
		throw std::logic_error(ex.str().c_str());
	}

	if (this->nQtdColunas == 0) {
		ex << "Campo " << sNomeCampo <<
			" Não encontrado. Conjunto de dados Vazio";
		throw std::logic_error(ex.str().c_str());
	}

	for (unsigned int i = 0; i < this->nQtdColunas; i++) {
		sNomeColuna = this->vetorNomeColunas[i];
		if (cppUpperCase(sNomeColuna) == cppUpperCase(sNomeCampo)) {
			resultado = i;
			break;
		}
	}

	if (resultado < 0) {
		ex << "Campo " << sNomeCampo << " Não encontrado no Conjunto de dados";
		throw std::logic_error(ex.str().c_str());
	}

	return resultado;
}

// ---------------------------------------------------------------------------
std::string TSQLiteTable::Fields(unsigned int i) {
	std::stringstream ex;
	std::string retorno;
	TTipoColuna tipo;
	TSQLiteColuna coluna;

	retorno = "";
	if (getEOF()) {
		throw std::logic_error("Tabela está no fim do arquivo");
	}

	if (this->nQtdColunas > 0) {
		tipo = this->vetorTipoColunas[i];

		switch (tipo) {
		case SQLITE_TEXT: {
				coluna = this->matrizResultados->at(this->nLinhaAtual)->at(i);
				retorno = coluna.stringValor;
			} break;
		case SQLITE_INTEGER: {
				ex << this->FieldAsInteger(i);
				retorno = ex.str();
			} break;
		case SQLITE_FLOAT: {
				ex << this->FieldAsDouble(i);
				retorno = ex.str();
			} break;
		case SQLITE_BLOB:
			retorno = this->FieldAsBlobText(i);
			break;
		default:
			retorno = "";
		}
	}

	return retorno;
}

// ---------------------------------------------------------------------------
TMemoryStream* TSQLiteTable::FieldAsBlob(unsigned int i) {
	TTipoColuna tipo;
	TSQLiteColuna coluna;
	TMemoryStream *retorno;

	retorno = NULL;

	if (getEOF()) {
		throw std::logic_error("Tabela está no fim do arquivo");
	}
	if (this->nQtdColunas > 0) {
		tipo = this->vetorTipoColunas[i];

		if (tipo == SQLITE_BLOB) {
			coluna = this->matrizResultados->at(this->nLinhaAtual)->at(i);

			if (coluna.blobValor != NULL) {
				retorno = coluna.blobValor;
			}
		}
	}
	return retorno;
}

// ---------------------------------------------------------------------------
std::string TSQLiteTable::FieldAsBlobText(unsigned int i) {
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
			resultado = new std::string(Buffer, MemStream->Size);
			delete Buffer;
		}
		MemStream->Free();
	}
	return (*resultado);
}

// ---------------------------------------------------------------------------
__int64 TSQLiteTable::FieldAsInteger(unsigned int i) {
	TTipoColuna tipo;
	TSQLiteColuna coluna;
	__int64 retorno;

	retorno = -1;

	if (getEOF()) {
		throw std::logic_error("Tabela está no fim do arquivo");
	}
	if (this->nQtdColunas > 0) {
		tipo = this->vetorTipoColunas[i];

		if (tipo == SQLITE_INTEGER) {
			coluna = this->matrizResultados->at(this->nLinhaAtual)->at(i);
			retorno = coluna.integerValor;
		}
	}
	return retorno;
}

// ---------------------------------------------------------------------------
double TSQLiteTable::FieldAsDouble(unsigned int i) {
	TTipoColuna tipo;
	TSQLiteColuna coluna;
	double retorno;

	retorno = -1;

	if (getEOF()) {
		throw std::logic_error("Tabela está no fim do arquivo");
	}
	if (this->nQtdColunas > 0) {
		tipo = this->vetorTipoColunas[i];

		if (tipo == SQLITE_FLOAT) {
			coluna = this->matrizResultados->at(this->nLinhaAtual)->at(i);
			retorno = coluna.doubleValor;
		}
	}
	return retorno;
}

// ---------------------------------------------------------------------------
std::string TSQLiteTable::FieldAsString(unsigned int i) {
	TTipoColuna tipo;
	TSQLiteColuna coluna;
	std::string retorno;

	retorno = "";

	if (getEOF()) {
		throw std::logic_error("Tabela está no fim do arquivo");
	}
	if (this->nQtdColunas > 0) {
		tipo = this->vetorTipoColunas[i];

		if (tipo == SQLITE_TEXT) {
			coluna = this->matrizResultados->at(this->nLinhaAtual)->at(i);
			retorno = coluna.stringValor;
		}
	}
	return retorno;
}

// ---------------------------------------------------------------------------
bool TSQLiteTable::FieldIsNull(unsigned int i) {
	TTipoColuna tipo;
	TSQLiteColuna coluna;
	bool retorno;

	retorno = false;

	if (getEOF()) {
		throw std::logic_error("Tabela está no fim do arquivo");
	}
	if (this->nQtdColunas > 0) {
		tipo = this->vetorTipoColunas[i];

		if (tipo == SQLITE_NULL) {
			coluna = this->matrizResultados->at(this->nLinhaAtual)->at(i);
			retorno = coluna.nuloValor;
		}
	}
	return retorno;
}

// ---------------------------------------------------------------------------
int TSQLiteTable::CountResult() {
	if (!getEOF())
		return cppStrToInt(Fields(0));
	else
		return 0;

}
// ---------------------------------------------------------------------------

