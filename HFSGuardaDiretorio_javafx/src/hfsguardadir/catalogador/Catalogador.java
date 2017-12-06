package hfsguardadir.catalogador;

import hfsguardadir.comum.ICatalogador;
import hfsguardadir.comum.IProgressoLog;
import hfsguardadir.comum.Rotinas;
import hfsguardadir.comum.StringList;
import hfsguardadir.comum.TipoExportar;
import hfsguardadir.gui.FrmImportarDiretorio;
import hfsguardadir.gui.FrmPrincipal;
import hfsguardadir.gui.FrmSplash;
import hfsguardadir.gui.FrmSplashProgresso;
import hfsguardadir.gui.controller.FrmPrincipalController;
import hfsguardadir.objetos.Aba;
import hfsguardadir.objetos.Diretorio;
import hfsguardadir.objetos.DiretorioOrdem;
import hfsguardadir.objetos.Extensao;
import hfsguardadir.objetos.Importar;
import hfsguardadir.objetos.Parametro;
import hfsguardadir.objetosbo.AbaBO;
import hfsguardadir.objetosbo.DiretorioBO;
import hfsguardadir.objetosbo.ExtensaoBO;
import hfsguardadir.objetosdao.VisaoDAO;
import hfsguardadir.objetosgui.Arvore;
import hfsguardadir.objetosgui.Dialogo;
import hfsguardadir.objetosgui.EscolhaArquivo;
import hfsguardadir.objetosgui.Tabela;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.beans.property.BooleanProperty;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.concurrent.Task;
import javafx.geometry.Orientation;
import javafx.scene.Cursor;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.SplitPane;
import javafx.scene.control.Tab;
import javafx.scene.control.TreeItem;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

public class Catalogador implements ICatalogador {

    private static final String CONSULTA_DIR_PAI
            = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, "
            + "atributos, caminho, nomeaba, nomepai, caminhopai "
            + "from consultadirpai "
            + "order by 1,2,3,4";
    private static final String CONSULTA_DIR_FILHO
            = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, "
            + "atributos, caminho, nomeaba, nomepai, caminhopai "
            + "from consultadirfilho "
            + "order by 1,2,3,4";
    public static final String CONSULTA_ARQUIVO
            = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, "
            + "atributos, caminho, nomeaba, nomepai, caminhopai "
            + "from consultaarquivo "
            + "order by tipo desc, ordem";
   
    private static final String NO_RAIZ = "Raiz";
    
    private final boolean bSombrearLinhas, bSombrearColunas;

    private static final Logger log = Logger.getLogger(Rotinas.HFSGUARDADIR);

    private ArrayList<Diretorio> listaDiretorioFilho;
    private ArrayList<Diretorio> listaArquivos;

    public DiretorioOrdem diretorioOrdem;

    public ArrayList<Aba> listaAbas;
    public ArrayList<Diretorio> listaDiretorioPai;
    public ArrayList<Extensao> listaExtensoes;

    private TreeItem<String> nodeRaiz;

    private final FrmPrincipalController form;   

    public Catalogador(FrmPrincipalController form){
        this.form = form;
        this.bSombrearLinhas = false;
        this.bSombrearColunas = false;

        diretorioOrdem = new DiretorioOrdem();
        
        listaAbas = new ArrayList<>();
        listaExtensoes = new ArrayList<>();
        listaDiretorioPai = new ArrayList<>();
        listaDiretorioFilho = new ArrayList<>();
        listaArquivos = new ArrayList<>();

        form.tabelaPesquisa = new Tabela(this, null, null, 
                form.pb, false);
        
        FrmSplash frmSplash = new FrmSplash(this);
        frmSplash.ShowModal();
    }
    
    public void carregarDados(FrmSplashProgresso frmSplashProgresso){
        try {            
            CarregarDados(frmSplashProgresso, true, true);            
            CarregarAbas();
            tabPanelMudou();            
        } catch (SQLException ex) {
            Logger.getLogger(Catalogador.class.getName()).log(Level.SEVERE, null, ex);
        }                
    }
    
