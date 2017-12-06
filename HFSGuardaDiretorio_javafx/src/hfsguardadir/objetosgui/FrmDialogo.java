package hfsguardadir.objetosgui;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

public abstract class FrmDialogo extends Stage {
   
    protected FXMLLoader loader;
    
    protected FrmDialogo(String caminho, String fxml, String titulo, 
            double width, double height, StageStyle estilo) {
        Parent frmDialogo = null;
        loader = new FXMLLoader(getClass().getResource(caminho + 
                fxml + ".fxml"));
        try {
            frmDialogo = loader.load();
        } catch (IOException ex) {
            Logger.getLogger(
                    FrmDialogo.class.getName()).log(
                            Level.SEVERE, null, ex);
        }
       
        setTitle(titulo);
        initStyle(estilo);
        initModality(Modality.APPLICATION_MODAL);
        initOwner(null);
        setResizable(false);
        setScene(new Scene(frmDialogo, width, height));
    }

    protected FrmDialogo(String fxml, String titulo, 
        double width, double height, StageStyle estilo) {
        this("/hfsguardadir/gui/", fxml, titulo, width, height, estilo);        
    }
    
    protected FrmDialogo(String fxml, String titulo, 
            double width, double height) {
        this(fxml, titulo, width, height, StageStyle.UTILITY);
    }
    
    public void ShowModal() {
        sizeToScene();
        centerOnScreen();
        showAndWait();
    }

    public void ShowNormal() {
        sizeToScene();
        centerOnScreen();
        show();
    }
    
}
