package hfsguardadir.gui.controller;

import hfsguardadir.catalogador.Catalogador;
import hfsguardadir.comum.Rotinas;
import hfsguardadir.comum.StringList;
import static hfsguardadir.comum.TipoExportar.teCSV;
import static hfsguardadir.comum.TipoExportar.teHTML;
import static hfsguardadir.comum.TipoExportar.teSQL;
import static hfsguardadir.comum.TipoExportar.teTXT;
import static hfsguardadir.comum.TipoExportar.teXML;
import hfsguardadir.gui.FrmCadExtensao;
import hfsguardadir.gui.FrmCompararDiretorio;
import hfsguardadir.gui.FrmInfoDiretorio;
import hfsguardadir.gui.FrmPrincipalProgresso;
import hfsguardadir.gui.FrmSobre;
import hfsguardadir.objetos.Aba;
import hfsguardadir.objetos.Diretorio;
import hfsguardadir.objetosgui.Tabela;
import hfsguardadir.objetosgui.TextFieldChangeListener;
import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.CheckMenuItem;
import javafx.scene.control.ContextMenu;
import javafx.scene.control.Label;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuItem;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.RadioMenuItem;
import javafx.scene.control.SplitPane;
import javafx.scene.control.TabPane;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.input.ScrollEvent;

/**
 * FXML Controller class
 *
 * @author henrique.souza
 */
public class FrmPrincipalController implements Initializable {
    private FrmPrincipalProgresso frmPrincipalProgresso;
    private Catalogador catalogador;

    @FXML
    public Label barraStatus1;
    @FXML
    public Label barraStatus2;
    @FXML
    private Button btnImportarDiretorio;
    @FXML
    private Button btnPesquisa;
    @FXML
    public TextField edtPesquisa;
    @FXML
    public Menu menuAba;
    @FXML
    public Menu menuDiretorio;
    @FXML
    public Menu menuExportarDiretoriosAbaAtiva;
    @FXML
    public Menu menuVisao;
    @FXML
    public Menu menuIdioma;
    @FXML
    public Menu menuSobre;
    @FXML
    public Menu lafMenu;
    @FXML
    private RadioMenuItem menuAlemao;
    @FXML
    private MenuItem menuAlterarNomeAbaAtiva;
    @FXML
    private MenuItem menuAlterarNomeAbaAtiva2;
    @FXML
    private MenuItem menuCSV;
    @FXML
    private MenuItem menuCadastrarExtensaoArquivo;
    @FXML
    private RadioMenuItem menuChinesTradicional;
    @FXML
    private MenuItem menuColapsarDiretorios;
    @FXML
    private MenuItem menuColapsarDiretorios2;
    @FXML
    private MenuItem menuCompararDiretorios;
    @FXML
    private RadioMenuItem menuCoreano;
    @FXML
    private RadioMenuItem menuEspanhol;
    @FXML
    private MenuItem menuExcluirAbaAtiva;
    @FXML
    private MenuItem menuExcluirAbaAtiva2;
    @FXML
    private MenuItem menuExcluirDiretorioSelecionado;
    @FXML
    private MenuItem menuExpandirDiretorios;
    @FXML
    private MenuItem menuExpandirDiretorios2;
    @FXML
    private RadioMenuItem menuFrances;
    @FXML
    public CheckMenuItem menuGravarLogImportacao;
    @FXML
    private MenuItem menuHTML;
    @FXML
    private MenuItem menuImportarDiretorio;
    @FXML
    private MenuItem menuImportarDiretoriosViaXML;
    @FXML
    private MenuItem menuImportarSubDiretorios;
    @FXML
    private MenuItem menuIncluirNovaAba;
    @FXML
    private MenuItem menuIncluirNovaAba2;
    @FXML
    private MenuItem menuInformacoesDiretorioArquivo;
    @FXML
    private RadioMenuItem menuIngles;
    @FXML
    private RadioMenuItem menuItaliano;
    @FXML
    private RadioMenuItem menuJapones;
    @FXML
    private MenuItem menuMostrarOcultarArvoreDirAbaAtiva;
    @FXML
    private MenuItem menuMostrarOcultarListaItensPesquisados;
    @FXML
    public ContextMenu menuPopup;
    @FXML
    private RadioMenuItem menuPortugues;
    @FXML
    private MenuItem menuSQL;
    @FXML
    private MenuItem menuSobreCatalogador;
    @FXML
    private MenuItem menuTXT;
    @FXML
    private MenuItem menuXML;
    @FXML
    public ProgressBar pb;
    @FXML
    public SplitPane spPesquisa;
    @FXML
    public TabPane tabPanel;
    @FXML
    public TableView tabelaPesquisa;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        frmPrincipalProgresso = new FrmPrincipalProgresso(this);
        catalogador = new Catalogador(this);
        