    public static void iniciarSistema(Parametro param) throws SAXException,
            IOException, ParserConfigurationException, SQLException,
            ClassNotFoundException {
        Aba aba;
        
        if (!Rotinas.carregarParametros(param.getArquivoConfiguracao())) {       
            Dialogo.mensagemErro("HFSGuardaDir.ValidaArquivoConf");
        }
        Rotinas.registrarProvedorTIFF();        
        
        String sBanco = param.getDiretorioSistema() +                 
                Rotinas.BARRA_INVERTIDA + "GuardaDir.db";
        
        if (!Rotinas.FileExists(sBanco)){
            Rotinas.Conectar();
            
            AbaBO.getInstancia().criarTabelaAbas();

            aba = new Aba(1,"DISCO1",0);
            AbaBO.getInstancia().incluirAba(aba);

            ExtensaoBO.getInstancia().criarTabelaExtensoes();
            DiretorioBO.getInstancia().criarTabelaDiretorios();
            VisaoDAO.getInstancia().criarVisao("consultadirpai");
            VisaoDAO.getInstancia().criarVisao("consultadirfilho");
            VisaoDAO.getInstancia().criarVisao("consultaarquivo");
        } else
            Rotinas.Conectar();

        Dialogo.mudarLingua();
        EscolhaArquivo.mudarLingua();
    }

    public void mudarLingua(String lingua) {
        Parametro params = Rotinas.getParams();
        params.setLocalidadeLingua(lingua);
        params.setLocalidadePais("");
        FrmPrincipal.getInstancia().mudarLingua();

        Dialogo.mudarLingua();
        EscolhaArquivo.mudarLingua();
    }
    
    public void CarregarDados(IProgressoLog pLog, boolean bExtensao,
            boolean bDiretorio) throws SQLException {
        listaAbas = AbaBO.getInstancia().carregarAba(pLog);
        if (bExtensao) {
            listaExtensoes = ExtensaoBO.getInstancia().carregarExtensao(pLog);
        }
        if (bDiretorio) {
            listaDiretorioPai = DiretorioBO.getInstancia().carregarDiretorio(
                    CONSULTA_DIR_PAI, pLog);
            listaDiretorioFilho = DiretorioBO.getInstancia().carregarDiretorio(
                    CONSULTA_DIR_FILHO, pLog);
            listaArquivos = DiretorioBO.getInstancia().carregarDiretorio(
                    CONSULTA_ARQUIVO, pLog);
        }
    }

    public void ExcluirDados(Aba aba, String sCaminho) {
        DiretorioBO.getInstancia().excluirListaDiretorio(listaDiretorioPai, aba, sCaminho);
        DiretorioBO.getInstancia().excluirListaDiretorio(listaDiretorioFilho, aba, sCaminho);
        DiretorioBO.getInstancia().excluirListaDiretorio(listaArquivos, aba, sCaminho);
    }

    public void mudarImagem(TreeItem<String> item){
        item.expandedProperty().addListener(new ChangeListener<Boolean>() {
            @Override
            public void changed(ObservableValue<? extends Boolean> observable, 
                    Boolean oldValue, Boolean newValue) {
                ImageView iv;
                BooleanProperty bb = (BooleanProperty) observable;
                TreeItem<String> tItem = (TreeItem<String>) bb.getBean();
                if (tItem.isExpanded()){
                    iv = new ImageView(Rotinas.getImagem("dir-aberto.gif"));
                } else {
                    iv = new ImageView(Rotinas.getImagem("diretorio.gif"));                    
                }
                tItem.setGraphic(iv);
            }
        });
    }
    
    private void AddItemArvore(Diretorio diretorio, int Nivel,
            TreeItem<String> node1) {
        ArrayList<Diretorio> listaFilhos;
        TreeItem<String> node2;
        ImageView iv;

        if (Nivel == 0) {
            iv = new ImageView(Rotinas.getImagem("diretorio.gif"));
            node1 = new TreeItem<>(diretorio.getNome(), iv);
            mudarImagem(node1);
            nodeRaiz.getChildren().add(node1);
        }

        listaFilhos = DiretorioBO.getInstancia().itensFilhos(listaDiretorioFilho,
                diretorio.getAba().getCodigo(), diretorio.getOrdem(),
                diretorio.getCodigo());

        for (Diretorio filho : listaFilhos) {
            iv = new ImageView(Rotinas.getImagem("diretorio.gif"));
            node2 = new TreeItem<>(filho.getNome(), iv);
            mudarImagem(node2);
            node1.getChildren().add(node2);
            AddItemArvore(filho, ++Nivel, node2);
        }
    }

    public void IncluirNovaAba() throws SQLException {
        Aba aba;
        String sAba = Dialogo.entrada("FrmPrincipal.DigitaIncluirNovaAba");
        if ((sAba != null) && (sAba.trim().length() > 0)) {
            aba = new Aba();
            aba.setCodigo(AbaBO.getInstancia().retMaxCodAba(listaAbas));
            aba.setNome(Rotinas.SubString(sAba, 1, 10));
            aba.setOrdem(listaAbas.size() + 1);
            AbaBO.getInstancia().incluirAba(aba);
            IncluirNovaAba(aba.getNome());
            listaAbas.add(aba);
        }
    }
    
