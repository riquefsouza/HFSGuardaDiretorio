package hfsguardadir.gui.controller;

import hfsguardadir.catalogador.Catalogador;
import hfsguardadir.comum.Rotinas;
import hfsguardadir.comum.StringList;
import hfsguardadir.gui.FrmImportarDiretorio;
import hfsguardadir.gui.FrmImportarDiretorioProgresso;
import hfsguardadir.gui.FrmPrincipal;
import hfsguardadir.objetos.Diretorio;
import hfsguardadir.objetos.Importar;
import hfsguardadir.objetosbo.DiretorioBO;
import hfsguardadir.objetosbo.ImportarBO;
import hfsguardadir.objetosgui.Dialogo;
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
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.SelectionMode;

public class FrmImportarDiretorioController implements Initializable {
    private FrmImportarDiretorioProgresso frmImportarDiretorioProgresso;    
    private Catalogador catalogador;

    public boolean bSubDiretorio;
    public ArrayList<Importar> listaImportar;
    public ArrayList<Diretorio> listaDiretorio;

    @FXML
    public ListView<String> memoImportaDir;
    @FXML
    private Label barraStatus1;
    @FXML
    public Label barraStatus2;
    @FXML
    public ProgressBar pbImportar;
    

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        frmImportarDiretorioProgresso = new FrmImportarDiretorioProgresso(this);
        listaImportar = new ArrayList<>();        
        catalogador = FrmPrincipal.getInstancia().getController().getCatalogador();
        
        memoImportaDir.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
        memoImportaDir.setEditable(false);
        memoImportaDir.getSelectionModel().selectedIndexProperty().addListener(
                new ChangeListener<Number>() {
            @Override
            public void changed(ObservableValue<? extends Number> observable, 
                    Number oldValue, Number newValue) {
                valorSelecionadoMudou(newValue);
            }
        });
        
    }
    
    private void valorSelecionadoMudou(Number valor) {
        memoImportaDir.scrollTo(valor.intValue());
    }
    
    public void OnShown() {
        String sLog;
        StringList log = new StringList();

        for (Importar importar : this.listaImportar) {
            catalogador.diretorioOrdem.setOrdem(1);

            if (!bSubDiretorio) {
                //setCursor(Cursor.WAIT_CURSOR);

                try {
                    ImportarBO.getInstancia().ImportacaoCompleta(importar,
                            catalogador.diretorioOrdem, catalogador.listaExtensoes,
                            frmImportarDiretorioProgresso);
                } catch (SQLException ex) {
                    Logger.getLogger(FrmImportarDiretorio.class.getName()).
                            log(Level.SEVERE, null, ex);
                }

                //setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
            } else {
                if (!DiretorioBO.getInstancia().verificaCodDir(importar.getAba(),
                        importar.getRotuloRaiz(), catalogador.listaDiretorioPai)) {
                    //setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));

                    try {
                        ImportarBO.getInstancia().ImportacaoCompleta(importar,
                                catalogador.diretorioOrdem, catalogador.listaExtensoes,
                                frmImportarDiretorioProgresso);
                    } catch (SQLException ex) {
                        Logger.getLogger(FrmImportarDiretorio.class.getName()).
                                log(Level.SEVERE, null, ex);
                    }

                    //setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
                } else {
                    Dialogo.mensagemInfo(
                            "FrmImportarDiretorio.DiretorioExisteCatalogo");
                }
            }
        }

        if (FrmPrincipal.getInstancia().getController().menuGravarLogImportacao.isSelected()) {            
            if (!memoImportaDir.getItems().isEmpty()) {
                sLog = Rotinas.getParams().getDiretorioSistema() + Rotinas.BARRA_INVERTIDA 
                    + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, new Date()) 
                    + "_Importacao.log";
                try {                    
                    Rotinas.SaveToFile(memoImportaDir.getItems(), sLog);
                } catch (IOException ex) {
                    Logger.getLogger(FrmImportarDiretorio.class.getName()).log(
                            Level.SEVERE, null, ex);
                }
            }
        } 
    }

    public void mudarLingua() {        
        barraStatus1.setText(Rotinas.getRecurso("FrmImportarDiretorio.barraStatus1"));
    }    

}
