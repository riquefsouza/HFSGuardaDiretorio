
module HFSGuardaDiretorio_objetos

	class ConexaoParams
		def initialize()
			@nome = ""
			@driver = ""
			@url = ""
			@login = ""
			@senha = ""
		end

		def Nome
			return @nome
		end

		def Nome=(value)
			@nome = value
		end

		def Driver
			return @driver
		end

		def Driver=(value)
			@driver = value
		end

		def Url
			return @url
		end

		def Url=(value)
			@url = value
		end

		def Login
			return @login
		end

		def Login=(value)
			@login = value
		end

		def Senha
			return @senha
		end

		def Senha=(value)
			@senha = value
		end
	end
end