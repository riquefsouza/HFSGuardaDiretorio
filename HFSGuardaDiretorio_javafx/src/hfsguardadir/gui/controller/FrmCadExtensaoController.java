package hfsguardadir.gui.controller;

import hfsguardadir.catalogador.Catalogador;
import hfsguardadir.comum.Rotinas;
import hfsguardadir.comum.StringList;
import static hfsguardadir.comum.TipoExportarExtensao.teBMP;
import static hfsguardadir.comum.TipoExportarExtensao.teGIF;
import static hfsguardadir.comum.TipoExportarExtensao.teICO;
import static hfsguardadir.comum.TipoExportarExtensao.teJPG;
import static hfsguardadir.comum.TipoExportarExtensao.tePNG;
import static hfsguardadir.comum.TipoExportarExtensao.teTIF;
import hfsguardadir.gui.FrmCadExtensao;
import hfsguardadir.gui.FrmPrincipal;
import hfsguardadir.objetos.Extensao;
import hfsguardadir.objetosbo.ExtensaoBO;
import hfsguardadir.objetosgui.Dialogo;
import hfsguardadir.objetosgui.EscolhaArquivo;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.Optional;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuItem;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.VBox;
import javafx.util.Callback;

public class FrmCadExtensaoController implements Initializable {

    private Catalogador catalogador;

    @FXML
    private Button btnExcluir;
    @FXML
    private Button btnIncluir;
    @FXML
    private Menu menuExtensao;
    @FXML
    private MenuItem menuIncluirExtensao;
    @FXML
    private MenuItem menuExcluirExtensao;
    @FXML
    private MenuItem menuExcluirTodasExtensoes;
    @FXML
    private Menu menuExportarTodos;
    @FXML
    private MenuItem menuExportarBitmap;
    @FXML
    private MenuItem menuExportarGIF;
    @FXML
    private MenuItem menuExportarIcone;
    @FXML
    private MenuItem menuExportarJPEG;
    @FXML
    private MenuItem menuExportarPNG;
    @FXML
    private MenuItem menuExportarTIFF;
    @FXML
    private Menu menuImportarTodos;
    @FXML
    private MenuItem menuExtrairIconesArquivos;
    @FXML
    private MenuItem menuImportarIconesArquivos;
    @FXML
    private TableView tabelaExtensao;
    @FXML
    private TableColumn<Extensao, String> colunaExtensao;
    @FXML
    private TableColumn<Extensao, byte[]> colunaIcone;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        catalogador = FrmPrincipal.getInstancia().getController().getCatalogador();

        colunaExtensao.setCellValueFactory(new PropertyValueFactory<>("nome"));
        colunaExtensao.setEditable(false);
        colunaIcone.setCellValueFactory(new PropertyValueFactory<>("gif16"));
        colunaIcone.setEditable(false);
        
        colunaIcone.setCellFactory(new Callback<TableColumn<Extensao, byte[]>, 
                TableCell<Extensao, byte[]>>() {
            @Override
            public TableCell<Extensao, byte[]> call(TableColumn<Extensao, byte[]> param) {
                TableCell<Extensao, byte[]> cell = new IconeTableCell();
                return cell;
            }
        });

