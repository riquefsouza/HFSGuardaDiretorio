# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 10:55
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosbo
	# <summary>
	# Description of ImportarBO.
	# </summary>
	class ImportarBO
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = ImportarBO.new()
		end

		def CarregarListaDiretorios(importar, dirOrdem, listaDiretorio, progressoLog)
			pb = Progresso.new()
			arquivo = Arquivo.new()
			arquivo.Nome = importar.RotuloRaiz
			arquivo.Tamanho = 0
			arquivo.Modificado = DateTime.Now
			arquivo.Atributos = "[DIR]"
			diretorio = DiretorioBO.Instancia.atribuiDiretorio(importar.Aba, importar.CodDirRaiz, importar.NomeDirRaiz, "", true, listaDiretorio, arquivo, dirOrdem)
			listaDiretorio.Add(diretorio)
			pb.Log = importar.Caminho
			DiretorioBO.Instancia.ImportarDiretorio(importar.Aba, importar.CodDirRaiz, importar.NomeDirRaiz, importar.Caminho, listaDiretorio, dirOrdem, progressoLog)
			if progressoLog != nil then
				progressoLog.ProgressoLog(pb)
			end
		end

		def ImportacaoCompleta(importar, dirOrdem, listaExtensao, progressoLog)
			listaDiretorio = List[Diretorio].new()
			begin
				self.CarregarListaDiretorios(importar, dirOrdem, listaDiretorio, progressoLog)
				# 
				# //Por ser multiplataforma nao tem funcao para pegar icone de arquivo
				# ExtensaoBO.Instancia.salvarExtensoes(listaDiretorio,
				# listaExtensao, progressoLog);
				# 
				DiretorioBO.Instancia.salvarDiretorio(listaDiretorio, progressoLog)
				listaDiretorio.Clear()
			rescue Exception => 
				raise 
			ensure
			end
		end
	end
end