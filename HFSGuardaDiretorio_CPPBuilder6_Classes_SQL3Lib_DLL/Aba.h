// ---------------------------------------------------------------------------

#ifndef AbaH
#define AbaH
// ---------------------------------------------------------------------------
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <vector>
#include "Rotinas.h"
// ---------------------------------------------------------------------------
class TAba {
private: // User declarations
public : // User declarations
	int codigo;
	String nome;
	int ordem;

	TAba();
	void carregarAba(std::vector<TAba> *listaAba, TProgressoLog progressoLog);
	int retMaxCodAba(std::vector<TAba> *listaLocal);
	String abaToSQL(TAba aba);
	bool incluirAba(TAba aba);
	bool alterarAba(TAba aba);
	bool excluirAba(TAba aba);
	bool criarTabelaAbas();
	TAba pegaAbaPorOrdem(std::vector<TAba> *lista, int ordem);
};

// ---------------------------------------------------------------------------
extern PACKAGE TAba *Aba;
// ---------------------------------------------------------------------------
#endif