        CarregarExtensoesNaGrid();
    }

    @FXML
    private void btnExcluirAction(ActionEvent event) {
        menuExcluirExtensaoAction(event);
    }

    @FXML
    private void btnIncluirAction(ActionEvent event) {
        menuIncluirExtensaoAction(event);
    }

    @FXML
    private void menuIncluirExtensaoAction(ActionEvent event) {
        StringList log;
        EscolhaArquivo escolha = new EscolhaArquivo(
                EscolhaArquivo.PREVIEW_OPEN_DIALOG);
        File arquivo = escolha.mostrarAbrir(FrmCadExtensao.getInstancia());
        if (arquivo != null) {
            log = new StringList();
            try {
                if (ExtensaoBO.getInstancia().SalvarExtensao(
                        catalogador.listaExtensoes, arquivo.getName(),
                        arquivo.getAbsolutePath(), log)) {

                    CarregarExtensoesNaGrid();

                    Dialogo.mensagemInfo(
                            "FrmCadExtensao.ExtensaoSalvaSucesso");
                } else {
                    Dialogo.mensagemInfo(
                            "FrmCadExtensao.ExtensaoJaCadastrada");
                }
            } catch (SQLException ex) {
                Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                        Level.SEVERE, null, ex);
            }
        }
    }

    @FXML
    private void menuExcluirExtensaoAction(ActionEvent event) {
        Extensao extensao;

        if (catalogador.listaExtensoes.size() > 0) {
            Optional<ButtonType> res = Dialogo.confirma(
                    "FrmCadExtensao.ExtensaoCertezaExcluir");
            if (res.get() == ButtonType.OK) {
                extensao = ExtensaoBO.getInstancia().pegaExtensaoPorOrdem(
                        catalogador.listaExtensoes,
                        tabelaExtensao.getSelectionModel().getSelectedIndex() + 1);

                try {
                    if (ExtensaoBO.getInstancia().excluirExtensao(
                            catalogador.listaExtensoes, extensao.getCodigo())) {
                        CarregarExtensoesNaGrid();
                        Dialogo.mensagemInfo(
                                "FrmCadExtensao.ExtensaoExcluidaSucesso");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                            Level.SEVERE, null, ex);
                }
            }
        }
    }

    @FXML
    private void menuExcluirTodasExtensoesAction(ActionEvent event) {
        if (catalogador.listaExtensoes.size() > 0) {
            Optional<ButtonType> res = Dialogo.confirma(
                    "FrmCadExtensao.ExtensaoCertezaTodosExcluir");
            if (res.get() == ButtonType.OK) {
                try {
                    if (ExtensaoBO.getInstancia().excluirTodasExtensoes(
                            catalogador.listaExtensoes)) {
                        CarregarExtensoesNaGrid();
                        Dialogo.mensagemInfo(
                                "FrmCadExtensao.ExtensoesExcluidasSucesso");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                            Level.SEVERE, null, ex);
                }
            }
        }
    }

    @FXML
    private void menuExportarBitmapAction(ActionEvent event) {
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(teBMP,
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo("FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }
    }

    @FXML
    private void menuExportarGIFAction(ActionEvent event) {
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(teGIF,
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo("FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }
    }

    @FXML
    private void menuExportarIconeAction(ActionEvent event) {
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(teICO,
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo("FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }
    }

    @FXML
    private void menuExportarJPEGAction(ActionEvent event) {
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(teJPG,
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo("FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }
    }

    @FXML
    private void menuExportarPNGAction(ActionEvent event) {
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(tePNG,
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo("FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }
    }

    @FXML
    private void menuExportarTIFFAction(ActionEvent event) {
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(teTIF,
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo("FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }
    }

    @FXML
    private void menuExtrairIconesArquivosAction(ActionEvent event) {
        String sCaminho;
        EscolhaArquivo escolha = new EscolhaArquivo(
                EscolhaArquivo.CUSTOM_DIALOG);
        File arquivo = escolha.mostrar(FrmCadExtensao.getInstancia());
        if (arquivo != null) {
            sCaminho = arquivo.getPath();
            try {
                ExtensaoBO.getInstancia().ExtrairExtensao(sCaminho,
                        catalogador.listaExtensoes);
                CarregarExtensoesNaGrid();
            } catch (SQLException ex) {
                Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                        Level.SEVERE, null, ex);
            }
        }
    }

    @FXML
    private void menuImportarIconesArquivosAction(ActionEvent event) {
        String sCaminho;
        EscolhaArquivo escolha = new EscolhaArquivo(
                EscolhaArquivo.CUSTOM_DIALOG);
        File arquivo = escolha.mostrar(FrmCadExtensao.getInstancia());
        if (arquivo != null) {
            sCaminho = arquivo.getPath();
            try {
                ExtensaoBO.getInstancia().ImportarExtensao(sCaminho,
                        catalogador.listaExtensoes);
                CarregarExtensoesNaGrid();
            } catch (SQLException ex) {
                Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                        Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(FrmCadExtensaoController.class.getName()).log(
                        Level.SEVERE, null, ex);
            }
        }
    }

    private void CarregarExtensoesNaGrid() {
        ObservableList<Extensao> obsList
                = FXCollections.observableArrayList(catalogador.listaExtensoes);
        tabelaExtensao.setItems(obsList);
        tabelaExtensao.getSelectionModel().select(0);
    }

    public void mudarLingua() {
        btnIncluir.setText(Rotinas.getRecurso("FrmCadExtensao.btnIncluir"));
        btnExcluir.setText(Rotinas.getRecurso("FrmCadExtensao.btnExcluir"));
        menuExtensao.setText(Rotinas.getRecurso("FrmCadExtensao.menuExtensao"));
        menuIncluirExtensao.setText(Rotinas.getRecurso("FrmCadExtensao.menuIncluirExtensao"));
        menuExcluirExtensao.setText(Rotinas.getRecurso("FrmCadExtensao.menuExcluirExtensao"));
        menuExcluirTodasExtensoes.setText(Rotinas.getRecurso("FrmCadExtensao.menuExcluirTodasExtensoes"));
        menuExportarTodos.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarTodos"));
        menuExportarBitmap.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarBitmap"));
        menuExportarIcone.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarIcone"));
        menuExportarGIF.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarGIF"));
        menuExportarJPEG.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarJPEG"));
        menuExportarPNG.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarPNG"));
        menuExportarTIFF.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarTIFF"));
        menuImportarTodos.setText(Rotinas.getRecurso("FrmCadExtensao.menuImportarTodos"));
        menuImportarIconesArquivos.setText(Rotinas.getRecurso("FrmCadExtensao.menuImportarIconesArquivos"));
        menuExtrairIconesArquivos.setText(Rotinas.getRecurso("FrmCadExtensao.menuExtrairIconesArquivos"));
    }
}

class IconeTableCell extends TableCell<Extensao, byte[]> {
    VBox vb;
    ImageView imageview;
    
    public IconeTableCell(){        
        vb = new VBox();
        vb.setAlignment(Pos.CENTER);
        imageview = new ImageView();
        imageview.setFitHeight(16);
        imageview.setFitWidth(16);
        imageview.setVisible(true);
        imageview.setCache(true);
        vb.getChildren().addAll(imageview);
        setGraphic(vb);
    }

    @Override
    protected void updateItem(byte[] item, boolean empty) {
        super.updateItem(item, empty);
        
        if (empty) {
            setText(null);
            setGraphic(null);
        } else {
            imageview.setImage(new Image(
                new ByteArrayInputStream(item)));
            setGraphic(vb);
        }
    } 

}