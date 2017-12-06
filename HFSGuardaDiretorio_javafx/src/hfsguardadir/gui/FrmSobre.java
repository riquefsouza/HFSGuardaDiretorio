package hfsguardadir.gui;

import hfsguardadir.gui.controller.FrmSobreController;
import hfsguardadir.objetosgui.FrmDialogo;

public class FrmSobre extends FrmDialogo {

    private static FrmSobre instancia;
    
    private final FrmSobreController controller;

    public static FrmSobre getInstancia() {
        if (instancia == null) {
            instancia = new FrmSobre();
        }
        return instancia;
    }

    private FrmSobre() {
        super("FrmSobre", "Sobre o Catalogador", 452, 503);        
        controller = (FrmSobreController) loader.getController();
    }

    public FrmSobreController getController(){
        return controller;
    }    
}
