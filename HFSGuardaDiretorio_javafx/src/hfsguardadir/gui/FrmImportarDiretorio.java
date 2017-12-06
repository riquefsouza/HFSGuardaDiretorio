package hfsguardadir.gui;

import hfsguardadir.comum.Rotinas;
import hfsguardadir.gui.controller.FrmImportarDiretorioController;
import hfsguardadir.objetosgui.FrmDialogo;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.concurrent.Task;
import javafx.event.EventHandler;
import javafx.scene.Cursor;
import javafx.stage.WindowEvent;

public class FrmImportarDiretorio extends FrmDialogo {
    
    private static FrmImportarDiretorio instancia;
    
    private final FrmImportarDiretorioController controller;

    private final Task tarefaImportar;
    
    public static FrmImportarDiretorio getInstancia() {
        if (instancia == null) {
            instancia = new FrmImportarDiretorio();
        }
        return instancia;
    }    
    
    private FrmImportarDiretorio(){
        super("FrmImportarDiretorio","Importando Diretório", 895, 572);
        controller = (FrmImportarDiretorioController) loader.getController();
        mudarLingua();
        
        this.setOnShown(new EventHandler<WindowEvent>() {
            @Override
            public void handle(WindowEvent event) {
                FrmImportarDiretorioOnShown(event);
            }
        });
        
        tarefaImportar = new Task() {
            @Override
            protected Object call() throws Exception {
                controller.OnShown();
                /*
                for (int i = 0; i < 10; i++) {
                    Thread.sleep(2000);
                    updateMessage("2000 milliseconds");
                    updateProgress(i + 1, 10);
                } 
                */
                return true;
            }
        };

        //controller.pbImportar.progressProperty().unbind();
        //controller.pbImportar.progressProperty().bind(tarefaImportar.progressProperty());
        
        tarefaImportar.runningProperty().addListener(new ChangeListener<Boolean>() {
            @Override
            public void changed(ObservableValue<? extends Boolean> observable, 
                    Boolean oldValue, Boolean newValue) {
                if (newValue.booleanValue()==false){                    
                    close();
                }
            }
        });
        
    }

    public FrmImportarDiretorioController getController(){
        return controller;
    }    
    
    public void mudarLingua() {        
        setTitle(Rotinas.getRecurso("FrmImportarDiretorio.titulo"));
        controller.mudarLingua();
    }
    
    private void FrmImportarDiretorioOnShown(WindowEvent event) {
        new Thread(tarefaImportar).start();
    }
    
}
