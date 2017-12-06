package hfsguardadiretorio.comum;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.gnome.gtk.ButtonsType;
import org.gnome.gtk.DataColumn;
import org.gnome.gtk.DataColumnString;
import org.gnome.gtk.ListStore;
import org.gnome.gtk.MessageDialog;
import org.gnome.gtk.MessageType;
import org.gnome.gtk.TreeIter;
import org.gnome.gtk.TreeStore;
import org.gnome.gtk.WindowPosition;

public class Rotinas
{
	private static Rotinas instancia;
	public Connection dbConexao;
	
		public DataColumnString lsTabelaComparaColuna0;
	public DataColumnString lsTabelaComparaColuna1;
	public DataColumnString lsTabelaComparaColuna2;
	public DataColumnString lsTabelaComparaColuna3;
	public DataColumnString lsTabelaComparaColuna4;
	public DataColumnString lsTabelaComparaColuna5;
	public DataColumnString lsTabelaExtensaoColuna0;
	public DataColumnString lsTabelaExtensaoColuna1;
	public DataColumnString lsTabelaFixaColuna0;
	public DataColumnString lsTabelaFixaColuna1;
	public DataColumnString lsTabelaFixaColuna2;
	public DataColumnString lsTabelaFixaColuna3;
	public DataColumnString lsTabelaFixaColuna4;
	public DataColumnString lsTabelaFixaColuna5;
	public DataColumnString lsTabelaInfoColuna0;
	public DataColumnString lsTabelaInfoColuna1;
	public DataColumnString lsTabelaPesquisaColuna0;
	public DataColumnString lsTabelaPesquisaColuna1;
	public DataColumnString lsTabelaPesquisaColuna2;
	public DataColumnString lsTabelaPesquisaColuna3;
	public DataColumnString lsTabelaPesquisaColuna4;
	public DataColumnString lsTabelaPesquisaColuna5;
	public DataColumnString lsTabelaPesquisaColuna6;
	public DataColumnString tsArvoreDiretorio1Coluna0;
	public DataColumnString tsArvoreDiretorio1Coluna1;
	public DataColumnString tsArvoreDiretorio2Coluna0;
	public DataColumnString tsArvoreDiretorio2Coluna1;
	public DataColumnString tsArvoreFixaColuna0;
	public DataColumnString tsArvoreFixaColuna1;

	
	private Rotinas()
	{
		
	}
	
	public static Rotinas getInstancia()
	{
		if (instancia == null)
		{
			instancia = new Rotinas();
		}
		return instancia;
	}
	
	public void MsgDlg(String sMensagem, MessageType tipo)
	{
		MessageDialog dialog = new MessageDialog(null, 
					true, tipo, ButtonsType.OK, sMensagem);
		dialog.setPosition(WindowPosition.CENTER_ALWAYS);
		dialog.run();
		dialog.destroy();
	}
	
	public void ConectaBanco(String sDriver, String sUrl, String sLogin, String sSenha) 
			throws ClassNotFoundException, SQLException {
		Class.forName(sDriver);
		dbConexao = DriverManager.getConnection(sUrl, sLogin, sSenha);
	}
	
	public void DisconectaBanco() throws SQLException {
		dbConexao.close();
	}
	
	public int AtualizaDados(String sTextoSql) throws SQLException {
		PreparedStatement pstmt;
		int nTemLinhas = -1;

		pstmt = dbConexao.prepareStatement(sTextoSql);
		nTemLinhas = pstmt.executeUpdate();
		pstmt.close();
		
		return nTemLinhas;
	}
	
	public int ConsultaDados(String sTextoSql) throws SQLException {
		PreparedStatement pstmt;
		int nResultado = -1;

		pstmt = dbConexao.prepareStatement(sTextoSql);
		ResultSet res = pstmt.executeQuery();
		if (res.next()) {
			nResultado = res.getInt(1);
		}
		pstmt.close();

		return nResultado;
	}
	
