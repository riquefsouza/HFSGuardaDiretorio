package hfsguardadir.gui;

import hfsguardadir.comum.Rotinas;
import hfsguardadir.gui.controller.FrmInfoDiretorioController;
import hfsguardadir.objetosgui.FrmDialogo;

public class FrmInfoDiretorio extends FrmDialogo {

    private static FrmInfoDiretorio instancia;
    
    private final FrmInfoDiretorioController controller;

    public static FrmInfoDiretorio getInstancia() {
        if (instancia == null) {
            instancia = new FrmInfoDiretorio();
        }
        return instancia;
    }

    private FrmInfoDiretorio() {
        super("FrmInfoDiretorio", "Informações do Diretório / Arquivo", 380, 398);
        controller = (FrmInfoDiretorioController) loader.getController();
        mudarLingua();
    }

    public FrmInfoDiretorioController getController(){
        return controller;
    }    
 
    private void mudarLingua() {
	setTitle(Rotinas.getRecurso("FrmInfoDiretorio.titulo"));
        controller.mudarLingua();
    }
}
