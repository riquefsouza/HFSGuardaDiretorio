/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 10/12/2014
 * Time: 17:39
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio

import System
import System.Windows.Forms
import HFSGuardaDiretorio.gui
import HFSGuardaDiretorio.catalogador

[STAThread]
public def Main(argv as (string)) as void:
	Catalogador.iniciarSistema()
	//Rotinas.iniciarLogArquivo(log);
	Application.EnableVisualStyles()
	Application.SetCompatibleTextRenderingDefault(false)
	Application.Run(FrmPrincipal())