		public ListStore lsTabelaCompara(){
        DataColumn[] dadosColuna = new DataColumn[] {
        	lsTabelaComparaColuna0 = new DataColumnString(), 
			lsTabelaComparaColuna1 = new DataColumnString(), 
			lsTabelaComparaColuna2 = new DataColumnString(), 
			lsTabelaComparaColuna3 = new DataColumnString(), 
			lsTabelaComparaColuna4 = new DataColumnString(), 
			lsTabelaComparaColuna5 = new DataColumnString()
        };
                        
		ListStore lsTabelaCompara = new ListStore(dadosColuna);
		TreeIter iter = lsTabelaCompara.appendRow();
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna0, "Nome");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna1, "tamanho");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna2, "tipo");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna3, "Modificado");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna4, "Atributos");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna5, "Caminho");

		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna0, "Nome2");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna1, "tamanho2");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna2, "tipo2");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna3, "Modificado2");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna4, "Atributos2");
		lsTabelaCompara.setValue(iter, lsTabelaComparaColuna5, "Caminho2");


		
		return lsTabelaCompara;
	}
	
	public ListStore lsTabelaExtensao(){
        DataColumn[] dadosColuna = new DataColumn[] {
        	lsTabelaExtensaoColuna0 = new DataColumnString(), 
			lsTabelaExtensaoColuna1 = new DataColumnString()
        };
                        
		ListStore lsTabelaExtensao = new ListStore(dadosColuna);
		TreeIter iter = lsTabelaExtensao.appendRow();
		lsTabelaExtensao.setValue(iter, lsTabelaExtensaoColuna0, "Extensao1");
		lsTabelaExtensao.setValue(iter, lsTabelaExtensaoColuna1, "Icone1");

		lsTabelaExtensao.setValue(iter, lsTabelaExtensaoColuna0, "Extensao2");
		lsTabelaExtensao.setValue(iter, lsTabelaExtensaoColuna1, "Icone2");


		
		return lsTabelaExtensao;
	}
	
	public ListStore lsTabelaFixa(){
        DataColumn[] dadosColuna = new DataColumn[] {
        	lsTabelaFixaColuna0 = new DataColumnString(), 
			lsTabelaFixaColuna1 = new DataColumnString(), 
			lsTabelaFixaColuna2 = new DataColumnString(), 
			lsTabelaFixaColuna3 = new DataColumnString(), 
			lsTabelaFixaColuna4 = new DataColumnString(), 
			lsTabelaFixaColuna5 = new DataColumnString()
        };
                        
		ListStore lsTabelaFixa = new ListStore(dadosColuna);
		TreeIter iter = lsTabelaFixa.appendRow();
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna0, "Nome");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna1, "tamanho");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna2, "tipo");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna3, "Modificado");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna4, "Atributos");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna5, "Caminho");

		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna0, "Nome2");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna1, "tamanho2");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna2, "tipo2");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna3, "Modificado2");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna4, "Atributos2");
		lsTabelaFixa.setValue(iter, lsTabelaFixaColuna5, "Caminho2");


		
		return lsTabelaFixa;
	}
	
	public ListStore lsTabelaInfo(){
        DataColumn[] dadosColuna = new DataColumn[] {
        	lsTabelaInfoColuna0 = new DataColumnString(), 
			lsTabelaInfoColuna1 = new DataColumnString()
        };
                        
		ListStore lsTabelaInfo = new ListStore(dadosColuna);
		TreeIter iter = lsTabelaInfo.appendRow();
		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna0, "Aba:");
		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna1, "Descricao1");

		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna0, "Nome:");
		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna1, "Descricao2");

		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna0, "Tamanho:");
		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna1, "Descricao3");

		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna0, "Tipo:");
		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna1, "Descricao4");

		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna0, "Modificado:");
		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna1, "Descricao5");

		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna0, "Atributos:");
		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna1, "Descricao6");

		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna0, "Caminho:");
		lsTabelaInfo.setValue(iter, lsTabelaInfoColuna1, "Descricao7");


		
		return lsTabelaInfo;
	}
	
	public ListStore lsTabelaPesquisa(){
        DataColumn[] dadosColuna = new DataColumn[] {
        	lsTabelaPesquisaColuna0 = new DataColumnString(), 
			lsTabelaPesquisaColuna1 = new DataColumnString(), 
			lsTabelaPesquisaColuna2 = new DataColumnString(), 
			lsTabelaPesquisaColuna3 = new DataColumnString(), 
			lsTabelaPesquisaColuna4 = new DataColumnString(), 
			lsTabelaPesquisaColuna5 = new DataColumnString(), 
			lsTabelaPesquisaColuna6 = new DataColumnString()
        };
                        
		ListStore lsTabelaPesquisa = new ListStore(dadosColuna);
		TreeIter iter = lsTabelaPesquisa.appendRow();
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna0, "Nome");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna1, "tamanho");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna2, "tipo");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna3, "Modificado");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna4, "Atributos");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna5, "Caminho");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna6, "Aba");

		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna0, "Nome2");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna1, "tamanho2");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna2, "tipo2");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna3, "Modificado2");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna4, "Atributos2");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna5, "Caminho2");
		lsTabelaPesquisa.setValue(iter, lsTabelaPesquisaColuna6, "Aba2");


		
		return lsTabelaPesquisa;
	}
	
	public TreeStore tsArvoreDiretorio1(){
        DataColumn[] dadosColuna = new DataColumn[] {
        	tsArvoreDiretorio1Coluna0 = new DataColumnString(), 
			tsArvoreDiretorio1Coluna1 = new DataColumnString()
        };
                        
		TreeStore tsArvoreDiretorio1 = new TreeStore(dadosColuna);
		TreeIter iter = tsArvoreDiretorio1.appendRow();
		
		
		return tsArvoreDiretorio1;
	}
	
	public TreeStore tsArvoreDiretorio2(){
        DataColumn[] dadosColuna = new DataColumn[] {
        	tsArvoreDiretorio2Coluna0 = new DataColumnString(), 
			tsArvoreDiretorio2Coluna1 = new DataColumnString()
        };
                        
		TreeStore tsArvoreDiretorio2 = new TreeStore(dadosColuna);
		TreeIter iter = tsArvoreDiretorio2.appendRow();
		
		
		return tsArvoreDiretorio2;
	}
	
	public TreeStore tsArvoreFixa(){
        DataColumn[] dadosColuna = new DataColumn[] {
        	tsArvoreFixaColuna0 = new DataColumnString(), 
			tsArvoreFixaColuna1 = new DataColumnString()
        };
                        
		TreeStore tsArvoreFixa = new TreeStore(dadosColuna);
		TreeIter iter = tsArvoreFixa.appendRow();
		
		
		return tsArvoreFixa;
	}
	

}
