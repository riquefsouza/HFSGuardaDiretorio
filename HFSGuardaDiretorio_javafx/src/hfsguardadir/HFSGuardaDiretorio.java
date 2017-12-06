package hfsguardadir;

import hfsguardadir.catalogador.Catalogador;
import hfsguardadir.comum.Rotinas;
import hfsguardadir.gui.FrmPrincipal;
import hfsguardadir.objetos.Parametro;
import hfsguardadir.objetosgui.Dialogo;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;
import javafx.application.Application;
import javafx.stage.Stage;
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.SAXException;

/**
 *
 * @author henrique.souza
 */
public class HFSGuardaDiretorio extends Application {
    
    @Override
    public void start(Stage primaryStage) throws IOException {
        primaryStage = FrmPrincipal.getInstancia();
        primaryStage.show();        
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Parametro param = Rotinas.getParams();
        Logger log = Logger.getLogger(Rotinas.HFSGUARDADIR);

        if (param.getJavaVersao() > 1.7) {
            try {
                Catalogador.iniciarSistema(param);
                Rotinas.iniciarLogArquivo(log);                
                launch(args);

            } catch (ClassNotFoundException e) {
                Dialogo.mensagemErro("HFSGuardaDir.ErroInicial", e
                        .getLocalizedMessage());
            } catch (SQLException e) {
                Dialogo.mensagemErro("HFSGuardaDir.ErroInicial", e
                        .getLocalizedMessage());
            } catch (SAXException e) {
                Dialogo.mensagemErro("HFSGuardaDir.ErroInicial", e
                        .getLocalizedMessage());
            } catch (IOException e) {
                Dialogo.mensagemErro("HFSGuardaDir.ErroInicial", e
                        .getLocalizedMessage());
            } catch (ParserConfigurationException e) {
                Dialogo.mensagemErro("HFSGuardaDir.ErroInicial", e
                        .getLocalizedMessage());
            }
        } else {
            Dialogo.mensagemErro("HFSGuardaDir.ValidaJavaVersao");
        }
    }
    
}
