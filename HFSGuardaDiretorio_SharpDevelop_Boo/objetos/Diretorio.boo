/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 10/12/2014
 * Time: 17:48
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetos

import System


public class Diretorio(Arquivo):

	private aba as Aba

	private codigo as int

	private ordem as int

	private codDirPai as int

	private tipo as Tipo

	private caminho as string

	private nomePai as string

	private caminhoPai as string

	private tamanhoFormatado as string

	private modificadoFormatado as string

	private caminhoOriginal as string

	
	public def constructor():
		self.aba = Aba()
		self.codigo = 0
		self.ordem = 0
		self.codDirPai = 0
		self.tipo = Tipo()
		self.caminho = ''
		self.nomePai = ''
		self.caminhoPai = ''
		self.tamanhoFormatado = ''
		self.modificadoFormatado = ''
		self.caminhoOriginal = ''

	
	public Aba as Aba:
		get:
			return aba
		set:
			aba = value

	
	public Codigo as int:
		get:
			return codigo
		set:
			codigo = value

	
	public Ordem as int:
		get:
			return ordem
		set:
			ordem = value

	
	public CodDirPai as int:
		get:
			return codDirPai
		set:
			codDirPai = value

	
	public Tipo as Tipo:
		get:
			return tipo
		set:
			tipo = value

	
	public Caminho as string:
		get:
			return caminho
		set:
			caminho = value

	
	public NomePai as string:
		get:
			return nomePai
		set:
			nomePai = value

	
	public CaminhoPai as string:
		get:
			return caminhoPai
		set:
			caminhoPai = value

	
	public TamanhoFormatado as string:
		get:
			return tamanhoFormatado
		set:
			tamanhoFormatado = value

	
	public ModificadoFormatado as string:
		get:
			return modificadoFormatado
		set:
			modificadoFormatado = value

	
	public CaminhoOriginal as string:
		get:
			return caminhoOriginal
		set:
			caminhoOriginal = value

