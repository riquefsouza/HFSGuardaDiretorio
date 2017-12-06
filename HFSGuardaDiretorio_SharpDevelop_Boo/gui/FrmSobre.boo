/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 10:59
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.gui

import System
import System.Drawing
import System.Windows.Forms

partial public class FrmSobre(Form):

	public def constructor():
		//
		// The InitializeComponent() call is required for Windows Forms designer support.
		//
		InitializeComponent()
		
		//
		// TODO: Add constructor code after the InitializeComponent() call.
		//

	
	private def BtnOkClick(sender as object, e as EventArgs):
		self.Close()

