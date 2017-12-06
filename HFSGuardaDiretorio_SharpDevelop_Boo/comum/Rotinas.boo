/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 10/12/2014
 * Time: 17:42
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.comum

import System
import System.IO
import System.Data.SQLite
import System.Drawing
import System.Drawing.Imaging
import System.Collections.Generic
import HFSGuardaDiretorio.objetos

public class Rotinas:

	private static db as SQLiteConnection

	
	public static final HFSGUARDADIR = 'HFSGuardaDir'

	
	public static final BARRA_NORMAL = '\\'

	
	public static final BARRA_INVERTIDA = '/'

	
	public static final FORMATO_DATA = 'dd/MM/yyyy'

	
	public static final FORMATO_DATAHORA = 'dd/MM/yyyy HH:mm:ss'

	
	public static final FORMATO_DHARQUIVO = 'yyy-MM-dd_HH_mm_ss'

	
	public static EXTENSAO_BMP = 'bmp'

	
	public static EXTENSAO_ICO = 'ico'

	
	public static EXTENSAO_GIF = 'gif'

	
	public static EXTENSAO_JPEG = 'jpg'

	
	public static EXTENSAO_PNG = 'png'

	
	public static EXTENSAO_TIFF = 'tif'

	
	public static FILTRO_TODOS = 'Todos os Arquivos (*.*)|*.*'

	
	public static FILTRO_EXPORTAR = 'Arquivo TXT (*.txt)|*.txt|Arquivo CSV (*.csv)|*.csv|Arquivo HTML (*.html)|*.html|Arquivo XML (*.xml)|*.xml|Arquivo SQL (*.sql)|*.sql'

	
	public static FILTRO_IMAGEM = 'Arquivo BMP (*.bmp)|*.bmp|Arquivo ICO (*.ico)|*.ico|Arquivo GIF (*.gif)|*.gif|Arquivo JPEG (*.png)|*.png|Arquivo PNG (*.jpg)|*.jpg|Arquivo TIFF (*.tif)|*.tif'

	
	public static def LastDelimiter(subtexto as string, texto as string) as int:
		return (texto.LastIndexOf(subtexto) + 1)

	
	public static def LastDelimiter(subtexto as char, texto as string) as int:
		return (texto.LastIndexOf(subtexto) + 1)

	
	public static def Pos(subtexto as string, texto as string) as int:
		return (texto.IndexOf(subtexto) + 1)

	
	public static def Pos(subtexto as char, texto as string) as int:
		return (texto.IndexOf(subtexto) + 1)

	
	public static def StartsStr(subtexto as string, texto as string) as bool:
		return texto.StartsWith(subtexto)

	
	public static def ContainsStr(texto as string, subtexto as string) as bool:
		return (Pos(subtexto, texto) > 0)

	
	public static def EndsStr(subtexto as string, texto as string) as bool:
		return (LastDelimiter(subtexto, texto) > 0)

	
	public static def SubString(texto as string, inicio as int, tamanho as int) as string:
		if tamanho > (texto.Length - inicio):
			tamanho = ((texto.Length - inicio) + 1)
		return texto.Substring((inicio - 1), tamanho)

	
	public static def StringReplaceAll(texto as string, velho as string, novo as string) as string:
		return texto.Replace(velho, novo)

	
	public static def QuotedStr(texto as string) as string:
		return (('\'' + texto) + '\'')

	
	public static def QuotedStr(texto as char) as string:
		return (('\'' + texto) + '\'')

	
	public static def ExtractFilePath(sCaminho as string) as string:
		retorno as string
		
		fileInfo = FileInfo(sCaminho)
		retorno = fileInfo.DirectoryName
		
		return retorno

	
	public static def ExtractFileName(sCaminho as string) as string:
		retorno as string
		
		fileInfo = FileInfo(sCaminho)
		retorno = fileInfo.Name
		
		return retorno

	
	public static def FileExists(sNomeArquivo as string) as bool:
		fileInfo = FileInfo(sNomeArquivo)
		return fileInfo.Exists

	
	public static def DirectoryExists(sNomeArquivo as string) as bool:
		dirInfo = DirectoryInfo(sNomeArquivo)
		return dirInfo.Exists

	
	public static def DeleteFile(sNomeArquivo as string):
		fileInfo = FileInfo(sNomeArquivo)
		fileInfo.Delete()

	
	public static def SaveToFile(imagem as (byte), sNomeArquivo as string):
		fileStream as FileStream = null
		try:
			fileStream = FileStream(sNomeArquivo, FileMode.OpenOrCreate, FileAccess.Write)
			fileStream.Write(imagem, 0, imagem.Length)
			fileStream.Flush()
		except ioEx as FileNotFoundException:
			Console.WriteLine(ioEx.Message)
		ensure:
			if fileStream is not null:
				fileStream.Close()

	
	public static def LoadFromFile(sNomeArquivo as string) as (byte):
		imagem as (byte) = null
		fileStream as FileStream = null
		
		try:
			fileStream = FileStream(sNomeArquivo, FileMode.Open, FileAccess.Read)
			
			imagem = array(byte, fileStream.Length)
			numBytesToRead = (fileStream.Length cast int)
			numBytesRead = 0
			while numBytesToRead > 0:
				n as int = fileStream.Read(imagem, numBytesRead, numBytesToRead)
				if n == 0:
					break 
				numBytesRead += n
				numBytesToRead -= n
		
		except ioEx as FileNotFoundException:
			Console.WriteLine(ioEx.Message)
		ensure:
			if fileStream is not null:
				fileStream.Close()
		
		return imagem

	
	public static def formataDate(formato as string, dt as DateTime) as string:
		ds = ''				
		
		//if dt != null:
		ds = dt.ToString(formato)
		return ds

	
	public static def StringToDate(sData as string) as DateTime:
		data as DateTime = DateTime.Now
		
		if sData.Trim().Length > 0:
			try:
				if sData.Trim().Length == 10:
					data = DateTime.ParseExact(sData, FORMATO_DATA, System.Globalization.CultureInfo.InvariantCulture)
				else:
					data = DateTime.ParseExact(sData, FORMATO_DATAHORA, System.Globalization.CultureInfo.InvariantCulture)
			
			except ex as Exception:
				Console.WriteLine(('Erro na rotina StringToDate: ' + ex.Message))
		return data

	
	public static def FormatLong(formato as string, valor as long) as string:
		return valor.ToString(formato)

	
	public static def FormatDecimal(valor as decimal) as string:
		return valor.ToString('#,##0.00')

	
	public static def testaNull(res as string) as string:
		return ('' if (res is null) else res.Trim())

	
	public static def getConexao() as SQLiteConnection:
		return db

	
	public static def Conectar(cp as ConexaoParams):
		try:
			db = SQLiteConnection((('Data Source=' + cp.Nome) + ';Version=3;'))
			db.Open()
		
		except ex as Exception:
			Console.WriteLine(ex.Message)

	
	public static def Desconectar():
		Desconectar(db)

	
	public static def Desconectar(con as SQLiteConnection):
		if con is not null:
			con.Close()

	
	public static def trocaSeparador(texto as string) as string:
		res = ''
		if (texto is not null) and (texto.Length > 0):
			pedacos as (char) = texto.ToCharArray()
			for i in range(0, pedacos.Length):
				if pedacos[i] == BARRA_NORMAL[0]:
					pedacos[i] = BARRA_INVERTIDA[0]
			res = string(pedacos)
		return res

	
	public static def imageToByteArray(imageIn as Image, formato as ImageFormat) as (byte):
		ms = MemoryStream()
		imageIn.Save(ms, formato)
		return ms.ToArray()

	
	public static def byteArrayToImage(byteArrayIn as (byte)) as Image:
		ms = MemoryStream(byteArrayIn)
		returnImage as Image = Image.FromStream(ms)
		return returnImage

	
	public static def LerArquivoImagem(sCaminho as string) as (byte):
		imagebytes as (byte) = null
		fs = FileStream(sCaminho, FileMode.Open, FileAccess.Read)
		br = BinaryReader(fs)
		imagebytes = br.ReadBytes(1000000)
		
		//imagebytes.GetLength(0)
		
		return imagebytes

	
	public static def byteArrayToBitmap(byteArrayIn as (byte)) as Bitmap:
		ms = MemoryStream(byteArrayIn)
		bmp = Bitmap(ms)
		return bmp

	
	public static def bitmapToByteArray(bmp as Bitmap) as (byte):
		ms = MemoryStream()
		bmp.Save(ms, ImageFormat.Bmp)
		return ms.ToArray()

	
	
	private static def GetEncoder(format as ImageFormat) as ImageCodecInfo:
		codecs as (ImageCodecInfo) = ImageCodecInfo.GetImageDecoders()
		
		for codec as ImageCodecInfo in codecs:
			if codec.FormatID == format.Guid:
				return codec
		
		return null

	
	public static def SaveJpeg(img as Image, filePath as string, quality as long):
		encoderParameters = EncoderParameters(1)
		encoderParameters.Param[0] = EncoderParameter(Encoder.Quality, quality)
		img.Save(filePath, GetEncoder(ImageFormat.Jpeg), encoderParameters)

	
	public static def SaveJpeg(img as Image, stream as Stream, quality as long):
		encoderParameters = EncoderParameters(1)
		encoderParameters.Param[0] = EncoderParameter(Encoder.Quality, quality)
		img.Save(stream, GetEncoder(ImageFormat.Jpeg), encoderParameters)

	
	public static def BmpParaImagem(imagemBMP as (byte), formato as String) as (byte):
		
		imagemSaida as (byte) = null
		
		encoderParameters = EncoderParameters(1)
		encoderParameters.Param[0] = EncoderParameter(Encoder.Quality, 100L)
		
		ms = MemoryStream()
		img as Image = byteArrayToImage(imagemBMP)
		
		if formato.Equals(EXTENSAO_BMP):
			img.Save(ms, GetEncoder(ImageFormat.Bmp), encoderParameters)
		elif formato.Equals(EXTENSAO_JPEG):
			img.Save(ms, GetEncoder(ImageFormat.Jpeg), encoderParameters)
		elif formato.Equals(EXTENSAO_ICO):
			img.Save(ms, GetEncoder(ImageFormat.Icon), encoderParameters)
		elif formato.Equals(EXTENSAO_GIF):
			img.Save(ms, GetEncoder(ImageFormat.Gif), encoderParameters)
		elif formato.Equals(EXTENSAO_PNG):
			img.Save(ms, GetEncoder(ImageFormat.Png), encoderParameters)
		elif formato.Equals(EXTENSAO_TIFF):
			img.Save(ms, GetEncoder(ImageFormat.Tiff), encoderParameters)
		
		imagemSaida = ms.ToArray()
		
		return imagemSaida

	public static def listFiles(sCaminho as string) as List[of FileInfo]:
		lista as List[of FileInfo] = List[of FileInfo]()
		for dir as string in Directory.GetDirectories(sCaminho):
			lista.Add(FileInfo(dir))
		for arq as string in Directory.GetFiles(sCaminho):
			lista.Add(FileInfo(arq))
		return lista
	

