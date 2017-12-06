package hfsguardadir.gui;

import hfsguardadir.catalogador.Catalogador;
import hfsguardadir.gui.controller.FrmSplashController;
import hfsguardadir.objetosgui.FrmDialogo;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.concurrent.Task;
import javafx.event.EventHandler;
import javafx.stage.StageStyle;
import javafx.stage.WindowEvent;

public class FrmSplash extends FrmDialogo {

    private static FrmSplash instancia;
    
    private final FrmSplashController controller;

    private final FrmSplashProgresso frmSplashProgresso;
            
    //private Catalogador catalogador;
    
    private final Task tarefaSplash;
    /*
    public static FrmSplash getInstancia() {
        if (instancia == null) {
            instancia = new FrmSplash();
        }
        return instancia;
    }
    */
    public FrmSplash(Catalogador catalogador) {
        super("FrmSplash", "Splash", 400, 110, StageStyle.UNDECORATED);
        controller = (FrmSplashController) loader.getController();
        
        frmSplashProgresso = new FrmSplashProgresso(controller);
        
        this.setOnShown(new EventHandler<WindowEvent>() {
            @Override
            public void handle(WindowEvent event) {
                FrmSplashOnShown(event);
            }
        });
        
        //this.catalogador=catalogador;
        
        tarefaSplash = new Task() {
            @Override
            protected Object call() throws Exception {
                catalogador.carregarDados(frmSplashProgresso);
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

        //controller.pb.progressProperty().unbind();
        //controller.pb.progressProperty().bind(tarefaSplash.progressProperty());        
        
        tarefaSplash.runningProperty().addListener(new ChangeListener<Boolean>() {
            @Override
            public void changed(ObservableValue<? extends Boolean> observable, 
                    Boolean oldValue, Boolean newValue) {
                if (newValue.booleanValue()==false){                    
                    close();
                }
            }
        });

    }

    public FrmSplashController getController(){
        return controller;
    }    

    private void FrmSplashOnShown(WindowEvent event) {
        new Thread(tarefaSplash).start();
    }    
}
