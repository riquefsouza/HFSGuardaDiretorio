
from System.IO import *
from System.Data import *
from System.Data.SQLite import *
from System.Drawing import *
from System.Drawing.Imaging import *
from System.Collections.Generic import *

#from objetos import *

class Rotinas(object):
	""" <summary>
	 Description of Rotinas.
	 </summary>
	"""
	def __init__(self):
		""" <summary>
		 Description of Rotinas.
		 </summary>
		"""
		self._HFSGUARDADIR = "HFSGuardaDir"
		self._BARRA_NORMAL = "\\"
		self._BARRA_INVERTIDA = "/"
		self._FORMATO_DATA = "dd/MM/yyyy"
		self._FORMATO_DATAHORA = "dd/MM/yyyy HH:mm:ss"
		self._FORMATO_DHARQUIVO = "yyy-MM-dd_HH_mm_ss"
		self._EXTENSAO_BMP = "bmp"
		self._EXTENSAO_ICO = "ico"
		self._EXTENSAO_GIF = "gif"
		self._EXTENSAO_JPEG = "jpg"
		self._EXTENSAO_PNG = "png"
		self._EXTENSAO_TIFF = "tif"
		self._FILTRO_TODOS = "Todos os Arquivos (*.*)|*.*"
		self._FILTRO_EXPORTAR = "Arquivo TXT (*.txt)|*.txt|Arquivo CSV (*.csv)|*.csv|Arquivo HTML (*.html)|*.html|Arquivo XML (*.xml)|*.xml|Arquivo SQL (*.sql)|*.sql"
		self._FILTRO_IMAGEM = "Arquivo BMP (*.bmp)|*.bmp|Arquivo ICO (*.ico)|*.ico|Arquivo GIF (*.gif)|*.gif|Arquivo JPEG (*.png)|*.png|Arquivo PNG (*.jpg)|*.jpg|Arquivo TIFF (*.tif)|*.tif"

	def LastDelimiter(subtexto, texto):
		return texto.LastIndexOf(subtexto) + 1

	LastDelimiter = staticmethod(LastDelimiter)

	def LastDelimiter(subtexto, texto):
		return texto.LastIndexOf(subtexto) + 1

	LastDelimiter = staticmethod(LastDelimiter)

	def Pos(subtexto, texto):
		return texto.IndexOf(subtexto) + 1

	Pos = staticmethod(Pos)

	def Pos(subtexto, texto):
		return texto.IndexOf(subtexto) + 1

	Pos = staticmethod(Pos)

	def StartsStr(subtexto, texto):
		return texto.StartsWith(subtexto)

	StartsStr = staticmethod(StartsStr)

	def ContainsStr(texto, subtexto):
		return (Rotinas.Pos(subtexto, texto) > 0)

	ContainsStr = staticmethod(ContainsStr)

	def EndsStr(subtexto, texto):
		return (Rotinas.LastDelimiter(subtexto, texto) > 0)

	EndsStr = staticmethod(EndsStr)

	def SubString(texto, inicio, tamanho):
		if tamanho > (texto.Length - inicio):
			tamanho = texto.Length - inicio + 1
		return texto.Substring(inicio - 1, tamanho)

	SubString = staticmethod(SubString)

	def StringReplaceAll(texto, velho, novo):
		return texto.Replace(velho, novo)

	StringReplaceAll = staticmethod(StringReplaceAll)

	def QuotedStr(texto):
		return "'" + texto + "'"

	QuotedStr = staticmethod(QuotedStr)

	def QuotedStr(texto):
		return "'" + texto + "'"

	QuotedStr = staticmethod(QuotedStr)

	def ExtractFilePath(sCaminho):
		fileInfo = FileInfo(sCaminho)
		retorno = fileInfo.DirectoryName
		return retorno

	ExtractFilePath = staticmethod(ExtractFilePath)

	def ExtractFileName(sCaminho):
		fileInfo = FileInfo(sCaminho)
		retorno = fileInfo.Name
		return retorno

	ExtractFileName = staticmethod(ExtractFileName)

	def FileExists(sNomeArquivo):
		fileInfo = FileInfo(sNomeArquivo)
		return fileInfo.Exists

	FileExists = staticmethod(FileExists)

	def DirectoryExists(sNomeArquivo):
		dirInfo = DirectoryInfo(sNomeArquivo)
		return dirInfo.Exists

	DirectoryExists = staticmethod(DirectoryExists)

	def DeleteFile(sNomeArquivo):
		fileInfo = FileInfo(sNomeArquivo)
		fileInfo.Delete()

	DeleteFile = staticmethod(DeleteFile)

	def SaveToFile(imagem, sNomeArquivo):
		fileStream = None
		try:
			fileStream = FileStream(sNomeArquivo, FileMode.OpenOrCreate, FileAccess.Write)
			fileStream.Write(imagem, 0, imagem.Length)
			fileStream.Flush()
		except FileNotFoundException, ioEx:
			Console.WriteLine(ioEx.Message)
		finally:
			if fileStream != None:
				fileStream.Close()

	SaveToFile = staticmethod(SaveToFile)

	def LoadFromFile(sNomeArquivo):
		imagem = None
		fileStream = None
		try:
			fileStream = FileStream(sNomeArquivo, FileMode.Open, FileAccess.Read)
			imagem = Array.CreateInstance(Byte, fileStream.Length)
			numBytesToRead = fileStream.Length
			numBytesRead = 0
			while numBytesToRead > 0:
				n = fileStream.Read(imagem, numBytesRead, numBytesToRead)
				if n == 0:
					break
				numBytesRead += n
				numBytesToRead -= n
		except FileNotFoundException, ioEx:
			Console.WriteLine(ioEx.Message)
		finally:
			if fileStream != None:
				fileStream.Close()
		return imagem

	LoadFromFile = staticmethod(LoadFromFile)

	def formataDate(formato, dt):
		ds = ""
		if dt != None:
			ds = dt.ToString(formato)
		return ds

	formataDate = staticmethod(formataDate)

	def StringToDate(sData):
		data = DateTime.Now
		if sData.Trim().Length > 0:
			try:
				if sData.Trim().Length == 10:
					data = DateTime.ParseExact(sData, self._FORMATO_DATA, System.Globalization.CultureInfo.InvariantCulture)
				else:
					data = DateTime.ParseExact(sData, self._FORMATO_DATAHORA, System.Globalization.CultureInfo.InvariantCulture)
			except Exception, ex:
				Console.WriteLine("Erro na rotina StringToDate: " + ex.Message)
				
		return data

	StringToDate = staticmethod(StringToDate)

	def FormatLong(formato, valor):
		return valor.ToString(formato)

	FormatLong = staticmethod(FormatLong)

	def FormatDecimal(valor):
		return valor.ToString("#,##0.00")

	FormatDecimal = staticmethod(FormatDecimal)

	def testaNull(res):
		return ("" if res == None else res.Trim())

	testaNull = staticmethod(testaNull)

	def getConexao():
		return self._db

	getConexao = staticmethod(getConexao)

	def Conectar(cp):
		try:
			self._db = SQLiteConnection("Data Source=" + cp.Nome + ";Version=3;")
			self._db.Open()
		except Exception, ex:
			Console.WriteLine(ex.Message)

	Conectar = staticmethod(Conectar)

	def Desconectar():
		Rotinas.Desconectar(self._db)

	Desconectar = staticmethod(Desconectar)

	def Desconectar(con):
		if con != None:
			con.Close()

	Desconectar = staticmethod(Desconectar)

	def trocaSeparador(texto):
		res = ""
		if texto != None and texto.Length > 0:
			pedacos = texto.ToCharArray()
			i = 0
			while i < pedacos.Length:
				if pedacos[i] == self._BARRA_NORMAL[0]:
					pedacos[i] = self._BARRA_INVERTIDA[0]
				i += 1
			res = System.String(pedacos)
		return res

	trocaSeparador = staticmethod(trocaSeparador)

	def imageToByteArray(imageIn, formato):
		ms = MemoryStream()
		imageIn.Save(ms, formato)
		return ms.ToArray()

	imageToByteArray = staticmethod(imageToByteArray)

	def byteArrayToImage(byteArrayIn):
		ms = MemoryStream(byteArrayIn)
		returnImage = Image.FromStream(ms)
		return returnImage

	byteArrayToImage = staticmethod(byteArrayToImage)

	def LerArquivoImagem(sCaminho):
		imagebytes = None
		fs = FileStream(sCaminho, FileMode.Open, FileAccess.Read)
		br = BinaryReader(fs)
		imagebytes = br.ReadBytes(1000000)
		#imagebytes.GetLength(0)
		return imagebytes

	LerArquivoImagem = staticmethod(LerArquivoImagem)

	def byteArrayToBitmap(byteArrayIn):
		ms = MemoryStream(byteArrayIn)
		bmp = Bitmap(ms)
		return bmp

	byteArrayToBitmap = staticmethod(byteArrayToBitmap)

	def bitmapToByteArray(bmp):
		ms = MemoryStream()
		bmp.Save(ms, ImageFormat.Bmp)
		return ms.ToArray()

	bitmapToByteArray = staticmethod(bitmapToByteArray)

	def GetEncoder(format):
		codecs = ImageCodecInfo.GetImageDecoders()
		enumerator = codecs.GetEnumerator()
		while enumerator.MoveNext():
			codec = enumerator.Current
			if codec.FormatID == format.Guid:
				return codec
		return None

	GetEncoder = staticmethod(GetEncoder)

	def SaveJpeg(img, filePath, quality):
		encoderParameters = EncoderParameters(1)
		encoderParameters.Param[0] = EncoderParameter(Encoder.Quality, quality)
		img.Save(filePath, Rotinas.GetEncoder(ImageFormat.Jpeg), encoderParameters)

	SaveJpeg = staticmethod(SaveJpeg)

	def SaveJpeg(img, stream, quality):
		encoderParameters = EncoderParameters(1)
		encoderParameters.Param[0] = EncoderParameter(Encoder.Quality, quality)
		img.Save(stream, Rotinas.GetEncoder(ImageFormat.Jpeg), encoderParameters)

	SaveJpeg = staticmethod(SaveJpeg)

	def BmpParaImagem(imagemBMP, formato):
		imagemSaida = None
		encoderParameters = EncoderParameters(1)
		encoderParameters.Param[0] = EncoderParameter(Encoder.Quality, 100L)
		ms = MemoryStream()
		img = Rotinas.byteArrayToImage(imagemBMP)
		if formato.Equals(self._EXTENSAO_BMP):
			img.Save(ms, Rotinas.GetEncoder(ImageFormat.Bmp), encoderParameters)
		elif formato.Equals(self._EXTENSAO_JPEG):
			img.Save(ms, Rotinas.GetEncoder(ImageFormat.Jpeg), encoderParameters)
		elif formato.Equals(self._EXTENSAO_ICO):
			img.Save(ms, Rotinas.GetEncoder(ImageFormat.Icon), encoderParameters)
		elif formato.Equals(self._EXTENSAO_GIF):
			img.Save(ms, Rotinas.GetEncoder(ImageFormat.Gif), encoderParameters)
		elif formato.Equals(self._EXTENSAO_PNG):
			img.Save(ms, Rotinas.GetEncoder(ImageFormat.Png), encoderParameters)
		elif formato.Equals(self._EXTENSAO_TIFF):
			img.Save(ms, Rotinas.GetEncoder(ImageFormat.Tiff), encoderParameters)
		imagemSaida = ms.ToArray()
		return imagemSaida

	BmpParaImagem = staticmethod(BmpParaImagem)

	def listFiles(sCaminho):
		lista = List[FileInfo]()
		enumerator = Directory.GetDirectories(sCaminho).GetEnumerator()
		while enumerator.MoveNext():
			dir = enumerator.Current
			lista.Add(FileInfo(dir))
		enumerator = Directory.GetFiles(sCaminho).GetEnumerator()
		while enumerator.MoveNext():
			arq = enumerator.Current
			lista.Add(FileInfo(arq))
		return lista

	listFiles = staticmethod(listFiles)