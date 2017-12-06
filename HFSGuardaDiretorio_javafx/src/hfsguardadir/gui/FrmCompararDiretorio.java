package hfsguardadir.gui;

import hfsguardadir.comum.Rotinas;
import hfsguardadir.gui.controller.FrmCompararDiretorioController;
import hfsguardadir.objetosgui.FrmDialogo;
import javafx.event.EventHandler;
import javafx.stage.WindowEvent;

public class FrmCompararDiretorio extends FrmDialogo {
    
    private static FrmCompararDiretorio instancia;
    
    private final FrmCompararDiretorioController controller;

    public static FrmCompararDiretorio getInstancia() {
        if (instancia == null) {
            instancia = new FrmCompararDiretorio();
        }
        return instancia;
    }    
    
    private FrmCompararDiretorio(){
        super("FrmCompararDiretorio","Comparar Diretórios", 644, 501);
        controller = (FrmCompararDiretorioController) loader.getController();
        mudarLingua();
        
        this.setOnShown(new EventHandler<WindowEvent>() {

            @Override
            public void handle(WindowEvent event) {
                FrmCompararDiretorioOnShown(event);
            }
        });
        
    }

    public FrmCompararDiretorioController getController(){
        return controller;
    }    
    
    private void FrmCompararDiretorioOnShown(WindowEvent event) {
        controller.onShown();
    }
    
    private void mudarLingua() {
	setTitle(Rotinas.getRecurso("FrmCompararDiretorio.titulo"));
        controller.mudarLingua();
    }
    
}
