# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 10:55
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Collections.Generic import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *

class ImportarBO(object):
	""" <summary>
	 Description of ImportarBO.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = ImportarBO()

	def CarregarListaDiretorios(self, importar, dirOrdem, listaDiretorio, progressoLog):
		pb = Progresso()
		arquivo = Arquivo()
		arquivo.Nome = importar.RotuloRaiz
		arquivo.Tamanho = 0
		arquivo.Modificado = DateTime.Now
		arquivo.Atributos = "[DIR]"
		diretorio = DiretorioBO.Instancia.atribuiDiretorio(importar.Aba, importar.CodDirRaiz, importar.NomeDirRaiz, "", True, listaDiretorio, arquivo, dirOrdem)
		listaDiretorio.Add(diretorio)
		pb.Log = importar.Caminho
		DiretorioBO.Instancia.ImportarDiretorio(importar.Aba, importar.CodDirRaiz, importar.NomeDirRaiz, importar.Caminho, listaDiretorio, dirOrdem, progressoLog)
		if progressoLog != None:
			progressoLog.ProgressoLog(pb)

	def ImportacaoCompleta(self, importar, dirOrdem, listaExtensao, progressoLog):
		listaDiretorio = List[Diretorio]()
		try:
			self.CarregarListaDiretorios(importar, dirOrdem, listaDiretorio, progressoLog)
			# 
			# //Por ser multiplataforma nao tem funcao para pegar icone de arquivo
			# ExtensaoBO.Instancia.salvarExtensoes(listaDiretorio,
			# listaExtensao, progressoLog);
			# 
			DiretorioBO.Instancia.salvarDiretorio(listaDiretorio, progressoLog)
			listaDiretorio.Clear()
		except Exception:
			raise 
				