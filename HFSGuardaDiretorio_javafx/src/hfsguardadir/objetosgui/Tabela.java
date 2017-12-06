package hfsguardadir.objetosgui;

import hfsguardadir.comum.ICatalogador;
import hfsguardadir.comum.Rotinas;
import hfsguardadir.objetos.Aba;
import hfsguardadir.objetos.Diretorio;
import hfsguardadir.objetos.Extensao;
import hfsguardadir.objetos.Tipo;
import hfsguardadir.objetosbo.ExtensaoBO;
import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.EventHandler;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.SelectionMode;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.util.Callback;

public class Tabela extends TableView<Diretorio> {

    private boolean bTabelaDir;

    //private boolean sombrearLinhas;

    //private boolean sombrearColunas;

    private ICatalogador catalogador;
    
    private TableColumn<Diretorio, String> colunaNome;
    //private TableColumn<Diretorio, Long> colunaTamanho;
    //private TableColumn<Diretorio, Date> colunaModificado;
    private TableColumn<Diretorio, String> colunaAtributos;    
    private TableColumn<Diretorio, Aba> colunaAba;    
    //private TableColumn<Diretorio, int> colunaCodigo;
    //private TableColumn<Diretorio, int> colunaOrdem;
    //private TableColumn<Diretorio, int> colunaCodDirPai;
    private TableColumn<Diretorio, Tipo> colunaTipo;
    private TableColumn<Diretorio, String> colunaCaminho;
    //private TableColumn<Diretorio, String> colunaNomePai;
    //private TableColumn<Diretorio, String> colunaCaminhoPai;
    private TableColumn<Diretorio, String> colunaTamanhoFormatado;
    private TableColumn<Diretorio, String> colunaModificadoFormatado;
    //private TableColumn<Diretorio, String> colunaCaminhoOriginal;
    

