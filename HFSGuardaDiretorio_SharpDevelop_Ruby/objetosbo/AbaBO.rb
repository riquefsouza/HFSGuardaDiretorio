# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 14:53
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosdao, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosbo
	# <summary>
	# Description of AbaBO.
	# </summary>
	class AbaBO
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = AbaBO.new()
		end

		def carregarAba(progressoLog)
			return AbaDAO.Instancia.consultarTudo(progressoLog)
		end

		def retMaxCodAba(listaLocal)
			nMaior = 0
			enumerator = listaLocal.GetEnumerator()
			while enumerator.MoveNext()
				aba = enumerator.Current
				if aba.Codigo > nMaior then
					nMaior = aba.Codigo
				end
			end
			return nMaior + 1
		end

		def abaToSQL(aba)
			return "insert into Abas(cod, nome) values(" + aba.Codigo + "," + Rotinas.QuotedStr(aba.Nome) + ")"
		end

		def incluirAba(aba)
			return (AbaDAO.Instancia.incluir(aba) > 0)
		end

		def alterarAba(aba)
			return (AbaDAO.Instancia.alterar(aba) > 0)
		end

		def excluirAba(aba)
			return (AbaDAO.Instancia.excluir(aba.Codigo) > 0)
		end

		def criarTabelaAbas()
			return (AbaDAO.Instancia.criarTabela() > 0)
		end

		def pegaAbaPorOrdem(lista, ordem)
			enumerator = lista.GetEnumerator()
			while enumerator.MoveNext()
				aba = enumerator.Current
				if aba.Ordem == ordem then
					return aba
				end
			end
			return nil
		end

		def getElemento(lista, codigo)
			enumerator = lista.GetEnumerator()
			while enumerator.MoveNext()
				elemento = enumerator.Current
				if elemento.Codigo == codigo then
					return elemento
				end
			end
			return nil
		end

		def pegaAbaPorNome(lista, nome)
			enumerator = lista.GetEnumerator()
			while enumerator.MoveNext()
				aba = enumerator.Current
				if aba.Nome.Equals(nome) then
					return aba
				end
			end
			return nil
		end
	end
end