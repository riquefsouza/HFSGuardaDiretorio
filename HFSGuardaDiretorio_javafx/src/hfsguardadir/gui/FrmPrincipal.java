package hfsguardadir.gui;

import hfsguardadir.comum.Rotinas;
import hfsguardadir.gui.controller.FrmPrincipalController;
import hfsguardadir.objetosgui.Dialogo;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;

public class FrmPrincipal extends Stage {

    private static FrmPrincipal instancia;
    
    private final FrmPrincipalController controller;

    public static FrmPrincipal getInstancia() {
        if (instancia == null) {
            instancia = new FrmPrincipal();
        }
        return instancia;
    }
    
    private FrmPrincipal() {
        Parent frmPrincipal = null;
        FXMLLoader loader = new FXMLLoader(getClass()
                    .getResource("/hfsguardadir/gui/FrmPrincipal.fxml"));
        try {
            frmPrincipal = loader.load();
        } catch (IOException ex) {
            Logger.getLogger(FrmPrincipal.class.getName()).log(
                    Level.SEVERE, null, ex);
        }

        this.setTitle("HFSGuardaDiretorio 2.0 - Catalogador de Diretórios");
        this.setScene(new Scene(frmPrincipal, 888, 472));
        
        controller = (FrmPrincipalController) loader.getController();
        
        this.setOnShown(new EventHandler<WindowEvent>() {

            @Override
            public void handle(WindowEvent event) {
                FrmPrincipalOnShown(event);
            }
        });
        
        this.setOnCloseRequest(new EventHandler<WindowEvent>() {
            @Override
            public void handle(WindowEvent event) {
                FrmPrincipalOnClose(event);
            }
        });
    }
    
    public FrmPrincipalController getController(){
        return controller;
    }

    public void mudarLingua() {        
        setTitle(Rotinas.getRecurso("FrmPrincipal.titulo"));
        controller.mudarLingua();
    }
    
    private void FrmPrincipalOnShown(WindowEvent event) {
        controller.setIdiomaPadrao(Rotinas.getParams().getLocalidadeLingua());
    }
    
    private void FrmPrincipalOnClose(WindowEvent event) {
        try {
            Rotinas.Desconectar();
        } catch (SQLException e) {
                Dialogo.mensagemErro("FrmPrincipal.ErroDesconectar", e
                                .getLocalizedMessage());
        }
    }
}
