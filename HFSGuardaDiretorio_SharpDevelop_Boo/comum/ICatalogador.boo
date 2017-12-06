/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 14:54
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.comum

import System
import HFSGuardaDiretorio.objetos

public interface ICatalogador:

	def getAbaSelecionada() as Aba

	def DuploCliqueLista(nome as string, tipo as string)

	def EncontrarItemLista(nomeAba as string, nome as string, caminho as string)

