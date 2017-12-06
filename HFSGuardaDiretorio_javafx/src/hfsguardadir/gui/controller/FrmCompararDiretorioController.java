package hfsguardadir.gui.controller;

import hfsguardadir.catalogador.Catalogador;
import hfsguardadir.comum.Rotinas;
import hfsguardadir.comum.StringList;
import hfsguardadir.gui.FrmCompararDiretorio;
import hfsguardadir.gui.FrmCompararDiretorioProgresso;
import hfsguardadir.gui.FrmPrincipal;
import hfsguardadir.objetos.Aba;
import hfsguardadir.objetos.Diretorio;
import hfsguardadir.objetosbo.AbaBO;
import hfsguardadir.objetosbo.DiretorioBO;
import hfsguardadir.objetosgui.Arvore;
import hfsguardadir.objetosgui.Dialogo;
import hfsguardadir.objetosgui.Tabela;
import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.Cursor;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.TitledPane;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;

public class FrmCompararDiretorioController implements Initializable {
    private FrmCompararDiretorioProgresso frmCompararDiretorioProgresso;
    private Catalogador catalogador;    
    public ArrayList<Diretorio> listaCompara;

    @FXML
    private TitledPane panelDiretorio1;
    @FXML
    private TitledPane panelDiretorio2;        
    @FXML
    private Label barraStatus1;
    @FXML
    private Label barraStatus2;
    @FXML
    private Label labDiferencasEncontradas;
    @FXML
    private Button btnCompararDiretorios;
    @FXML
    private Button btnSalvarLog;
    @FXML
    private ChoiceBox<Aba> cmbAba1;
    @FXML
    private ChoiceBox<Aba> cmbAba2;
    @FXML
    public ProgressBar pb;
    @FXML
    private BorderPane bpArvoreDiretorio1;
    @FXML
    private BorderPane bpArvoreDiretorio2;
    @FXML
    private VBox vboxTabela;
            
    private Arvore arvoreDiretorio1;
    private Arvore arvoreDiretorio2;    
    private Tabela tabelaCompara;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        frmCompararDiretorioProgresso = new FrmCompararDiretorioProgresso(this);         
        catalogador = FrmPrincipal.getInstancia().getController().getCatalogador();
                
        cmbAba1.getSelectionModel().selectedItemProperty().addListener(
                new ChangeListener<Aba>() {
            @Override
            public void changed(ObservableValue<? extends Aba> observable, 
                    Aba oldValue, Aba newValue) {
                cmbAba1Changed(newValue);
            }
        });
        
        cmbAba2.getSelectionModel().selectedItemProperty().addListener(
                new ChangeListener<Aba>() {
            @Override
            public void changed(ObservableValue<? extends Aba> observable, 
                    Aba oldValue, Aba newValue) {
                cmbAba2Changed(newValue);
            }
        });        
        