    public void AlterarNomeAbaAtiva(IProgressoLog pLog) throws SQLException {
        Aba aba = getAbaAtual();
        String sAba = Dialogo.entrada("FrmPrincipal.DigitaAlterarNomeAba", 
                aba.getNome());
        if ((sAba != null) && (sAba.trim().length() > 0)) {
            aba.setNome(Rotinas.SubString(sAba, 1, 10));
            AbaBO.getInstancia().alterarAba(aba);            
            form.tabPanel.getSelectionModel().getSelectedItem().setText(sAba);
            CarregarDados(pLog, false, true);
        }        
    }
    
    public void ExcluirAbaAtiva(IProgressoLog pLog) throws SQLException{
        Aba aba;
        int indiceSel = form.tabPanel.getSelectionModel().getSelectedIndex();
        if (indiceSel > 0) {
            Optional<ButtonType> res = Dialogo.confirma("FrmPrincipal.ConfirmaExcluirAba");
            if (res.get() == ButtonType.OK){
                FrmPrincipal.getInstancia().getScene().setCursor(Cursor.WAIT);
                
                aba = getAbaAtual();
                ExcluirDados(aba, "");
                AbaBO.getInstancia().excluirAba(aba);                
                form.tabPanel.getTabs().remove(indiceSel);
                
                CarregarDados(pLog, false, false);

                form.barraStatus2.setText("");
                
                FrmPrincipal.getInstancia().getScene().setCursor(Cursor.DEFAULT);
            }
        } else
                Dialogo.mensagemErro("FrmPrincipal.ValidaExcluirAba");        
    }
    
    private void IncluirNovaAba(String nomeAba) {
        Tab panelAba;
	AnchorPane apaneSplit, apaneArvore, apaneTabela;
        SplitPane split;
        Arvore arvore;
        Tabela tabela;	
        ImageView iv;

        arvore = new Arvore(null);
        arvore.setLayoutX(21.0);
        arvore.setLayoutY(-30.0);
        arvore.setPrefHeight(159.0);
        arvore.setPrefWidth(260.0);
        AnchorPane.setBottomAnchor(arvore, 0.0);
        AnchorPane.setLeftAnchor(arvore, 0.0);
        AnchorPane.setRightAnchor(arvore, 0.0);
        AnchorPane.setTopAnchor(arvore, 0.0);
        
        arvore.getSelectionModel().selectedItemProperty().addListener(
                new ChangeListener<TreeItem<String>>() {
            @Override
            public void changed(ObservableValue<? extends TreeItem<String>> observable, 
                    TreeItem<String> oldValue, TreeItem<String> newValue) {
                arvoreValorMudou(newValue);
            }            
        });        

	apaneArvore = new AnchorPane(arvore);
	apaneArvore.setMinHeight(0.0);
	apaneArvore.setMinWidth(0.0);
	apaneArvore.setPrefHeight(160.0);
	apaneArvore.setPrefWidth(100.0);	
	
        tabela = new Tabela(this, null, null, form.pb, true);
        tabela.setPrefHeight(159.0);
        tabela.setPrefWidth(618.0);
        AnchorPane.setBottomAnchor(tabela, 0.0);
        AnchorPane.setLeftAnchor(tabela, 0.0);
        AnchorPane.setRightAnchor(tabela, 0.0);
        AnchorPane.setTopAnchor(tabela, 0.0);
        
        apaneTabela = new AnchorPane(tabela);
	apaneTabela.setMinHeight(0.0);
	apaneTabela.setMinWidth(0.0);
	apaneTabela.setPrefHeight(160.0);
	apaneTabela.setPrefWidth(100.0);	
        
        split = new SplitPane();        
        split.setDividerPositions(0.3);
        split.setLayoutX(151.0);
        split.setLayoutY(1.0);
        split.setPrefHeight(161.0);
        split.setPrefHeight(886.0);
        split.setOrientation(Orientation.HORIZONTAL);
        AnchorPane.setBottomAnchor(split, 0.0);
        AnchorPane.setLeftAnchor(split, 0.0);
        AnchorPane.setRightAnchor(split, 0.0);
        AnchorPane.setTopAnchor(split, 0.0);
		
        split.getItems().add(apaneArvore);
        split.getItems().add(apaneTabela);

	apaneSplit = new AnchorPane(split);
        		
	panelAba = new Tab(nomeAba);
        iv = new ImageView(Rotinas.getImagem("cdouro.gif"));
        panelAba.setGraphic(iv);
        panelAba.setContent(apaneSplit);
        
        form.tabPanel.getTabs().add(panelAba);
    }

