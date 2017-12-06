package hfsguardadir.gui.controller;

import hfsguardadir.comum.Rotinas;
import hfsguardadir.gui.FrmInfoDiretorio;
import hfsguardadir.objetos.Diretorio;
import hfsguardadir.objetos.InfoDiretorio;
import java.net.URL;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

public class FrmInfoDiretorioController implements Initializable {
    
    @FXML
    private Label labArquivoComum;
    @FXML
    private Label labArquivoOculto;
    @FXML
    private Label labArquivoSistema;
    @FXML
    private Label labLegendaDiretorio;
    @FXML
    private Label labVolumeID;
    @FXML
    private Label labArquivoSomenteLeitura;
    @FXML
    private Button btnOk;
    @FXML
    private TableView tabelaInfo;
    @FXML
    private TableColumn<InfoDiretorio, String> colunaItem;
    @FXML
    private TableColumn<InfoDiretorio, String> colunaDescricao;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        colunaItem.setCellValueFactory(new PropertyValueFactory<>("item"));
        colunaDescricao.setCellValueFactory(new PropertyValueFactory<>("descricao"));
    }

    @FXML
    protected void btnOkAction(ActionEvent event) {
        FrmInfoDiretorio.getInstancia().close();
    }

    public void setDiretorio(Diretorio diretorio) {
        ArrayList<InfoDiretorio> info;

        if (diretorio != null) {
            info = new ArrayList<>();
            info.add(new InfoDiretorio(Rotinas.getRecurso("Tabela.aba") + ":", 
                    diretorio.getAba().getNome()));
            info.add(new InfoDiretorio(Rotinas.getRecurso("Tabela.nome") + ":", 
                    diretorio.getNome()));
            info.add(new InfoDiretorio(Rotinas.getRecurso("Tabela.tamanho") + ":", 
                    diretorio.getTamanhoFormatado()));
            info.add(new InfoDiretorio(Rotinas.getRecurso("Tabela.tipo") + ":", 
                    diretorio.getTipo().getNome()));
            info.add(new InfoDiretorio(Rotinas.getRecurso("Tabela.modificado") + ":", 
                    diretorio.getModificadoFormatado()));
            info.add(new InfoDiretorio(Rotinas.getRecurso("Tabela.atributos") + ":", 
                    diretorio.getAtributos()));
            info.add(new InfoDiretorio(Rotinas.getRecurso("Tabela.caminho") + ":", 
                    diretorio.getCaminho()));

            colunaDescricao.setPrefWidth(diretorio.getCaminho().length() * 7);

            ObservableList<InfoDiretorio> obsList
                    = FXCollections.observableArrayList(info);
            tabelaInfo.setItems(obsList);
            tabelaInfo.getSelectionModel().select(0);
        }
    }
    
     public void mudarLingua() {
        labArquivoComum.setText(Rotinas.getRecurso("FrmInfoDiretorio.labArquivoComum"));
        labArquivoOculto.setText(Rotinas.getRecurso("FrmInfoDiretorio.labArquivoOculto"));
        labArquivoSistema.setText(Rotinas.getRecurso("FrmInfoDiretorio.labArquivoSistema"));
        labLegendaDiretorio.setText(Rotinas.getRecurso("FrmInfoDiretorio.labDiretorio"));
        labVolumeID.setText(Rotinas.getRecurso("FrmInfoDiretorio.labVolumeID"));
        labArquivoSomenteLeitura.setText(
        Rotinas.getRecurso("FrmInfoDiretorio.labArquivoSomenteLeitura"));

        colunaItem.setText(Rotinas.getRecurso("FrmInfoDiretorio.item"));
        colunaDescricao.setText(Rotinas.getRecurso("FrmInfoDiretorio.descricao"));        
     }    
     
}
