package hfsguardadir.gui.controller;

import hfsguardadir.comum.Rotinas;
import hfsguardadir.gui.FrmSobre;
import hfsguardadir.objetos.PropriedadeSistema;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

public class FrmSobreController implements Initializable {

    @FXML
    private Button btnOk;

    @FXML
    private TableView<PropriedadeSistema> tabelaPropriedades;
    
    @FXML
    private TableColumn<PropriedadeSistema, String> colunaPropriedade;

    @FXML
    private TableColumn<PropriedadeSistema, String> colunaValor;
       
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        colunaPropriedade.setCellValueFactory(new PropertyValueFactory<>("nome"));
        colunaValor.setCellValueFactory(new PropertyValueFactory<>("valor"));
        
        ObservableList<PropriedadeSistema> obsList = 
                FXCollections.observableArrayList(Rotinas.getPropriedadesSistema());
        tabelaPropriedades.setItems(obsList);
        tabelaPropriedades.getSelectionModel().select(0);
        
        colunaPropriedade.setPrefWidth(Rotinas.nMaxNome*6);
        colunaValor.setPrefWidth(Rotinas.nMaxValor*5);
        
    }

    @FXML
    protected void btnOkAction(ActionEvent event) {
        FrmSobre.getInstancia().close();
    }

}