    public Arvore getArvoreAtual() {
        return getArvoreAtual(form.tabPanel.getSelectionModel().getSelectedIndex());
    }

    public Arvore getArvoreAtual(int nIndicePagina) {
        Tab panel = form.tabPanel.getTabs().get(nIndicePagina);               
        AnchorPane apaneSplit = (AnchorPane) panel.getContent();
        SplitPane split = (SplitPane) apaneSplit.getChildren().get(0);
        AnchorPane apaneArvore = (AnchorPane) split.getItems().get(0);
        Arvore arvore = (Arvore) apaneArvore.getChildren().get(0);
        return arvore;
    }

    public SplitPane getSplitAtual() {
        int nIndicePagina = form.tabPanel.getSelectionModel().getSelectedIndex();
        Tab panel = form.tabPanel.getTabs().get(nIndicePagina);
        SplitPane split = (SplitPane) panel.getContent();
        return split;
    }
    
    public Tabela getTabelaAtual() {
        int nIndicePagina = form.tabPanel.getSelectionModel().getSelectedIndex();
        Tab panel = form.tabPanel.getTabs().get(nIndicePagina);
        AnchorPane apaneSplit = (AnchorPane) panel.getContent();
        SplitPane split = (SplitPane) apaneSplit.getChildren().get(0);
        AnchorPane apaneTabela = (AnchorPane) split.getItems().get(1);
        Tabela tabela = (Tabela) apaneTabela.getChildren().get(0);
        return tabela;
    }

    public void setTabelaAtual(Tabela tabela) {
        int nIndicePagina = form.tabPanel.getSelectionModel().getSelectedIndex();

        //tabela.setComponentPopupMenu(form.menuPopup);
        tabela.getSelectionModel().select(0);
        //tabela.setSombrearLinhas(true);

        Tab panel = form.tabPanel.getTabs().get(nIndicePagina);
        AnchorPane apaneSplit = (AnchorPane) panel.getContent();
        SplitPane split = (SplitPane) apaneSplit.getChildren().get(0);
        AnchorPane apaneTabela = (AnchorPane) split.getItems().get(1);
        
        tabela.setPrefHeight(159.0);
        tabela.setPrefWidth(618.0);
        AnchorPane.setBottomAnchor(tabela, 0.0);
        AnchorPane.setLeftAnchor(tabela, 0.0);
        AnchorPane.setRightAnchor(tabela, 0.0);
        AnchorPane.setTopAnchor(tabela, 0.0);
        
        apaneTabela.getChildren().set(0, tabela);
    }
    
    public void mostrarOcultarArvore(){
        Arvore arvore = getArvoreAtual();
        if (arvore.isVisible()) {
            getSplitAtual().setDividerPositions(0.3);
        } else {
            getSplitAtual().setDividerPositions(0);
        }
    }
    
    public void CarregarArvore(Arvore tvAba, Aba aba) {
        nodeRaiz = new TreeItem<>(NO_RAIZ);
        
        tvAba.getRoot().getChildren().clear();

        for (Diretorio diretorio : listaDiretorioPai) {
            if (diretorio.getAba().getCodigo() == aba.getCodigo()) {
                AddItemArvore(diretorio, 0, null);
            }
        }

        tvAba.setRoot(nodeRaiz);
        tvAba.setShowRoot(false);
    }

    public void CarregarAbas() {
        Arvore tvAba;

        //form.pb.setMinimum(0);
        //form.pb.setMaximum(listaAbas.size() - 1);
        int nMax = listaAbas.size() - 1;
        form.pb.setProgress(0);

        for (int i = 0; i < listaAbas.size(); i++) {
            IncluirNovaAba(listaAbas.get(i).getNome());
            tvAba = getArvoreAtual(i);
            CarregarArvore(tvAba, listaAbas.get(i));
            form.pb.setProgress((nMax*i)/100);
        }
    }

    private Aba getAbaAtual() {
        return AbaBO.getInstancia().pegaAbaPorOrdem(
                listaAbas, form.tabPanel.getSelectionModel().getSelectedIndex() + 1);
    }

