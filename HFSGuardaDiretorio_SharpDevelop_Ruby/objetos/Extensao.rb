
module HFSGuardaDiretorio_objetos

	class Extensao
		def initialize(codigo, nome, ordem, bmp16, bmp32)
			@codigo = codigo
			@nome = nome
			@ordem = ordem
			@bmp16 = bmp16
			@bmp32 = bmp32
		end

		def initialize(codigo, nome, ordem, bmp16, bmp32)
			@codigo = codigo
			@nome = nome
			@ordem = ordem
			@bmp16 = bmp16
			@bmp32 = bmp32
		end

		def Codigo
			return codigo
		end

		def Codigo=(value)
			codigo = value
		end

		def Nome
			return nome
		end

		def Nome=(value)
			nome = value
		end

		def Ordem
			return ordem
		end

		def Ordem=(value)
			ordem = value
		end

		def Bmp16
			return bmp16
		end

		def Bmp16=(value)
			bmp16 = value
		end

		def Bmp32
			return bmp32
		end

		def Bmp32=(value)
			bmp32 = value
		end
	end
end