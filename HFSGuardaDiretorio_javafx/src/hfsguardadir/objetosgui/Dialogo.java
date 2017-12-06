package hfsguardadir.objetosgui;

import hfsguardadir.comum.Rotinas;
import hfsguardadir.gui.controller.FrmCompararDiretorioController;
import java.util.Optional;

import java.util.logging.Logger;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TextInputDialog;

public class Dialogo {

    private static final long serialVersionUID = 8344900276967442817L;

    private static Logger log = Logger.getLogger(Rotinas.HFSGUARDADIR);

    public static void mensagemInfo(FrmCompararDiretorioController aThis, String frmCompararDiretorioDiretoriosNaoSelecion) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public Dialogo() {
        super();
    }

    public static void mudarLingua() {
        /*
        UIManager.put("OptionPane.yesButtonText", Rotinas
                .getRecurso("Dialogo.yesButtonText"));
        UIManager.put("OptionPane.yesButtonMnemonic", Rotinas
                .getRecurso("Dialogo.yesButtonMnemonic"));
        UIManager.put("OptionPane.cancelButtonText", Rotinas
                .getRecurso("Dialogo.cancelButtonText"));
        UIManager.put("OptionPane.cancelButtonMnemonic", Rotinas
                .getRecurso("Dialogo.cancelButtonMnemonic"));
        UIManager.put("OptionPane.noButtonText", Rotinas
                .getRecurso("Dialogo.noButtonText"));
        UIManager.put("OptionPane.noButtonMnemonic", Rotinas
                .getRecurso("Dialogo.noButtonMnemonic"));
        UIManager.put("OptionPane.okButtonText", Rotinas
                .getRecurso("Dialogo.okButtonText"));
        UIManager.put("OptionPane.okButtonMnemonic", Rotinas
                .getRecurso("Dialogo.okButtonMnemonic"));
        */                
    }

    public static void mensagemErro(String recurso, String texto) {
        Alert alert = new Alert(AlertType.ERROR);
        alert.setTitle(Rotinas.getRecurso("Dialogo.erro"));
        alert.setHeaderText(null);
        alert.setContentText(Rotinas.getRecurso(recurso) + " " + texto);
        alert.showAndWait();
        log.warning(Rotinas.getRecurso(recurso) + " " + texto);
    }

    public static void mensagemErro(String recurso) {
        Dialogo.mensagemErro(recurso, "");
    }

    public static void mensagemInfo(String recurso) {
        Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle(Rotinas.getRecurso("Dialogo.info"));
        alert.setHeaderText(null);
        alert.setContentText(Rotinas.getRecurso(recurso));
        alert.showAndWait();
        log.info(Rotinas.getRecurso(recurso));
    }

    public static Optional<ButtonType> confirma(String recurso) {
        Alert alert = new Alert(AlertType.CONFIRMATION);
        alert.setTitle(Rotinas.getRecurso("Dialogo.confirma"));
        alert.setHeaderText(null);
        alert.setContentText(Rotinas.getRecurso(recurso));

        return alert.showAndWait();
    }

    public static String entrada(String recurso) {
        return entrada(recurso, "");
    }

    public static String entrada(String recurso, String valorInicial) {
        TextInputDialog dialog = new TextInputDialog(valorInicial);
        dialog.setTitle(Rotinas.getRecurso("Dialogo.entrada"));
        dialog.setHeaderText(null);
        dialog.setContentText(Rotinas.getRecurso(recurso));

        Optional<String> resultado = dialog.showAndWait();
        return resultado.get();
    }
}