    public Tabela CarregarArquivosLista(boolean bLista1, String sCaminho) {
        String sPaiCaminho;
        ArrayList<Diretorio> listaLocal;
        Tabela lvArquivos;
        int nAba;

        listaLocal = new ArrayList<>();

        if (bLista1) {
            sPaiCaminho = sCaminho;
            if (!Rotinas.SubString(sCaminho, sCaminho.length(), 1).equals(Rotinas.BARRA_INVERTIDA)) {
                sCaminho = sCaminho + Rotinas.BARRA_INVERTIDA;
            }
            nAba = getAbaAtual().getCodigo();
            for (Diretorio diretorio : listaArquivos) {
                if (diretorio.getAba().getCodigo() == nAba) {
                    if (diretorio.getCaminhoPai().equals(sPaiCaminho)) {
                        if (Rotinas.StartsStr(sCaminho, diretorio.getCaminho())) {
                            listaLocal.add(diretorio);
                        }
                    }
                }
            }
        } else {
            for (Diretorio diretorio : listaArquivos) {
                if (Rotinas.ContainsStr(diretorio.getCaminho().toUpperCase(), 
                        sCaminho.toUpperCase())) {
                    listaLocal.add(diretorio);
                }
            }
        }
        lvArquivos = new Tabela(this, listaLocal, listaExtensoes, form.pb, bLista1);
        listaLocal.clear();

        return lvArquivos;
    }

    public void TamTotalDiretorio(String sCaminho) {
        long conta;
        int nAba;
        BigDecimal soma, tam;

        conta = 0;
        soma = new BigDecimal(0);

        for (Diretorio diretorio : listaArquivos) {
            nAba = getAbaAtual().getCodigo();
            if (diretorio.getAba().getCodigo() == nAba) {
                if (diretorio.getTipo().getCodigo() != 'D') {
                    if (sCaminho.trim().length() > 0) {
                        if (Rotinas.StartsStr(sCaminho, diretorio.getCaminho())) {
                            conta++;
                            tam = new BigDecimal(diretorio.getTamanho());
                            soma = soma.add(tam);
                        }
                    } else {
                        conta++;
                        tam = new BigDecimal(diretorio.getTamanho());
                        soma = soma.add(tam);
                    }
                }
            }
        }

        form.barraStatus1.setText(
                "Quantidade Total: " + Rotinas.FormatLong("0000", conta)
                + ", Tamanho Total: " + DiretorioBO.getInstancia().MontaTamanhoBig(soma));
    }

    private boolean testaSeparadorArquivo(String sDir) {
        sDir = Rotinas.SubString(sDir, sDir.length(), 1);
        if (sDir.equals(Rotinas.BARRA_INVERTIDA) 
                || sDir.equals(Rotinas.BARRA_NORMAL)
                || sDir.equals(Rotinas.BARRA_INVERTIDA)) {
            return true;
        } else {
            return false;
        }
    }

    private StringList montaCaminho(String sCaminho, boolean bRemover) {
        sCaminho = NO_RAIZ + Rotinas.BARRA_INVERTIDA + sCaminho;
        StringList sl = new StringList(sCaminho, Rotinas.BARRA_INVERTIDA.charAt(0));
        if (sl.get(sl.size() - 1).trim().length() == 0) {
            sl.remove(sl.size() - 1);
        }
        if (bRemover) {
            sl.remove(sl.size() - 1);
        }
        return sl;
    }

    public void Pesquisar() {
        Arvore arvoreLocal = getArvoreAtual();
        if (arvoreLocal.getRoot().getChildren().size() > 0) {
            if (form.edtPesquisa.getText().length() >= 2) {
                //form.scrollPesquisa.setVisible(true);
                form.spPesquisa.setDividerPositions(0.5);
                
                AnchorPane apanePesquisa = (AnchorPane) form.spPesquisa.getItems().get(1);
                apanePesquisa.minHeight(0.0);
                apanePesquisa.minWidth(0.0);
                apanePesquisa.prefHeight(100.0);
                apanePesquisa.prefWidth(160.0);

                form.tabelaPesquisa = CarregarArquivosLista(false, 
                        form.edtPesquisa.getText());
                form.tabelaPesquisa.setLayoutX(149.0);
                form.tabelaPesquisa.setLayoutY(-5.0);
                form.tabelaPesquisa.setPrefHeight(190.0);
                form.tabelaPesquisa.setPrefWidth(886.0);
                AnchorPane.setBottomAnchor(form.tabelaPesquisa, 0.0);
                AnchorPane.setLeftAnchor(form.tabelaPesquisa, 0.0);
                AnchorPane.setRightAnchor(form.tabelaPesquisa, 0.0);
                AnchorPane.setTopAnchor(form.tabelaPesquisa, 0.0);

                apanePesquisa.getChildren().set(0, form.tabelaPesquisa);                
                
                form.tabelaPesquisa.getSelectionModel().select(0);
            } else {
                form.spPesquisa.setDividerPositions(1);
                form.tabelaPesquisa = new Tabela(this, null, null, 
                        form.pb, false);
                Dialogo.mensagemInfo("FrmPrincipal.TamMaxPesquisa");
            }
        }
    }