        montarArvores();
        listaCompara = new ArrayList<>();
        LimparComparacao();       
    }

    @FXML
    private void btnCompararDiretoriosAction(ActionEvent event) {
        String sCaminhoDir1 = "", sCaminhoDir2 = "";
        boolean bSelecionado;

        bSelecionado = false;
        if (!arvoreDiretorio1.getSelectionModel().isEmpty()) {
            catalogador.LerArvoreDiretorio(
                    arvoreDiretorio1.getSelectionModel().getSelectedItem(),
                    barraStatus2);
            sCaminhoDir1 = barraStatus2.getText();

            if (!arvoreDiretorio2.getSelectionModel().isEmpty()) {
                catalogador.LerArvoreDiretorio(
                        arvoreDiretorio2.getSelectionModel().getSelectedItem(), 
                        barraStatus2);
                sCaminhoDir2 = barraStatus2.getText();
                bSelecionado = true;
            }
        }

        LimparComparacao();

        if (bSelecionado) {
            try {
                Comparar(sCaminhoDir1, sCaminhoDir2);
            } catch (SQLException ex) {
                Logger.getLogger(FrmCompararDiretorioController.class.getName()).
                        log(Level.SEVERE, null, ex);
            }
        } else {
            Dialogo.mensagemInfo("FrmCompararDiretorio.DiretoriosNaoSelecionados");
        }
    }

    @FXML
    private void btnSalvarLogAction(ActionEvent event) {
        String sLog;
        StringList listaLocal;

        if (listaCompara.size() > 0) {
            listaLocal = new StringList();
            sLog = Rotinas.getParams().getDiretorioSistema() + Rotinas.BARRA_INVERTIDA
                    + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, new Date())
                    + "_Comparacao.log";

            for (Diretorio diretorio : listaCompara) {
                listaLocal.add(diretorio.getCaminho());
            }

            try {
                listaLocal.SaveToFile(sLog);
            } catch (IOException ex) {
                Logger.getLogger(FrmCompararDiretorio.class.getName()).log(
                        Level.SEVERE, null, ex);
            }
            Dialogo.mensagemInfo("FrmCompararDiretorio.LogSalvoMemoDirSistema");        
        }
    }
    
    private void cmbAba1Changed(Aba abaSelecionada){
        FrmCompararDiretorio.getInstancia().getScene().setCursor(Cursor.WAIT);
        
	catalogador.CarregarArvore(arvoreDiretorio1, abaSelecionada);
        arvoreDiretorio1.getSelectionModel().select(0);
	LimparComparacao();
        
        FrmCompararDiretorio.getInstancia().getScene().setCursor(Cursor.DEFAULT);
    }        

    private void cmbAba2Changed(Aba abaSelecionada){
        FrmCompararDiretorio.getInstancia().getScene().setCursor(Cursor.WAIT);
        
	catalogador.CarregarArvore(arvoreDiretorio2, abaSelecionada);
        arvoreDiretorio2.getSelectionModel().select(0);
	LimparComparacao();
        
        FrmCompararDiretorio.getInstancia().getScene().setCursor(Cursor.DEFAULT);        
    }        
    
    public void onShown() {
	Aba aba1;
        
        ObservableList<Aba> obsList1
                    = FXCollections.observableArrayList(catalogador.listaAbas);
        cmbAba1.setItems(obsList1);
        cmbAba2.setItems(obsList1);
        
        cmbAba1.getSelectionModel().select(0);
        cmbAba2.getSelectionModel().select(0);

	aba1 = AbaBO.getInstancia().pegaAbaPorOrdem(catalogador.listaAbas, 
                cmbAba1.getSelectionModel().getSelectedIndex() + 1);
	catalogador.CarregarArvore(arvoreDiretorio1, aba1);

	aba1 = AbaBO.getInstancia().pegaAbaPorOrdem(catalogador.listaAbas, 
                cmbAba2.getSelectionModel().getSelectedIndex() + 1);
	catalogador.CarregarArvore(arvoreDiretorio2, aba1);        
    }    
    
    private void montarArvores(){
        arvoreDiretorio1 = new Arvore(null);
        arvoreDiretorio1.setPrefHeight(200.0);
        arvoreDiretorio1.setPrefWidth(200.0);
        BorderPane.setAlignment(arvoreDiretorio1, Pos.CENTER);
        bpArvoreDiretorio1.setCenter(arvoreDiretorio1);

        arvoreDiretorio2 = new Arvore(null);
        arvoreDiretorio2.setPrefHeight(200.0);
        arvoreDiretorio2.setPrefWidth(200.0);
        BorderPane.setAlignment(arvoreDiretorio2, Pos.CENTER);
        bpArvoreDiretorio2.setCenter(arvoreDiretorio2);
    }
    
    private void LimparComparacao() {
        pb.setProgress(0);
        tabelaCompara = new Tabela(catalogador, null, null, pb, false);        
        tabelaCompara.getSelectionModel().select(0);
        if (vboxTabela.getChildren().size()==2)
            vboxTabela.getChildren().add(tabelaCompara);
        else
            vboxTabela.getChildren().set(2, tabelaCompara);
        btnSalvarLog.setDisable(true);
        barraStatus2.setText("");
    }

    private String SQLCompara(Aba aba1, Aba aba2, String caminho1,
            String caminho2) {
        String sSQL;

        sSQL = DiretorioBO.SQL_CONSULTA_ARQUIVO + " WHERE aba=" + aba1.getCodigo()
                + " AND caminho LIKE " + Rotinas.QuotedStr(caminho1 + "%")
                + " AND nome NOT IN (SELECT nome FROM Diretorios "
                + " WHERE aba=" + aba2.getCodigo() + " AND caminho LIKE "
                + Rotinas.QuotedStr(caminho2 + "%") + ")" + " ORDER BY 1, 2, 3";
        return sSQL;
    }

    private void Comparar(String sCaminhoDir1, String sCaminhoDir2) 
            throws SQLException {
        String sSQL;
        Aba aba1, aba2;
        int tamLista;

        aba1 = AbaBO.getInstancia().pegaAbaPorOrdem(catalogador.listaAbas,
                cmbAba1.getSelectionModel().getSelectedIndex() + 1);
        aba2 = AbaBO.getInstancia().pegaAbaPorOrdem(catalogador.listaAbas,
                cmbAba2.getSelectionModel().getSelectedIndex() + 1);

        sSQL = SQLCompara(aba1, aba2, sCaminhoDir1, sCaminhoDir2);
        listaCompara = DiretorioBO.getInstancia().carregarDiretorio(sSQL, 
                frmCompararDiretorioProgresso);

        if (listaCompara.size() > 0) {
            tabelaCompara = new Tabela(catalogador, listaCompara, 
                    catalogador.listaExtensoes, pb, true);
            tabelaCompara.getSelectionModel().select(0);
            vboxTabela.getChildren().set(2, tabelaCompara);
            
            tamLista = listaCompara.size();
            barraStatus2.setText(String.valueOf(tamLista));
            btnSalvarLog.setDisable(false);
        } else {
            Dialogo.mensagemInfo(
                    "FrmCompararDiretorio.NenhumaDiferencaEncontrada");
        }
    }
    
    public void mudarLingua() {
	btnCompararDiretorios.setText(
                Rotinas.getRecurso("FrmCompararDiretorio.btnCompararDiretorios")); 
	btnSalvarLog.setText(
                Rotinas.getRecurso("FrmCompararDiretorio.btnSalvarLog"));
	panelDiretorio1.setText(
                Rotinas.getRecurso("FrmCompararDiretorio.panelDiretorio1"));
	panelDiretorio2.setText(
                Rotinas.getRecurso("FrmCompararDiretorio.panelDiretorio2"));	
	labDiferencasEncontradas.setText(
                Rotinas.getRecurso("FrmCompararDiretorio.labDiferencasEncontradas"));
	barraStatus1.setText(
                Rotinas.getRecurso("FrmCompararDiretorio.barraStatus1"));
    }    
    
}
