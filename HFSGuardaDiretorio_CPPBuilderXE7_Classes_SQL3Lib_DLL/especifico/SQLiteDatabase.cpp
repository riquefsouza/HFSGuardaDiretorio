//---------------------------------------------------------------------------

#pragma hdrstop

#include "SQLiteDatabase.h"
#include "SQLiteTable.h"
#include "SQLiteUniTable.h"
#include "Funcoes.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
// ---------------------------------------------------------------------------
void DisposePointer(void *ponteiro) {
	if (ponteiro != NULL) {
		sqlite3_free(ponteiro);
		ponteiro = NULL;
	}
}
// ---------------------------------------------------------------------------
#ifdef WIN32

int SystemCollate(void *UserData, int Buf1Len, const void *Buf1, int Buf2Len,
	const void *Buf2) {
	return CompareStringW(LOCALE_USER_DEFAULT, 0, (LPCWSTR) Buf1, Buf1Len,
		(LPCWSTR) Buf2, Buf2Len) - 2;
}
#endif

// ---------------------------------------------------------------------------
TSQLiteDatabase::TSQLiteDatabase(const std::string sBanco) {
	std::stringstream ex;
	int resultado;
	const char *msgErro = NULL;

	this->bEmTransacao = false;
	this->listaParametros = new std::vector<TSQLiteParametro>();
	this->OnQuery = NULL;

	resultado = sqlite3_open(sBanco.c_str(), &dbHandle);

	if (resultado != SQLITE_OK) {
		if (dbHandle != NULL) {
			msgErro = sqlite3_errmsg(dbHandle);
			ex << "Falha ao abrir banco de dados '" << sBanco << "':" <<
				msgErro;
			throw std::logic_error(ex.str().c_str());
		}
		else {
			ex << "Falha ao abrir banco de dados '" << sBanco <<
				"': erro desconhecido";
			throw std::logic_error(ex.str().c_str());
		}
	}

	if (msgErro != NULL) {
		sqlite3_free((void*)msgErro);
	}

}

