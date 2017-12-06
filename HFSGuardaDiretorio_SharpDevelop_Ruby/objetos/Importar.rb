
module HFSGuardaDiretorio_objetos
	
	class Importar
		def initialize()
			@aba = 0
			@codDirRaiz = 0
			@rotuloRaiz = ""
			@nomeDirRaiz = ""
			@caminho = ""
		end

		def Aba
			return @aba
		end

		def Aba=(value)
			@aba = value
		end

		def CodDirRaiz
			return @codDirRaiz
		end

		def CodDirRaiz=(value)
			@codDirRaiz = value
		end

		def RotuloRaiz
			return @rotuloRaiz
		end

		def RotuloRaiz=(value)
			@rotuloRaiz = value
		end

		def NomeDirRaiz
			return @nomeDirRaiz
		end

		def NomeDirRaiz=(value)
			@nomeDirRaiz = value
		end

		def Caminho
			return @caminho
		end

		def Caminho=(value)
			@caminho = value
		end
	end
end