    public Tabela(ICatalogador catalogador, ArrayList<Diretorio> diretorios,
            ArrayList<Extensao> extensoes,
            ProgressBar barraProgresso, boolean bTabelaDir) {
        super();
        this.catalogador = catalogador;
        this.bTabelaDir = bTabelaDir;
        //this.sombrearLinhas = false;
        //this.sombrearColunas = false;

        this.setEditable(false);
        this.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
        
        this.setOnMouseClicked(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent event) {
                mouseClicou(event);
            }
        });
        this.getSelectionModel().selectedIndexProperty().addListener(
                new ChangeListener<Number>() {
            @Override
            public void changed(ObservableValue<? extends Number> observable, 
                    Number oldValue, Number newValue) {
                selecaoValorMudou(newValue);
            }
        });
        
        modeloColunas(bTabelaDir, extensoes);
        modeloTabela(diretorios, barraProgresso, bTabelaDir);
    }
    
    public void selecaoValorMudou(Number valor) {
        //this.scrollTo(valor.intValue());
    }
    
    public int encontrarLinha(String nome) {
        int nlinha = 0;
        for (Diretorio dir: this.getItems()) {
            if (dir.getNome().equals(nome)) {                
                break;
            }
            nlinha++;
        }
        return nlinha;
    }

    public Diretorio getLinhaSelecionada(boolean bTabelaDir){
        Diretorio dir = null;
        
        if (this.getSelectionModel().getSelectedIndex() >= 0) {        
            dir = this.getSelectionModel().getSelectedItem();
        }
        
        return dir;
    }
    
    private void modeloColunas(boolean bTabelaDir, ArrayList<Extensao> extensoes){
        colunaNome = new TableColumn<>(Rotinas.getRecurso("Tabela.nome"));
        colunaNome.setCellValueFactory(new PropertyValueFactory<>("nome"));
        colunaNome.setEditable(false);        
        
        colunaTamanhoFormatado = new TableColumn<>(Rotinas.getRecurso("Tabela.tamanho"));
        colunaTamanhoFormatado.setCellValueFactory(new PropertyValueFactory<>("tamanhoFormatado"));
        colunaTamanhoFormatado.setEditable(false);

        colunaTipo = new TableColumn<>(Rotinas.getRecurso("Tabela.tipo"));        
        colunaTipo.setCellValueFactory(new PropertyValueFactory<>("tipo"));
        colunaTipo.setEditable(false);                        

        colunaModificadoFormatado = new TableColumn<>(Rotinas.getRecurso("Tabela.modificado"));        
        colunaModificadoFormatado.setCellValueFactory(new PropertyValueFactory<>("modificadoFormatado"));
        colunaModificadoFormatado.setEditable(false);                        

        colunaAtributos = new TableColumn<>(Rotinas.getRecurso("Tabela.atributos"));        
        colunaAtributos.setCellValueFactory(new PropertyValueFactory<>("atributos"));
        colunaAtributos.setEditable(false);                        

        colunaCaminho = new TableColumn<>(Rotinas.getRecurso("Tabela.caminho"));        
        colunaCaminho.setCellValueFactory(new PropertyValueFactory<>("caminho"));
        colunaCaminho.setEditable(false);                        

        if (!bTabelaDir) {
            colunaAba = new TableColumn<>(Rotinas.getRecurso("Tabela.aba"));
            colunaAba.setCellValueFactory(new PropertyValueFactory<>("aba"));
            colunaAba.setEditable(false);
        }
        
        colunaNome.setPrefWidth(300);
        colunaTamanhoFormatado.setPrefWidth(100);
        colunaTipo.setPrefWidth(70);
        colunaModificadoFormatado.setPrefWidth(120);
        colunaAtributos.setPrefWidth(90);
        colunaCaminho.setPrefWidth(500);
        
        colunaNome.setCellFactory(new Callback<TableColumn<Diretorio, String>, 
                TableCell<Diretorio, String>>() {
            @Override
            public TableCell<Diretorio, String> call(TableColumn<Diretorio, String> param) {
                TableCell<Diretorio, String> cell = new NomeTableCell(extensoes);
                return cell;
            }
        });        
        
        this.getColumns().add(colunaNome);
        this.getColumns().add(colunaTamanhoFormatado);
        this.getColumns().add(colunaTipo);
        this.getColumns().add(colunaModificadoFormatado);
        this.getColumns().add(colunaAtributos);
        this.getColumns().add(colunaCaminho);

        if (!bTabelaDir) {
            colunaAba.setPrefWidth(100);
            this.getColumns().add(colunaAba);            
        }
    }
    
    private void modeloTabela(ArrayList<Diretorio> diretorios,
            ProgressBar barraProgresso, boolean bTabelaDir) {

        if (diretorios != null) {
            ObservableList<Diretorio> obsList = 
                    FXCollections.observableArrayList(diretorios);
            this.setItems(obsList);
            
/*            
            barraProgresso.setProgress(0);

            for (Diretorio Campos : diretorios) {
                novaLinha = new Vector();

                novaLinha.addElement(Campos.getNome());
                if (Campos.getTipo().getCodigo() == 'D') {
                    novaLinha.addElement("");
                } else {
                    novaLinha.addElement(Campos.getTamanhoFormatado());
                }
                novaLinha.addElement(Campos.getTipo().getNome());
                novaLinha.addElement(Campos.getModificadoFormatado());
                novaLinha.addElement(Campos.getAtributos());
                novaLinha.addElement(Campos.getCaminho());
                
                if (!bTabelaDir){
                    novaLinha.addElement(Campos.getAba().getNome());
                }
                
                Linhas.addElement(novaLinha);
                
                barraProgresso.setProgress(
                        (diretorios.size()*barraProgresso.getProgress())/100);
                //barraProgresso.getUI().update(barraProgresso.getGraphics(),barraProgresso);
            }
            barraProgresso.setProgress(0);
        */
        }
    }
    /*
    private void acomodaColuna(int vColIndex, int margin) {        
        double width = this.getColumns().get(vColIndex).getPrefWidth();

        this.getr
        
        // pega a largura maxima do dado da coluna        
        //TableRow<Diretorio> linha = this.getRowFactory().call(this);
        for (Diretorio linha: this.getItems()) {
            width = Math.max(width, linha.);
        }

        // Adiciona margem
        width += 2 * margin;

        // atribui a largura
        this.getColumns().get(vColIndex).setPrefWidth(width);
    }

    private void acomodaColunas(int margin) {
        for (int c = 0; c < table.getColumnCount(); c++) {
            acomodaColuna(c, margin);
        }
    }
    */
    
    private void mouseClicou(MouseEvent evt) {        
        if (this.getSelectionModel().getSelectedItems().size() >= 0) {
            Diretorio dir = this.getSelectionModel().getSelectedItem();

            if (bTabelaDir) {
                if (evt.getClickCount() == 2) {
                    catalogador.DuploCliqueLista(dir.getNome(), 
                            dir.getTipo().getNome());
                }
            } else {
                if (evt.getClickCount() == 1) {
                    catalogador.EncontrarItemLista(dir.getAba().getCodigo(),
                            dir.getNome(), dir.getCaminho());
                }
            }
        }
    }    
}

class NomeTableCell extends TableCell<Diretorio, String> {
    HBox hb;
    ImageView imageview;
    Label labNome;
    ArrayList<Extensao> extensoes;
    
    public NomeTableCell(ArrayList<Extensao> extensoes){
        this.extensoes = extensoes;
        hb = new HBox();        
        imageview = new ImageView();
        imageview.setFitHeight(16);
        imageview.setFitWidth(16);
        imageview.setVisible(true);
        imageview.setCache(true);   
        labNome = new Label();
        hb.getChildren().addAll(imageview, labNome);
        setGraphic(hb);
    }

    @Override
    protected void updateItem(String nome, boolean empty) {
        super.updateItem(nome, empty);
        
        if (empty) {
            setText(null);
            setGraphic(null);
        } else {
            labNome.setText(nome);
            
            Diretorio dir = (Diretorio)this.getTableRow().getItem();
            
            String ext = nome.substring(nome.lastIndexOf('.') + 1);
            Extensao extensao = ExtensaoBO.getInstancia().
                    pegaExtensaoPorNome(extensoes, ext, dir.getTipo().getNome());
            if (extensao!=null) {
                if (extensao.getGif16()!=null) {
                    imageview.setImage(new Image(
                        new ByteArrayInputStream(extensao.getGif16())));
                    setGraphic(hb);
                } else {
                    setGraphic(null);
                }
            }            
        }
    } 

}