// ---------------------------------------------------------------------------
TSQLiteDatabase::~TSQLiteDatabase() {
	if (bEmTransacao) {
		this->Rollback(); // assume rollback
	}
	if (dbHandle != NULL) {
		sqlite3_close(dbHandle);
	}
	ParamsClear();
	delete this->listaParametros;
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::BeginTransaction() {
	if (!bEmTransacao) {
		this->ExecSQL("BEGIN TRANSACTION");
		this->bEmTransacao = true;
	}
	else
		throw std::logic_error("Transa��o j� aberta");
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::Commit() {
	this->ExecSQL("COMMIT");
	this->bEmTransacao = false;
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::Rollback() {
	this->ExecSQL("ROLLBACK");
	this->bEmTransacao = false;
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::AddParamInt(std::string nome, __int64 valor) {
	TSQLiteParametro parametro;

	parametro.nome = nome;
	parametro.tipo = SQLITE_INTEGER;
	parametro.integerValor = valor;
	parametro.nuloValor = false;
	this->listaParametros->push_back(parametro);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::AddParamFloat(std::string nome, double valor) {
	TSQLiteParametro parametro;

	parametro.nome = nome;
	parametro.tipo = SQLITE_FLOAT;
	parametro.doubleValor = valor;
	parametro.nuloValor = false;
	this->listaParametros->push_back(parametro);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::AddParamText(std::string nome, std::string valor) {
	TSQLiteParametro parametro;

	parametro.nome = nome;
	parametro.tipo = SQLITE_TEXT;
	parametro.stringValor = valor;
	parametro.nuloValor = false;
	this->listaParametros->push_back(parametro);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::AddParamNull(std::string nome) {
	TSQLiteParametro parametro;

	parametro.nome = nome;
	parametro.tipo = SQLITE_NULL;
	parametro.nuloValor = true;
	this->listaParametros->push_back(parametro);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::SetParams(sqlite3_stmt *stmt) {
	TSQLiteParametro parametro;

	if (!this->listaParametros->empty()) {
		for (unsigned int i = 0; i < this->listaParametros->size(); i++) {
			parametro = this->listaParametros->at(i);

			i = sqlite3_bind_parameter_index(stmt, parametro.nome.c_str());
			if (i > 0) {
				switch (parametro.tipo) {
				case SQLITE_INTEGER:
					sqlite3_bind_int64(stmt, i, parametro.integerValor);
					break;
				case SQLITE_FLOAT:
					sqlite3_bind_double(stmt, i, parametro.doubleValor);
					break;
				case SQLITE_TEXT:
					sqlite3_bind_text(stmt, i, parametro.stringValor.c_str(),
						parametro.stringValor.length(), SQLITE_TRANSIENT);
					break;
				case SQLITE_NULL:
					sqlite3_bind_null(stmt, i);
					break;
				case SQLITE_BLOB: {
						// sqlite3_bind_blob(stmt, i, , );
					}
				}
			}
		}
	}

	ParamsClear();
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::ParamsClear() {
	this->listaParametros->clear();
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::ExecSQL(const std::string sSQL) {
	ExecSQL(sSQL, NULL);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::ExecSQL(const std::string sSQL,
	const TSQLiteParametro bindings[]) {
	sqlite3_stmt *stmt;
	const char *NextSQLStatement;
	int nResultadoPasso;

	if (sqlite3_prepare_v2(dbHandle, sSQL.c_str(), -1, &stmt,
		&NextSQLStatement) != SQLITE_OK) {
		RaiseError("Erro executando SQL", sSQL);
	}

	if (stmt == NULL) {
		RaiseError("N�o consegui preparar o SQL", sSQL);
	}

	DoQuery(sSQL);
	SetParams(stmt);
	if (bindings != NULL) {
		BindData(stmt, bindings);
	}

	nResultadoPasso = sqlite3_step(stmt);

	if (nResultadoPasso != SQLITE_DONE) {
		sqlite3_reset(stmt);
		RaiseError("Erro executando o procedimento do SQL", sSQL);
	}

	if (stmt != NULL) {
		sqlite3_finalize(stmt);
	}
}

// ---------------------------------------------------------------------------
TSQLiteTable* TSQLiteDatabase::GetTable(const std::string sSQL) {
	return new TSQLiteTable(this, sSQL);
}

// ---------------------------------------------------------------------------
TSQLiteTable* TSQLiteDatabase::GetTable(const std::string sSQL,
	const TSQLiteParametro bindings[]) {
	return new TSQLiteTable(this, sSQL, bindings);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::UpdateBlob(const std::string sSQL, TStream *BlobData) {
	std::stringstream ex;
	int nTamanho;
	const char *msgErro = NULL;
	sqlite3_stmt *stmt;
	const char *NextSQLStatement;
	int nResultadoPasso;
	int nResultadoBind;
	void *ponteiro;

	// expects SQL of the form "UPDATE MYTABLE SET MYFIELD = ? WHERE MYKEY = 1"
	if (cppPos("?", sSQL) == 0) {
		RaiseError("O SQL deve conter um par�metro de interroga��o", sSQL);
	}

	if (sqlite3_prepare_v2(dbHandle, sSQL.c_str(), -1, &stmt,
		&NextSQLStatement) != SQLITE_OK) {
		RaiseError("N�o consegui preparar o SQL", sSQL);
	}

	if (stmt == NULL) {
		RaiseError("N�o consegui preparar o SQL", sSQL);
	}

	DoQuery(sSQL);

	// now bind the blob data
	nTamanho = BlobData->Size;

	ponteiro = GetMemory(nTamanho);

	if (ponteiro == NULL) {
		ex << "Erro ao alocar mem�ria para salvar o BLOB: " << sSQL;
		throw std::logic_error(ex.str().c_str());
	}

	BlobData->Position = 0;
	BlobData->Read(&ponteiro, nTamanho);

	nResultadoBind = sqlite3_bind_blob(stmt, 1, ponteiro, nTamanho,
		*DisposePointer);

	if (nResultadoBind != SQLITE_OK) {
		RaiseError("Erro ao ligar(binding) BLOB para o banco de dados: ", sSQL);
	}

	nResultadoPasso = sqlite3_step(stmt);

	if (nResultadoPasso != SQLITE_DONE) {
		sqlite3_reset(stmt);
		RaiseError("Erro executando procedimento SQL: ", sSQL);
	}

	if (stmt != NULL) {
		sqlite3_finalize(stmt);
	}

	if (msgErro != NULL) {
		sqlite3_free((void*)msgErro);
	}
}

// ---------------------------------------------------------------------------
int TSQLiteDatabase::RowsChanged() {
	return sqlite3_changes(this->dbHandle);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::RaiseError(std::string sMensagem, std::string sSQL) {
	std::stringstream ex;
	const char *msgErro = NULL;
	int retorno;

	retorno = sqlite3_errcode(this->dbHandle);
	if (retorno != SQLITE_OK) {
		msgErro = sqlite3_errmsg(this->dbHandle);
	}
	if (msgErro != NULL) {
		ex << sMensagem << ". Erro [" << retorno << "]: " << SQLiteErrorStr
			(retorno) << ". '" << sSQL << "': " << msgErro;
		throw std::logic_error(ex.str().c_str());
	}
	else {
		ex << sMensagem << ". '" << sSQL << "': Sem mensagem";
		throw std::logic_error(ex.str().c_str());
	}
}

// ---------------------------------------------------------------------------
std::string TSQLiteDatabase::SQLiteErrorStr(int nSQLiteErrorCode) {
	std::stringstream ex;

	switch (nSQLiteErrorCode) {
	case SQLITE_OK:
		return "Successful result";
	case SQLITE_ERROR:
		return "SQL error or missing database";
	case SQLITE_INTERNAL:
		return "An internal logic error in SQLite";
	case SQLITE_PERM:
		return "Access permission denied";
	case SQLITE_ABORT:
		return "Callback routine requested an abort";
	case SQLITE_BUSY:
		return "The database file is locked";
	case SQLITE_LOCKED:
		return "A table in the database is locked";
	case SQLITE_NOMEM:
		return "A malloc() failed";
	case SQLITE_READONLY:
		return "Attempt to write a readonly database";
	case SQLITE_INTERRUPT:
		return "Operation terminated by sqlite3_interrupt()";
	case SQLITE_IOERR:
		return "Some kind of disk I/O error occurred";
	case SQLITE_CORRUPT:
		return "The database disk image is malformed";
	case SQLITE_NOTFOUND:
		return "(Internal Only) Table or record not found";
	case SQLITE_FULL:
		return "Insertion failed because database is full";
	case SQLITE_CANTOPEN:
		return "Unable to open the database file";
	case SQLITE_PROTOCOL:
		return "Database lock protocol error";
	case SQLITE_EMPTY:
		return "Database is empty";
	case SQLITE_SCHEMA:
		return "The database schema changed";
	case SQLITE_TOOBIG:
		return "Too much data for one row of a table";
	case SQLITE_CONSTRAINT:
		return "Abort due to contraint violation";
	case SQLITE_MISMATCH:
		return "Data type mismatch";
	case SQLITE_MISUSE:
		return "Library used incorrectly";
	case SQLITE_NOLFS:
		return "Uses OS features not supported on host";
	case SQLITE_AUTH:
		return "Authorization denied";
	case SQLITE_FORMAT:
		return "Auxiliary database format error";
	case SQLITE_RANGE:
		return "2nd parameter to sqlite3_bind out of range";
	case SQLITE_NOTADB:
		return "File opened that is not a database file";
	case SQLITE_ROW:
		return "sqlite3_step() has another row ready";
	case SQLITE_DONE:
		return "sqlite3_step() has finished executing";
	default: {
			ex << "Unknown SQLite Error Code '" << nSQLiteErrorCode << "'";
			return ex.str();
		}
	}
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::BindData(sqlite3_stmt *stmt,
	const TSQLiteParametro bindings[]) {
	std::stringstream ex;
	TStream *BlobData;
	void *ponteiro;
	int nTamanho;
	unsigned int nTamParams = sizeof(*bindings) / sizeof(bindings[0]);

	for (unsigned int i = 0; i < nTamParams; i++) {
		switch (bindings[i].tipo) {
		case SQLITE_INTEGER: {
				if (sqlite3_bind_int64(stmt, i + 1, bindings[i].integerValor)
					!= SQLITE_OK)
					RaiseError("N�o consegui fazer bind de int64", "BindData");
			} break;
		case SQLITE_FLOAT: {
				if (sqlite3_bind_double(stmt, i + 1, bindings[i].doubleValor)
					!= SQLITE_OK)
					RaiseError("N�o consegui fazer bind de float", "BindData");
			} break;
		case SQLITE_TEXT: {
				if (sqlite3_bind_text(stmt, i + 1,
					bindings[i].stringValor.c_str(),
					bindings[i].stringValor.length(),
					SQLITE_STATIC) != SQLITE_OK)
					RaiseError("N�o consegui fazer bind de texto", "BindData");
			} break;
		case SQLITE_BLOB: {
				BlobData = (TStream*)bindings[i].blobValor;

				nTamanho = BlobData->Size;
				ponteiro = GetMemory(nTamanho);

				if (ponteiro == NULL) {
					throw std::logic_error
						("Erro ao alocar mem�ria para salvar o BLOB: ");
				}

				BlobData->Position = 0;
				BlobData->Read(&ponteiro, nTamanho);

				if (sqlite3_bind_blob(stmt, i + 1, ponteiro, nTamanho,
					*DisposePointer) != SQLITE_OK)
					RaiseError("N�o consegui fazer bind de BLOB", "BindData");
			}
		case SQLITE_NULL: {
				if (bindings[i].nuloValor) {
					if (sqlite3_bind_null(stmt, i + 1) != SQLITE_OK)
						RaiseError("N�o consegui fazer bind de NULL",
					"BindData");
				}
			}
		}
	}

}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::DoQuery(std::string sSQL) {
	if (this->OnQuery != NULL) {
		this->OnQuery(sSQL);
	}
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::ExecSQL(TSQLiteQuery query) {
	int nResultadoPasso;

	if (query.stmt != NULL) {
		nResultadoPasso = sqlite3_step(query.stmt);

		if (nResultadoPasso != SQLITE_DONE) {
			sqlite3_reset(query.stmt);
			RaiseError("Error executing prepared SQL statement", query.sSQL);
		}
		sqlite3_reset(query.stmt);
	}
}

// ---------------------------------------------------------------------------
TSQLiteQuery TSQLiteDatabase::PrepareSQL(const std::string sSQL) {
	sqlite3_stmt *stmt;
	const char *NextSQLStatement;
	TSQLiteQuery resultado;

	resultado.sSQL = sSQL;
	resultado.stmt = NULL;

	if (sqlite3_prepare(dbHandle, sSQL.c_str(), -1, &stmt, &NextSQLStatement)
		!= SQLITE_OK)
		RaiseError("N�o consegui preparar o SQL", sSQL);
	else
		resultado.stmt = stmt;

	if (resultado.stmt == NULL)
		RaiseError("N�o consegui preparar o SQL", sSQL);

	DoQuery(sSQL);

	return resultado;
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::BindSQL(TSQLiteQuery query, const int Index,
	const int Value) {
	if (query.stmt != NULL)
		sqlite3_bind_int(query.stmt, Index, Value);
	else
		RaiseError(
		"N�o consegui fazer o bind de int para preparar o procedimento SQL",
		query.sSQL);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::BindSQL(TSQLiteQuery query, const int Index,
	const std::string Value) {
	if (query.stmt != NULL)
		sqlite3_bind_text(query.stmt, Index, Value.c_str(), Value.length(),
		SQLITE_STATIC);
	else
		RaiseError(
		"N�o consegui fazer o bind de String para preparar o procedimento SQL",
		query.sSQL);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::ReleaseSQL(TSQLiteQuery query) {
	if (query.stmt != NULL) {
		sqlite3_finalize(query.stmt);
		query.stmt = NULL;
	}
	else
		RaiseError("N�o consegui liberar o procedimento SQL", query.sSQL);
}

// ---------------------------------------------------------------------------
TSQLiteUniTable* TSQLiteDatabase::GetUniTable(const std::string sSQL) {
	return new TSQLiteUniTable(this, sSQL);
}

// ---------------------------------------------------------------------------
TSQLiteUniTable* TSQLiteDatabase::GetUniTable(const std::string sSQL,
	const TSQLiteParametro bindings[]) {
	return new TSQLiteUniTable(this, sSQL, bindings);
}

// ---------------------------------------------------------------------------
__int64 TSQLiteDatabase::GetTableValue(const std::string sSQL) {
	return GetTableValue(sSQL, NULL);
}

// ---------------------------------------------------------------------------
__int64 TSQLiteDatabase::GetTableValue(const std::string sSQL,
	const TSQLiteParametro bindings[]) {
	__int64 resultado = 0;
	TSQLiteUniTable *tabela;

	tabela = this->GetUniTable(sSQL, bindings);

	if (!tabela->getEOF()) {
		resultado = tabela->FieldAsInteger(0);
	}

	delete tabela;

	return resultado;
}

// ---------------------------------------------------------------------------
std::string TSQLiteDatabase::GetTableString(const std::string sSQL) {
	return this->GetTableString(sSQL, NULL);
}

// ---------------------------------------------------------------------------
std::string TSQLiteDatabase::GetTableString(const std::string sSQL,
	const TSQLiteParametro bindings[]) {
	std::string resultado = "";
	TSQLiteUniTable *tabela;

	tabela = this->GetUniTable(sSQL, bindings);

	if (!tabela->getEOF()) {
		resultado = tabela->FieldAsString(0);
	}

	delete tabela;

	return resultado;
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::GetTableStringVetor(const std::string sSQL,
	std::vector<std::string> *Value) {
	TSQLiteUniTable *tabela;

	Value->clear();
	tabela = this->GetUniTable(sSQL);

	while (!tabela->getEOF()) {
		Value->push_back(tabela->FieldAsString(0));
		tabela->Next();
	}

	delete tabela;
}

// ---------------------------------------------------------------------------
bool TSQLiteDatabase::TableExists(std::string TableName) {
	std::string sSQL;
	TSQLiteTable *tabela;
	bool resultado = false;

	// returns true if (table exists in the database
	sSQL = "select [sql] from sqlite_master where [type] = 'table' and lower(name) = '"
		+ cppLowerCase(TableName) + "' ";
	tabela = this->GetTable(sSQL);
	resultado = (tabela->Count() > 0);

	delete tabela;

	return resultado;
}

// ---------------------------------------------------------------------------
__int64 TSQLiteDatabase::GetLastInsertRowID() {
	return sqlite3_last_insert_rowid(dbHandle);
}

// ---------------------------------------------------------------------------
__int64 TSQLiteDatabase::GetLastChangedRows() {
	return sqlite3_total_changes(dbHandle);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::SetTimeout(int value) {
	sqlite3_busy_timeout(dbHandle, value);
}

// ---------------------------------------------------------------------------
int TSQLiteDatabase::Backup(TSQLiteDatabase *TargetDB) {
	return this->Backup(TargetDB, "main", "main");
}

// ---------------------------------------------------------------------------
int TSQLiteDatabase::Backup(TSQLiteDatabase *TargetDB, std::string targetName,
	std::string sourceName) {
	int retorno = -1;
	sqlite3_backup *pBackup;

	pBackup = sqlite3_backup_init(TargetDB->dbHandle, targetName.c_str(),
		this->dbHandle, sourceName.c_str());

	if (pBackup == NULL) {
		throw std::logic_error("N�o consegui inicializar o backup");
	}
	else {
		retorno = sqlite3_backup_step(pBackup, -1); // copies entire db
		sqlite3_backup_finish(pBackup);
	}
	return retorno;
}

// ---------------------------------------------------------------------------
std::string TSQLiteDatabase::Version() {
	return sqlite3_libversion();
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::AddCustomCollate(std::string name,
	TCollateXCompare xCompare) {
	sqlite3_create_collation(dbHandle, name.c_str(), SQLITE_UTF8, NULL,
		xCompare);
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::AddSystemCollate() {
#ifdef WIN32
	sqlite3_create_collation(dbHandle, "SYSTEM", SQLITE_UTF16LE, NULL,
		*SystemCollate);
#endif
}
// ---------------------------------------------------------------------------

bool TSQLiteDatabase::IsTransactionOpen() {
	return this->bEmTransacao;
}

// ---------------------------------------------------------------------------
bool TSQLiteDatabase::GetSynchronised() {
	return this->bSincronizado;
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::SetSynchronised(bool value) {
	if (value != this->bSincronizado) {
		if (value)
			this->ExecSQL("PRAGMA synchronous = ON;");
		else
			this->ExecSQL("PRAGMA synchronous = OFF;");
		this->bSincronizado = value;
	}
}

// ---------------------------------------------------------------------------
void TSQLiteDatabase::SetOnQuery(THookQuery* query) {
	this->OnQuery = query;
}
// ---------------------------------------------------------------------------

