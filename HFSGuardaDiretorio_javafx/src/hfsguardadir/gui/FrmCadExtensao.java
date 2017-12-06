package hfsguardadir.gui;

import hfsguardadir.comum.Rotinas;
import hfsguardadir.gui.controller.FrmCadExtensaoController;
import hfsguardadir.objetosgui.FrmDialogo;

public class FrmCadExtensao extends FrmDialogo {
    
    private static FrmCadExtensao instancia;
    
    private final FrmCadExtensaoController controller;

    public static FrmCadExtensao getInstancia() {
        if (instancia == null) {
            instancia = new FrmCadExtensao();
        }
        return instancia;
    }    
    
    private FrmCadExtensao(){
        super("FrmCadExtensao","Cadastro de Extensão de Arquivo", 274, 342);
        controller = (FrmCadExtensaoController) loader.getController();
        mudarLingua();
    }

    public FrmCadExtensaoController getController(){
        return controller;
    }    

    private void mudarLingua() {
	setTitle(Rotinas.getRecurso("FrmCadExtensao.titulo"));
        controller.mudarLingua();
    }    
}
