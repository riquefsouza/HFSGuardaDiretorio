# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:42
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Data.SQLite, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing.Imaging, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.comum
	# <summary>
	# Description of Rotinas.
	# </summary>
	class Rotinas
		def initialize()
			@HFSGUARDADIR = "HFSGuardaDir"
			@BARRA_NORMAL = "\\"
			@BARRA_INVERTIDA = "/"
			@FORMATO_DATA = "dd/MM/yyyy"
			@FORMATO_DATAHORA = "dd/MM/yyyy HH:mm:ss"
			@FORMATO_DHARQUIVO = "yyy-MM-dd_HH_mm_ss"
			@EXTENSAO_BMP = "bmp"
			@EXTENSAO_ICO = "ico"
			@EXTENSAO_GIF = "gif"
			@EXTENSAO_JPEG = "jpg"
			@EXTENSAO_PNG = "png"
			@EXTENSAO_TIFF = "tif"
		end

		def Rotinas.LastDelimiter(subtexto, texto)
			return texto.LastIndexOf(subtexto) + 1
		end

		def Rotinas.LastDelimiter(subtexto, texto)
			return texto.LastIndexOf(subtexto) + 1
		end

		def Rotinas.Pos(subtexto, texto)
			return texto.IndexOf(subtexto) + 1
		end

		def Rotinas.Pos(subtexto, texto)
			return texto.IndexOf(subtexto) + 1
		end

		def Rotinas.StartsStr(subtexto, texto)
			return texto.StartsWith(subtexto)
		end

		def Rotinas.ContainsStr(texto, subtexto)
			return (Rotinas.Pos(subtexto, texto) > 0)
		end

		def Rotinas.EndsStr(subtexto, texto)
			return (Rotinas.LastDelimiter(subtexto, texto) > 0)
		end

		def Rotinas.SubString(texto, inicio, tamanho)
			if tamanho > (texto.Length - inicio) then
				tamanho = texto.Length - inicio + 1
			end
			return texto.Substring(inicio - 1, tamanho)
		end

		def Rotinas.StringReplaceAll(texto, velho, novo)
			return texto.Replace(velho, novo)
		end

		def Rotinas.QuotedStr(texto)
			return "'" + texto + "'"
		end

		def Rotinas.QuotedStr(texto)
			return "'" + texto + "'"
		end

		def Rotinas.ExtractFilePath(sCaminho)
			fileInfo = FileInfo.new(sCaminho)
			retorno = fileInfo.DirectoryName
			return retorno
		end

		def Rotinas.ExtractFileName(sCaminho)
			fileInfo = FileInfo.new(sCaminho)
			retorno = fileInfo.Name
			return retorno
		end

		def Rotinas.FileExists(sNomeArquivo)
			fileInfo = FileInfo.new(sNomeArquivo)
			return fileInfo.Exists
		end

		def Rotinas.DirectoryExists(sNomeArquivo)
			dirInfo = DirectoryInfo.new(sNomeArquivo)
			return dirInfo.Exists
		end

		def Rotinas.DeleteFile(sNomeArquivo)
			fileInfo = FileInfo.new(sNomeArquivo)
			fileInfo.Delete()
		end

		def Rotinas.SaveToFile(imagem, sNomeArquivo)
			fileStream = nil
			begin
				fileStream = FileStream.new(sNomeArquivo, FileMode.OpenOrCreate, FileAccess.Write)
				fileStream.Write(imagem, 0, imagem.Length)
				fileStream.Flush()
			rescue FileNotFoundException => ioEx
				Console.WriteLine(ioEx.Message)
			ensure
				if fileStream != nil then
					fileStream.Close()
				end
			end
		end

		def Rotinas.LoadFromFile(sNomeArquivo)
			imagem = nil
			fileStream = nil
			begin
				fileStream = FileStream.new(sNomeArquivo, FileMode.Open, FileAccess.Read)
				imagem = Array.CreateInstance(System::Byte, fileStream.Length)
				numBytesToRead = fileStream.Length
				numBytesRead = 0
				while numBytesToRead > 0
					n = fileStream.Read(imagem, numBytesRead, numBytesToRead)
					if n == 0 then
						break
					end
					numBytesRead += n
					numBytesToRead -= n
				end
			rescue FileNotFoundException => ioEx
				Console.WriteLine(ioEx.Message)
			ensure
				if fileStream != nil then
					fileStream.Close()
				end
			end
			return imagem
		end

		def Rotinas.formataDate(formato, dt)
			ds = ""
			if dt != nil then
				ds = dt.ToString(formato)
			end
			return ds
		end

		def Rotinas.StringToDate(sData)
			data = DateTime.Now
			if sData.Trim().Length > 0 then
				begin
					if sData.Trim().Length == 10 then
						data = DateTime.ParseExact(sData, @FORMATO_DATA, System.Globalization.CultureInfo.InvariantCulture)
					else
						data = DateTime.ParseExact(sData, @FORMATO_DATAHORA, System.Globalization.CultureInfo.InvariantCulture)
					end
				rescue Exception => ex
					Console.WriteLine("Erro na rotina StringToDate: " + ex.Message)
				ensure
				end
			end
			return data
		end

		def Rotinas.FormatLong(formato, valor)
			return valor.ToString(formato)
		end

		def Rotinas.FormatDecimal(valor)
			return valor.ToString("#,##0.00")
		end

		def Rotinas.testaNull(res)
			return (res == nil ? "" : res.Trim())
		end

		def Rotinas.getConexao()
			return @db
		end

		def Rotinas.Conectar(cp)
			begin
				@db = SQLiteConnection.new("Data Source=" + cp.Nome + ";Version=3;")
				@db.Open()
			rescue Exception => ex
				Console.WriteLine(ex.Message)
			ensure
			end
		end

		def Rotinas.Desconectar()
			Rotinas.Desconectar(@db)
		end

		def Rotinas.Desconectar(con)
			if con != nil then
				con.Close()
			end
		end

		def Rotinas.trocaSeparador(texto)
			res = ""
			if texto != nil and texto.Length > 0 then
				pedacos = texto.ToCharArray()
				i = 0
				while i < pedacos.Length
					if pedacos[i] == @BARRA_NORMAL[0] then
						pedacos[i] = @BARRA_INVERTIDA[0]
					end
					i += 1
				end
				res = System.String.new(pedacos)
			end
			return res
		end

		def Rotinas.imageToByteArray(imageIn, formato)
			ms = MemoryStream.new()
			imageIn.Save(ms, formato)
			return ms.ToArray()
		end

		def Rotinas.byteArrayToImage(byteArrayIn)
			ms = MemoryStream.new(byteArrayIn)
			returnImage = Image.FromStream(ms)
			return returnImage
		end

		def Rotinas.LerArquivoImagem(sCaminho, bCaminhoPadrao)
			if bCaminhoPadrao then
				sCaminho = Rotinas.ExtractFilePath(Rotinas.ExecutablePath()) + Path.DirectorySeparatorChar + "imagens" + Path.DirectorySeparatorChar + sCaminho
			end
			imagebytes = nil
			fs = FileStream.new(sCaminho, FileMode.Open, FileAccess.Read)
			br = BinaryReader.new(fs)
			imagebytes = br.ReadBytes(1000000)
			#imagebytes.GetLength(0)
			return imagebytes
		end

		def Rotinas.byteArrayToBitmap(byteArrayIn)
			ms = MemoryStream.new(byteArrayIn)
			bmp = Bitmap.new(ms)
			return bmp
		end

		def Rotinas.bitmapToByteArray(bmp)
			ms = MemoryStream.new()
			bmp.Save(ms, ImageFormat.Bmp)
			return ms.ToArray()
		end

		def Rotinas.GetEncoder(format)
			codecs = ImageCodecInfo.GetImageDecoders()
			enumerator = codecs.GetEnumerator()
			while enumerator.MoveNext()
				codec = enumerator.Current
				if codec.FormatID == format.Guid then
					return codec
				end
			end
			return nil
		end

		def Rotinas.SaveJpeg(img, filePath, quality)
			encoderParameters = EncoderParameters.new(1)
			encoderParameters.Param[0] = EncoderParameter.new(Encoder.Quality, quality)
			img.Save(filePath, Rotinas.GetEncoder(ImageFormat.Jpeg), encoderParameters)
		end

		def Rotinas.SaveJpeg(img, stream, quality)
			encoderParameters = EncoderParameters.new(1)
			encoderParameters.Param[0] = EncoderParameter.new(Encoder.Quality, quality)
			img.Save(stream, Rotinas.GetEncoder(ImageFormat.Jpeg), encoderParameters)
		end

		def Rotinas.BmpParaImagem(imagemBMP, formato)
			imagemSaida = nil
			encoderParameters = EncoderParameters.new(1)
			encoderParameters.Param[0] = EncoderParameter.new(Encoder.Quality, 100L)
			ms = MemoryStream.new()
			img = Rotinas.byteArrayToImage(imagemBMP)
			if formato.Equals(@EXTENSAO_BMP) then
				img.Save(ms, Rotinas.GetEncoder(ImageFormat.Bmp), encoderParameters)
			elsif formato.Equals(@EXTENSAO_JPEG) then
				img.Save(ms, Rotinas.GetEncoder(ImageFormat.Jpeg), encoderParameters)
			elsif formato.Equals(@EXTENSAO_ICO) then
				img.Save(ms, Rotinas.GetEncoder(ImageFormat.Icon), encoderParameters)
			elsif formato.Equals(@EXTENSAO_GIF) then
				img.Save(ms, Rotinas.GetEncoder(ImageFormat.Gif), encoderParameters)
			elsif formato.Equals(@EXTENSAO_PNG) then
				img.Save(ms, Rotinas.GetEncoder(ImageFormat.Png), encoderParameters)
			elsif formato.Equals(@EXTENSAO_TIFF) then
				img.Save(ms, Rotinas.GetEncoder(ImageFormat.Tiff), encoderParameters)
			end
			imagemSaida = ms.ToArray()
			return imagemSaida
		end

		def Rotinas.listFiles(sCaminho)
			lista = List[FileInfo].new()
			enumerator = Directory.GetDirectories(sCaminho).GetEnumerator()
			while enumerator.MoveNext()
				dir = enumerator.Current
				lista.Add(FileInfo.new(dir))
			end
			enumerator = Directory.GetFiles(sCaminho).GetEnumerator()
			while enumerator.MoveNext()
				arq = enumerator.Current
				lista.Add(FileInfo.new(arq))
			end
			return lista
		end

		def Rotinas.ExecutablePath()
			#return System.IO.Path.GetDirectoryName(Environment.GetCommandLineArgs()[0]);
			return Environment.GetCommandLineArgs()[0]
		end

		def Rotinas.calculaProgresso(nMaximo, nProgresso)
			nMaximo += 1
			nProgresso += 1
			valor = nProgresso / nMaximo
			if valor >= 0 and valor <= 1 then
				return valor
			else
				return 0
			end
		end

		def Rotinas.byteArrayToPixbuf(byteArrayIn)
			pxb = Gdk.Pixbuf.new(byteArrayIn)
			return pxb
		end

		def Rotinas.LerArquivoPixbuf(sCaminho)
			sCaminho = Rotinas.ExtractFilePath(Rotinas.ExecutablePath()) + Path.DirectorySeparatorChar + "imagens" + Path.DirectorySeparatorChar + sCaminho
			pxb = Gdk.Pixbuf.new(sCaminho)
			return pxb
		end
	end
end