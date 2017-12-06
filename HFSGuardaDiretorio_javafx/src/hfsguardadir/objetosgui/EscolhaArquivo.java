package hfsguardadir.objetosgui;

import hfsguardadir.comum.Rotinas;
import java.io.File;
import javafx.stage.DirectoryChooser;
import javafx.stage.FileChooser;
import javafx.stage.FileChooser.ExtensionFilter;
import javafx.stage.Window;

public class EscolhaArquivo {

    public static final int SAVE_DIALOG = 0;

    public static final int OPEN_DIALOG = 1;

    public static final int CUSTOM_DIALOG = 2;

    public static final int PREVIEW_OPEN_DIALOG = 3;

    public static final int PREVIEW_SAVE_DIALOG = 4;

    private final FileChooser fileChooser;
    
    private final DirectoryChooser dirChooser;
    
    private final int tipoDialogo;

    public EscolhaArquivo(int tipoDialogo) {
        this.tipoDialogo = tipoDialogo;
        dirChooser = new DirectoryChooser();
        fileChooser = new FileChooser();           

        if (tipoDialogo == EscolhaArquivo.SAVE_DIALOG
                || tipoDialogo == EscolhaArquivo.OPEN_DIALOG) {

            if (tipoDialogo == EscolhaArquivo.SAVE_DIALOG) {
                fileChooser.setTitle(Rotinas
                        .getRecurso("EscolhaArquivo.saveButtonText"));
            } else if (tipoDialogo == EscolhaArquivo.OPEN_DIALOG) {
                fileChooser.setTitle(Rotinas
                        .getRecurso("EscolhaArquivo.openButtonText"));
            }
            adicionarFiltro("EscolhaArquivo.filtroTXT", "txt");
            adicionarFiltro("EscolhaArquivo.filtroCSV", "csv");
            adicionarFiltro("EscolhaArquivo.filtroHTML", "html");
            adicionarFiltro("EscolhaArquivo.filtroXML", "xml");
            adicionarFiltro("EscolhaArquivo.filtroSQL", "sql");
			//fileChooser.setFileSelectionMode(FileChooser.FILES_AND_DIRECTORIES);
            //fileChooser.setAcceptAllFileFilterUsed(true);                        
        } else if (tipoDialogo == EscolhaArquivo.PREVIEW_OPEN_DIALOG
                || tipoDialogo == EscolhaArquivo.PREVIEW_SAVE_DIALOG) {
            if (tipoDialogo == EscolhaArquivo.PREVIEW_SAVE_DIALOG) {
                fileChooser.setTitle(Rotinas
                        .getRecurso("EscolhaArquivo.saveButtonText"));
            } else if (tipoDialogo == EscolhaArquivo.PREVIEW_OPEN_DIALOG) {
                fileChooser.setTitle(Rotinas
                        .getRecurso("EscolhaArquivo.openButtonText"));
            }
            adicionarFiltro("EscolhaArquivo.filtroBMP", "bmp");
            adicionarFiltro("EscolhaArquivo.filtroICO", "ico");
            adicionarFiltro("EscolhaArquivo.filtroJPG", "jpg");
            adicionarFiltro("EscolhaArquivo.filtroGIF", "gif");
            adicionarFiltro("EscolhaArquivo.filtroPNG", "png");
            adicionarFiltro("EscolhaArquivo.filtroTIF", "tif");
            //this.setAccessory(new FilePreviewer(this));
        } else {            
            dirChooser.setTitle(Rotinas
                        .getRecurso("EscolhaArquivo.ApproveButtonText"));

            /*
             fileChooser.setFileSelectionMode(FileChooser.DIRECTORIES_ONLY);
             fileChooser.setApproveButtonText(Rotinas
             .getRecurso("EscolhaArquivo.ApproveButtonText"));
             fileChooser.setApproveButtonMnemonic(Rotinas.getRecurso(
             "EscolhaArquivo.ApproveButtonMnemonic").charAt(0));
             fileChooser.setApproveButtonToolTipText(Rotinas
             .getRecurso("EscolhaArquivo.ApproveButtonToolTipText"));
             fileChooser.setAcceptAllFileFilterUsed(false);
             this.addChoosableFileFilter(new Filtro());
             */
        }
		//fileChooser.setControlButtonsAreShown(true);
        //fileChooser.setMultiSelectionEnabled(false);
        //fileChooser.setVisible(true);
    }

    private void adicionarFiltro(String descricao, String extensao) {
        fileChooser.getExtensionFilters().add(
                new ExtensionFilter(Rotinas.getRecurso(descricao),
                        "*." + extensao));
    }