    public void PesquisarArvoreDiretorio(String sCaminho, Aba aba) {
        form.tabPanel.getSelectionModel().select(aba.getOrdem()-1);
        Arvore arvore = getArvoreAtual();
        StringList sl = montaCaminho(sCaminho, false); // Verifica Diretorio
        TreeItem<String> item = arvore.encontrarCaminhoPorNome(sl.toStringArray());
        if (item == null) {
            sl.remove(sl.size() - 2);
            //sl.set(1, sl.get(1) + Rotinas.BARRA_INVERTIDA);
            item = arvore.encontrarCaminhoPorNome(sl.toStringArray());

            if (item == null) {
                sl.clear();
                sl = montaCaminho(sCaminho, true); // Verifica Arquivo
                item = arvore.encontrarCaminhoPorNome(sl.toStringArray());

                if (item == null) {
                    sl.set(1, sl.get(1) + Rotinas.BARRA_INVERTIDA);
                    item = arvore.encontrarCaminhoPorNome(sl.toStringArray());
                }
            }
        }

        arvore.expandeTodos(item, true);
        arvore.getSelectionModel().select(item);
    }

    public void LerArvoreDiretorio(TreeItem<String> pai, Label barraStatus) {
        if (!pai.getValue().equals(NO_RAIZ)) {
            barraStatus.setText(pai.getValue() + Rotinas.BARRA_INVERTIDA + barraStatus.getText());
            LerArvoreDiretorio(pai.getParent(), barraStatus);
        } else {
            barraStatus.setText(barraStatus.getText().substring(0, barraStatus.getText().length()-1));
        }
    }

    public Tabela ListarArquivos() {
        Tabela tabela = CarregarArquivosLista(true, form.barraStatus2.getText());
        TamTotalDiretorio(form.barraStatus2.getText());
        return tabela;
    }
    
    public void tabPanelMudou(){
        Arvore arvore = getArvoreAtual();
        
        TamTotalDiretorio("");                
        arvore.getSelectionModel().select(0);
        if (!arvore.getSelectionModel().isEmpty()){            
            form.barraStatus2.setText("");
            LerArvoreDiretorio(arvore.getSelectionModel().getSelectedItem(), 
                    form.barraStatus2);
        }
    }

    public void arvoreValorMudou(TreeItem<String> item) {
        form.barraStatus2.setText("");
        LerArvoreDiretorio(item, form.barraStatus2);
        setTabelaAtual(ListarArquivos());
    }

    @Override
    public Aba getAbaSelecionada() {
        return getAbaAtual();
    }

    @Override
    public void DuploCliqueLista(String nome, String tipo) {
        if (tipo.equals(Rotinas.getRecurso("TipoLista.diretorio"))) {
            FrmPrincipal.getInstancia().getScene().setCursor(Cursor.WAIT);
            String sCaminho = form.barraStatus2.getText();
            if (testaSeparadorArquivo(sCaminho)) {
                sCaminho += nome;
            } else {
                sCaminho += Rotinas.BARRA_INVERTIDA + nome;
            }
            
            PesquisarArvoreDiretorio(sCaminho, getAbaAtual());
            FrmPrincipal.getInstancia().getScene().setCursor(Cursor.DEFAULT);
        }
    }

    @Override
    public void EncontrarItemLista(int codigoAba, String nome, String caminho) {
        FrmPrincipal.getInstancia().getScene().setCursor(Cursor.WAIT);
        Aba aba = AbaBO.getInstancia().getElemento(listaAbas, codigoAba);        
        PesquisarArvoreDiretorio(caminho, aba);

        Tabela tabela = getTabelaAtual();
        int nlinha = tabela.encontrarLinha(nome);
        tabela.getSelectionModel().select(nlinha);
        tabela.scrollTo(nlinha);
        FrmPrincipal.getInstancia().getScene().setCursor(Cursor.DEFAULT);
    }
   
