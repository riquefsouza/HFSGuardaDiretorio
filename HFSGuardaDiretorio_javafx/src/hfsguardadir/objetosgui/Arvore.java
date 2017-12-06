package hfsguardadir.objetosgui;

import hfsguardadir.comum.Rotinas;
import javafx.beans.property.BooleanProperty;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.scene.control.TreeItem;
import javafx.scene.control.TreeView;
import javafx.scene.image.ImageView;

public class Arvore extends TreeView<String> {

    public Arvore(TreeItem<String> root) {
        super(root);

        setShowRoot(false);
        setEditable(false);        

        this.getSelectionModel().selectedIndexProperty().addListener(
                new ChangeListener<Number>() {
            @Override
            public void changed(ObservableValue<? extends Number> observable, 
                    Number oldValue, Number newValue) {
                selecaoValorMudou(newValue);
            }
        });
        /*
        this.getSelectionModel().selectedItemProperty().addListener(new ChangeListener<TreeItem<String>>() {

            @Override
            public void changed(ObservableValue<? extends TreeItem<String>> observable, 
                    TreeItem<String> oldValue, TreeItem<String> newValue) {
                mudarImagem(newValue);
            }
        });
        */
    }
    
    public void selecaoValorMudou(Number valor) {        
        this.scrollTo(valor.intValue());
    }

    public void alterarTextoNode(TreeItem<String> pai, String texto) {
        pai.setValue(texto);
    }

    public void alterarTextoNodeSelecionado(String texto) {
        this.getSelectionModel().getSelectedItem().setValue(texto);
    }

    public void alterarTextoNodeRaiz(String texto) {
        this.getRoot().setValue(texto);
    }
    
    public void excluirNode(TreeItem<String> pai) {
        this.getRoot().getChildren().remove(pai);
    }
    
    public void excluirNode(String[] nomes) {
        TreeItem<String> item = encontrarCaminhoPorNome(nomes);
        this.excluirNode(item);
    }

    public TreeItem<String> encontrarCaminhoPorNome(String[] nomes) {
        return encontrarCaminho(this.getRoot(), nomes, 0);
    }

    private TreeItem<String> encontrarCaminho(TreeItem<String> pai,
            String[] nodes, int depth) {
        // Se igual, vai para baixo        
        if (pai.getValue().equals(nodes[depth])) {
            // Se chegou no fim, retorna alvo
            if (depth == nodes.length - 1) {
                return pai;
            }
            // Atravesa filhos
            if (pai.getChildren().size() >= 0) {
                for (TreeItem<String> item : pai.getChildren()) {
                    TreeItem<String> resultado = encontrarCaminho(item, nodes,
                            depth + 1);
                    // Encontrou um alvo
                    if (resultado != null) {
                        return resultado;
                    }
                }
            }
        }

        // Nenhum alvo encontrado
        return null;
    }

    // Se expandir e true, expande todos os nodes na arvore.
    // senao, colapsa todos os nodes na arvore.
    public void expandeTodos(boolean expandir) {
        // atravesa a arvore da raiz
        expandeTodos(this.getRoot(), expandir);
    }

    public void expandeTodos(TreeItem<String> pai, boolean expandir) {
        // atravesa o filho
        if (pai.getChildren().size() >= 0) {
            for (TreeItem<String> filho : pai.getChildren()) {
                filho.setExpanded(expandir);                
                expandeTodos(filho, expandir);
            }
        }

    }
}