    public static void mudarLingua() {
        /*
         UIManager.put("FileChooser.lookInLabelText", Rotinas
         .getRecurso("EscolhaArquivo.lookInLabelText"));
         UIManager.put("FileChooser.lookInLabelMnemonic", Rotinas
         .getRecurso("EscolhaArquivo.lookInLabelMnemonic"));
         UIManager.put("FileChooser.saveInLabelMnemonic", Rotinas
         .getRecurso("EscolhaArquivo.saveInLabelMnemonic"));
         UIManager.put("FileChooser.saveInLabelText", Rotinas
         .getRecurso("EscolhaArquivo.saveInLabelText"));
         UIManager.put("FileChooser.fileNameLabelText", Rotinas
         .getRecurso("EscolhaArquivo.fileNameLabelText"));
         UIManager.put("FileChooser.fileNameLabelMnemonic", Rotinas
         .getRecurso("EscolhaArquivo.fileNameLabelMnemonic"));
         UIManager.put("FileChooser.filesOfTypeLabelText", Rotinas
         .getRecurso("EscolhaArquivo.filesOfTypeLabelText"));
         UIManager.put("FileChooser.filesOfTypeLabelMnemonic", Rotinas
         .getRecurso("EscolhaArquivo.filesOfTypeLabelMnemonic"));
         UIManager.put("FileChooser.upFolderToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.upFolderToolTipText"));
         UIManager.put("FileChooser.upFolderAccessibleName", Rotinas
         .getRecurso("EscolhaArquivo.upFolderAccessibleName"));
         UIManager.put("FileChooser.homeFolderToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.homeFolderToolTipText"));
         UIManager.put("FileChooser.homeFolderAccessibleName", Rotinas
         .getRecurso("EscolhaArquivo.homeFolderAccessibleName"));
         UIManager.put("FileChooser.newFolderToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.newFolderToolTipText"));
         UIManager.put("FileChooser.newFolderAccessibleName", Rotinas
         .getRecurso("EscolhaArquivo.newFolderAccessibleName"));
         UIManager.put("FileChooser.listViewButtonToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.listViewButtonToolTipText"));
         UIManager.put("FileChooser.listViewButtonAccessibleName", Rotinas
         .getRecurso("EscolhaArquivo.listViewButtonAccessibleName"));
         UIManager.put("FileChooser.detailsViewButtonToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.detailsViewButtonToolTipText"));
         UIManager.put("FileChooser.detailsViewButtonAccessibleName", Rotinas
         .getRecurso("EscolhaArquivo.detailsViewButtonAccessibleName"));
         UIManager.put("FileChooser.cancelButtonText", Rotinas
         .getRecurso("EscolhaArquivo.cancelButtonText"));
         UIManager.put("FileChooser.cancelButtonToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.cancelButtonToolTipText"));
         UIManager.put("FileChooser.cancelButtonMnemonic", Rotinas
         .getRecurso("EscolhaArquivo.cancelButtonMnemonic"));

         UIManager.put("FileChooser.fileNameHeaderText", Rotinas
         .getRecurso("EscolhaArquivo.fileNameHeaderText"));
         UIManager.put("FileChooser.fileSizeHeaderText", Rotinas
         .getRecurso("EscolhaArquivo.fileSizeHeaderText"));
         UIManager.put("FileChooser.fileTypeHeaderText", Rotinas
         .getRecurso("EscolhaArquivo.fileTypeHeaderText"));
         UIManager.put("FileChooser.fileDateHeaderText", Rotinas
         .getRecurso("EscolhaArquivo.fileDateHeaderText"));
         UIManager.put("FileChooser.fileAttrHeaderText", Rotinas
         .getRecurso("EscolhaArquivo.fileAttrHeaderText"));

         UIManager.put("FileChooser.openButtonText", Rotinas
         .getRecurso("EscolhaArquivo.openButtonText"));
         UIManager.put("FileChooser.openButtonMnemonic", Rotinas
         .getRecurso("EscolhaArquivo.openButtonMnemonic"));
         UIManager.put("FileChooser.openButtonToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.openButtonToolTipText"));

         UIManager.put("FileChooser.saveButtonText", Rotinas
         .getRecurso("EscolhaArquivo.saveButtonText"));
         UIManager.put("FileChooser.saveButtonMnemonic", Rotinas
         .getRecurso("EscolhaArquivo.saveButtonMnemonic"));
         UIManager.put("FileChooser.saveButtonToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.saveButtonToolTipText"));

         UIManager.put("FileChooser.updateButtonText", Rotinas
         .getRecurso("EscolhaArquivo.updateButtonText"));
         UIManager.put("FileChooser.updateButtonMnemonic", Rotinas
         .getRecurso("EscolhaArquivo.updateButtonMnemonic"));
         UIManager.put("FileChooser.updateButtonToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.updateButtonToolTipText"));

         UIManager.put("FileChooser.helpButtonText", Rotinas
         .getRecurso("EscolhaArquivo.helpButtonText"));
         UIManager.put("FileChooser.helpButtonMnemonic", Rotinas
         .getRecurso("EscolhaArquivo.helpButtonMnemonic"));
         UIManager.put("FileChooser.helpButtonToolTipText", Rotinas
         .getRecurso("EscolhaArquivo.helpButtonToolTipText"));

         UIManager.put("FileChooser.acceptAllFileFilterText", Rotinas
         .getRecurso("EscolhaArquivo.acceptAllFileFilterText"));
         */
    }

    public File mostrar(Window pai) {
        if (tipoDialogo == EscolhaArquivo.CUSTOM_DIALOG)
            return dirChooser.showDialog(pai);
        else
            return fileChooser.showOpenDialog(pai);
    }
    
    public File mostrarAbrir(Window pai) {         
        return fileChooser.showOpenDialog(pai);
    }

    public File mostrarSalvar(Window pai) {
        return fileChooser.showSaveDialog(pai);        
    }
    
    public void setArquivoInicial(String dir){
        fileChooser.setInitialFileName(dir);
    }
    
    public String getDiretorioInicial(){
        File dir;
        if (tipoDialogo == EscolhaArquivo.CUSTOM_DIALOG)
            dir = dirChooser.getInitialDirectory();
        else
            dir = fileChooser.getInitialDirectory();
        return dir.getPath();
    }
}