        edtPesquisa.textProperty().addListener(
                new TextFieldChangeListener(edtPesquisa, 255));
        spPesquisa.setDividerPosition(0, 1); //0.5
    }

    @FXML
    private void menuAlemaoAction(ActionEvent event) {
        catalogador.mudarLingua("de");
    }

    @FXML
    private void menuAlterarNomeAbaAtivaAction(ActionEvent event) {
        try {
            catalogador.AlterarNomeAbaAtiva(frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }        
    }

    @FXML
    private void menuAlterarNomeAbaAtiva2Action(ActionEvent event) {
        menuAlterarNomeAbaAtivaAction(event);
    }

    @FXML
    private void menuCSVAction(ActionEvent event) {
        try {
            catalogador.ExportarArquivo(teCSV, frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }                
    }

    @FXML
    private void menuCadastrarExtensaoArquivoAction(ActionEvent event) {
        FrmCadExtensao.getInstancia().ShowModal();
    }

    @FXML
    private void menuChinesTradicionalAction(ActionEvent event) {
        catalogador.mudarLingua("zh");
    }

    @FXML
    private void menuColapsarDiretoriosAction(ActionEvent event) {
        catalogador.getArvoreAtual().expandeTodos(false);
    }

    @FXML
    private void menuColapsarDiretorios2Action(ActionEvent event) {
        menuColapsarDiretoriosAction(event);
    }

    @FXML
    private void menuCompararDiretoriosAction(ActionEvent event) {
        FrmCompararDiretorio.getInstancia().ShowModal();
    }

    @FXML
    private void menuCoreanoAction(ActionEvent event) {
        catalogador.mudarLingua("ko");
    }

    @FXML
    private void menuEspanholAction(ActionEvent event) {
        catalogador.mudarLingua("es");
    }

    @FXML
    private void menuExcluirAbaAtivaAction(ActionEvent event) {
        try {
            catalogador.ExcluirAbaAtiva(frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }        
    }

    @FXML
    private void menuExcluirAbaAtiva2Action(ActionEvent event) {
        menuExcluirAbaAtivaAction(event);
    }

    @FXML
    private void menuExcluirDiretorioSelecionadoAction(ActionEvent event) {
      try {
            catalogador.ExcluirDiretorioSelecionado(frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }        
    }

    @FXML
    private void menuExpandirDiretoriosAction(ActionEvent event) {
        catalogador.getArvoreAtual().expandeTodos(true);
    }

    @FXML
    private void menuExpandirDiretorios2Action(ActionEvent event) {
        menuExpandirDiretoriosAction(event);
    }

    @FXML
    private void menuFrancesAction(ActionEvent event) {
        catalogador.mudarLingua("fr");
    }

    @FXML
    public void menuGravarLogImportacaoAction(ActionEvent event) {
    }

    @FXML
    private void menuHTMLAction(ActionEvent event) {
        try {
            catalogador.ExportarArquivo(teHTML, frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }                
    }

    @FXML
    private void menuImportarDiretorioAction(ActionEvent event) {
        try {
            catalogador.ComecaImportacao(false, frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }
    }

    @FXML
    private void menuImportarDiretoriosViaXMLAction(ActionEvent event) {
        StringList log = new StringList();
        try {
            catalogador.ImportarArquivo(log, frmPrincipalProgresso);
        } catch (IOException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }        
    }

    @FXML
    private void menuImportarSubDiretoriosAction(ActionEvent event) {
        try {
            catalogador.ComecaImportacao(true, frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }        
    }

    @FXML
    private void menuIncluirNovaAbaAction(ActionEvent event) {
        try {
            catalogador.IncluirNovaAba();
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }
    }

    @FXML
    private void menuIncluirNovaAba2Action(ActionEvent event) {
        menuIncluirNovaAbaAction(event);
    }

    @FXML
    private void menuInformacoesDiretorioArquivoAction(ActionEvent event) {
        
        Tabela tabela = catalogador.getTabelaAtual();
        if (tabela.getSelectionModel().getSelectedIndex() >= 0) {
            Aba aba = catalogador.getAbaSelecionada();
            Diretorio dir = tabela.getLinhaSelecionada(false);
            dir.getAba().setNome(aba.getNome());
            FrmInfoDiretorio.getInstancia().getController().setDiretorio(dir);
            FrmInfoDiretorio.getInstancia().ShowModal();
        }        
    }

    @FXML
    private void menuInglesAction(ActionEvent event) {
        catalogador.mudarLingua("en");
    }

    @FXML
    private void menuItalianoAction(ActionEvent event) {
        catalogador.mudarLingua("it");
    }

    @FXML
    private void menuJaponesAction(ActionEvent event) {
        catalogador.mudarLingua("ja");
    }

    @FXML
    private void menuMostrarOcultarArvoreDirAbaAtivaAction(ActionEvent event) {
        catalogador.mostrarOcultarArvore();        
    }

    @FXML
    private void menuMostrarOcultarListaItensPesquisadosAction(ActionEvent event) {
        if (spPesquisa.getDividerPositions()[0]==1) {
            spPesquisa.setDividerPositions(0.5);
        } else {
            spPesquisa.setDividerPositions(1);
        }        
    }

    @FXML
    private void menuPortuguesAction(ActionEvent event) {
        catalogador.mudarLingua("pt");
    }

    @FXML
    private void menuSQLAction(ActionEvent event) {
        try {
            catalogador.ExportarArquivo(teSQL, frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }                
    }

    @FXML
    private void menuSobreCatalogadorAction(ActionEvent event) {
        FrmSobre.getInstancia().ShowModal();
    }

    @FXML
    private void menuTXTAction(ActionEvent event) {
        try {
            catalogador.ExportarArquivo(teTXT, frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }        
    }

    @FXML
    private void menuXMLAction(ActionEvent event) {
        try {
            catalogador.ExportarArquivo(teXML, frmPrincipalProgresso);
        } catch (SQLException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(FrmPrincipalController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }                
    }

    @FXML
    private void tabPanelScroll(ScrollEvent event) {
        if (catalogador != null) {
            catalogador.tabPanelMudou();
        }        
    }

    @FXML
    protected void btnImportarDiretorioAction(ActionEvent event) {
        menuImportarDiretorioAction(event);
    }

    @FXML
    protected void btnPesquisaAction(ActionEvent event) {
        catalogador.Pesquisar();
    }

    public void setIdiomaPadrao(String lingua) {
        switch (lingua) {
            case "pt":
                menuPortugues.setSelected(true);
                break;
            case "en":
                menuIngles.setSelected(true);
                break;
            case "es":
                menuEspanhol.setSelected(true);
                break;
            case "fr":
                menuFrances.setSelected(true);
                break;
            case "it":
                menuItaliano.setSelected(true);
                break;
            case "de":
                menuAlemao.setSelected(true);
                break;
            case "ja":
                menuJapones.setSelected(true);
                break;
            case "ko":
                menuCoreano.setSelected(true);
                break;
            case "zh":
                menuChinesTradicional.setSelected(true);
                break;
        }
    }

    public void mudarLingua() {        
        barraStatus1.setText(Rotinas.getRecurso("FrmPrincipal.barraStatus1"));
        btnImportarDiretorio.setText(
                Rotinas.getRecurso("FrmPrincipal.btnImportarDiretorio"));
        btnPesquisa.setText(Rotinas.getRecurso("FrmPrincipal.btnPesquisa"));
        menuAba.setText(Rotinas.getRecurso("FrmPrincipal.menuAba"));
        menuIncluirNovaAba.setText(Rotinas
                .getRecurso("FrmPrincipal.menuIncluirNovaAba"));
        menuAlterarNomeAbaAtiva.setText(
                Rotinas.getRecurso("FrmPrincipal.menuAlterarNomeAbaAtiva"));
        menuExcluirAbaAtiva.setText(
                Rotinas.getRecurso("FrmPrincipal.menuExcluirAbaAtiva"));
                
        menuDiretorio.setText(Rotinas.getRecurso("FrmPrincipal.menuDiretorio"));
        menuImportarDiretorio.setText(
                Rotinas.getRecurso("FrmPrincipal.menuImportarDiretorio"));
        menuImportarSubDiretorios.setText(
                Rotinas.getRecurso("FrmPrincipal.menuImportarSubDiretorios"));
        menuCompararDiretorios.setText(
                Rotinas.getRecurso("FrmPrincipal.menuCompararDiretorios"));
        menuCadastrarExtensaoArquivo.setText(
                Rotinas.getRecurso("FrmPrincipal.menuCadastrarExtensaoArquivo"));
        menuExpandirDiretorios.setText(
                Rotinas.getRecurso("FrmPrincipal.menuExpandirDiretorios"));
        menuColapsarDiretorios.setText(
                Rotinas.getRecurso("FrmPrincipal.menuColapsarDiretorios"));
        menuExportarDiretoriosAbaAtiva.setText(
                Rotinas.getRecurso("FrmPrincipal.menuExportarDiretoriosAbaAtiva"));
        menuImportarDiretoriosViaXML.setText(
                Rotinas.getRecurso("FrmPrincipal.menuImportarDiretoriosViaXML"));
        menuGravarLogImportacao.setText(
                Rotinas.getRecurso("FrmPrincipal.menuGravarLogImportacao"));
                
        menuVisao.setText(Rotinas.getRecurso("FrmPrincipal.menuVisao"));
        menuMostrarOcultarArvoreDirAbaAtiva.setText(
                Rotinas.getRecurso("FrmPrincipal.menuMostrarOcultarArvoreDirAbaAtiva"));
        menuMostrarOcultarListaItensPesquisados.setText(
                Rotinas.getRecurso("FrmPrincipal.menuMostrarOcultarListaItensPesquisados"));
                
        menuIdioma.setText(Rotinas.getRecurso("FrmPrincipal.menuIdioma"));
        menuPortugues.setText(Rotinas.getRecurso("FrmPrincipal.menuPortugues"));
        menuIngles.setText(Rotinas.getRecurso("FrmPrincipal.menuIngles"));
        menuEspanhol.setText(Rotinas.getRecurso("FrmPrincipal.menuEspanhol"));
        menuFrances.setText(Rotinas.getRecurso("FrmPrincipal.menuFrances"));
        menuItaliano.setText(Rotinas.getRecurso("FrmPrincipal.menuItaliano"));
        menuAlemao.setText(Rotinas.getRecurso("FrmPrincipal.menuAlemao"));
        menuJapones.setText(Rotinas.getRecurso("FrmPrincipal.menuJapones"));
        menuCoreano.setText(Rotinas.getRecurso("FrmPrincipal.menuCoreano"));
        menuChinesTradicional.setText(Rotinas
                .getRecurso("FrmPrincipal.menuChinesTradicional"));
        
        menuSobre.setText(Rotinas.getRecurso("FrmPrincipal.menuSobre"));
        menuSobreCatalogador.setText(
                Rotinas.getRecurso("FrmPrincipal.menuSobreCatalogador"));
    }
    
    public Catalogador getCatalogador(){
        return catalogador;
    }
    
}