    public int verificaNomeDiretorio(String sCaminho, RotuloRaiz sRotuloRaiz) {
        sRotuloRaiz.setRotulo(
                DiretorioBO.getInstancia().removerDrive(sCaminho));
        if (sRotuloRaiz.getRotulo().length() == 0) {

            sRotuloRaiz.setRotulo(Dialogo.entrada(
                    "FrmPrincipal.DigitaNomeDiretorio"));

            if ((sRotuloRaiz.getRotulo() != null)
                    && (sRotuloRaiz.getRotulo().trim().length() > 0)) {
                sRotuloRaiz.setRotulo(sRotuloRaiz.getRotulo().trim());

                if (sRotuloRaiz.getRotulo().length() > 0) {
                    return 1;
                } else {
                    Dialogo.mensagemInfo("FrmPrincipal.ValidaNomeDiretorio");
                    return 0;
                }
            } else {
                return 0;
            }
        } else if (Rotinas.Pos(Rotinas.BARRA_INVERTIDA,
                sRotuloRaiz.getRotulo()) > 0) {
            sRotuloRaiz.setRotulo(Rotinas.SubString(sRotuloRaiz.getRotulo(),
                    Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA,
                            sRotuloRaiz.getRotulo()) + 1,
                    sRotuloRaiz.getRotulo().length()));
            return 2;
        } else {
            return 3;
        }
    }
    
    public void ExportarArquivo(TipoExportar tipo, IProgressoLog pLog) 
            throws SQLException, IOException {
        String sExtensao = "";

        switch (tipo) {
            case teTXT:
                sExtensao = "txt";
                break;
            case teCSV:
                sExtensao = "csv";
                break;
            case teHTML:
                sExtensao = "html";
                break;
            case teXML:
                sExtensao = "xml";
                break;
            case teSQL:
                sExtensao = "sql";
                break;
        }

        EscolhaArquivo escolha = new EscolhaArquivo(EscolhaArquivo.SAVE_DIALOG);
        Aba aba = getAbaAtual();
        String sArq = escolha.getDiretorioInicial()+
                Rotinas.BARRA_INVERTIDA+
                aba.getNome()+'.'+sExtensao;
        escolha.setArquivoInicial(sArq);
        File arquivo = escolha.mostrarSalvar(FrmPrincipal.getInstancia());
        if (arquivo != null) {
            FrmPrincipal.getInstancia().getScene().setCursor(Cursor.WAIT);
            DiretorioBO.getInstancia().exportarDiretorio(tipo, getAbaAtual(),
                    arquivo.getPath(), pLog);
            FrmPrincipal.getInstancia().getScene().setCursor(Cursor.DEFAULT);

            Dialogo.mensagemErro("FrmPrincipal.SucessoExportar");
        }
        //} else if (retval == EscolhaArquivo.ERROR_OPTION) {
        //    Dialogo.mensagemErro("FrmPrincipal.ErroSalvarArquivo");
        //}
    }

    private StringList montaCaminho(TreeItem<String> pai, boolean bRemoveRaiz) {
        StringList lista;

        if (bRemoveRaiz) {
            lista = new StringList();
            lista.add(form.barraStatus2.getText());
        } else {
            String caminho = NO_RAIZ + Rotinas.BARRA_INVERTIDA + form.barraStatus2.getText();
            lista = new StringList(caminho, Rotinas.BARRA_INVERTIDA.charAt(0));
        }
        return lista;
    }
    
    public void ExcluirDiretorioSelecionado(IProgressoLog pLog) 
            throws SQLException {
        Arvore arvore = getArvoreAtual();

        if (!arvore.getSelectionModel().isEmpty()) {
            TreeItem<String> pai = arvore.getSelectionModel().getSelectedItem();
            
            Tabela tabela = getTabelaAtual();
            Optional<ButtonType> res = Dialogo.confirma(
                    "FrmPrincipal.ExcluirDiretorioSelecionado");
            if (res.get() == ButtonType.OK){            
                FrmPrincipal.getInstancia().getScene().setCursor(Cursor.WAIT);
                StringList sl = montaCaminho(pai, true);

                DiretorioBO.getInstancia().excluirDiretorio(getAbaAtual(), sl.getText());
                ExcluirDados(getAbaAtual(), sl.getText());

                StringList sl2 = montaCaminho(pai, false);
                arvore.excluirNode(sl2.toStringArray());
                tabela.getItems().clear();

                CarregarDados(pLog, false, false);

                FrmPrincipal.getInstancia().getScene().setCursor(Cursor.DEFAULT);
            }
        }
    }
    
    public void ImportarArquivo(StringList log, IProgressoLog pLog) 
            throws IOException, SQLException {
        int nResultado;

        EscolhaArquivo escolha = new EscolhaArquivo(
                EscolhaArquivo.PREVIEW_OPEN_DIALOG);
        File arquivo = escolha.mostrarAbrir(FrmPrincipal.getInstancia());
        if (arquivo != null) {
            FrmPrincipal.getInstancia().getScene().setCursor(Cursor.WAIT);
            nResultado = DiretorioBO.getInstancia().importarDiretorioViaXML(
            getAbaAtual(), arquivo.getPath(), listaDiretorioPai, pLog);
            if (nResultado == -1) {
                Dialogo.mensagemErro("FrmPrincipal.ImportacaoNaoRealizada");
            } else if (nResultado == -2) {
                Dialogo.mensagemErro("FrmPrincipal.DiretorioExisteCatalogo");
            } else {                    
                FinalizaImportacao(pLog);                    
            }
            FrmPrincipal.getInstancia().getScene().setCursor(Cursor.DEFAULT);
        }
    }
    
    public boolean ImportarDiretorios(StringList listaCaminho,
            boolean bSubDiretorio, FrmImportarDiretorio frmImportarDiretorio) {
        int nAba, nRotuloRaiz, nCodDirRaiz;
        RotuloRaiz sRotuloRaiz = new RotuloRaiz();
        String sCaminhoSemDrive;
        Importar importar = new Importar();

        nAba = getAbaAtual().getCodigo();
        nCodDirRaiz = DiretorioBO.getInstancia().retMaxCodDir(nAba, 
                listaDiretorioPai);

        for (String sCaminho : listaCaminho) {
            nRotuloRaiz = verificaNomeDiretorio(sCaminho, sRotuloRaiz);
            if (nRotuloRaiz > 0) {
                importar = new Importar();
                importar.setAba(nAba);
                importar.setCodDirRaiz(nCodDirRaiz);
                importar.setRotuloRaiz(sRotuloRaiz.getRotulo());
                if (nRotuloRaiz == 1) {
                    importar.setNomeDirRaiz(sRotuloRaiz.getRotulo());
                } else if (nRotuloRaiz == 2) {
                    sCaminhoSemDrive = DiretorioBO.getInstancia().removerDrive(sCaminho);
                    importar.setNomeDirRaiz(Rotinas.SubString(
                            sCaminhoSemDrive, 1,
                            Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA,
                                    sCaminhoSemDrive) - 1));
                } else if (nRotuloRaiz == 3) {
                    importar.setNomeDirRaiz("");
                }
                importar.setCaminho(sCaminho);

                frmImportarDiretorio.getController().listaImportar.add(importar);
                nCodDirRaiz++;
            }
        }

        frmImportarDiretorio.getController().bSubDiretorio = bSubDiretorio;

        if (bSubDiretorio) {
            frmImportarDiretorio.ShowModal();
            return true;
        } else {
            if (!DiretorioBO.getInstancia().verificaCodDir(
                    importar.getAba(), importar.getRotuloRaiz(),
                    listaDiretorioPai)) {
                frmImportarDiretorio.ShowModal();
                return true;
            } else {
                Dialogo.mensagemErro("FrmPrincipal.DiretorioExisteCatalogo");
                return false;
            }
        }

    }
    
    public void FinalizaImportacao(IProgressoLog pLog) throws SQLException {
        Arvore tvAba;

        FrmPrincipal.getInstancia().getScene().setCursor(Cursor.WAIT);

        CarregarDados(pLog, true, true);
        tvAba = getArvoreAtual();
        CarregarArvore(tvAba, getAbaAtual());

        FrmPrincipal.getInstancia().getScene().setCursor(Cursor.DEFAULT);
        Dialogo.mensagemInfo("FrmPrincipal.DirImportacaoSucesso");

    }
    
 
    public void ComecaImportacao(boolean bSubDiretorios, IProgressoLog pLog) 
            throws SQLException {
        String sCaminho;
        StringList listaCaminho;

        EscolhaArquivo escolha = new EscolhaArquivo(
                EscolhaArquivo.CUSTOM_DIALOG);
        File arquivo = escolha.mostrar(FrmPrincipal.getInstancia());
        if (arquivo != null) {
            FrmPrincipal.getInstancia().getScene().setCursor(Cursor.WAIT);
            sCaminho = arquivo.getPath();

            listaCaminho = new StringList();

            if (bSubDiretorios) {
                DiretorioBO.getInstancia().
                        carregarSubDiretorios(sCaminho, listaCaminho);
            } else {
                listaCaminho.add(sCaminho);
            }

            if (ImportarDiretorios(listaCaminho, bSubDiretorios, 
                    FrmImportarDiretorio.getInstancia())) {
                FinalizaImportacao(pLog);
            }

            FrmPrincipal.getInstancia().getScene().setCursor(Cursor.DEFAULT);
        }
        //} else if (retval == EscolhaArquivo.ERROR_OPTION) {
        //    Dialogo.mensagemErro("FrmPrincipal.ErroAbrirDir");
        //}

    }

}
