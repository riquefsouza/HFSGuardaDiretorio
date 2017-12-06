package hfsguardadir.gui;

import hfsguardadir.comum.IProgressoLog;
import hfsguardadir.comum.Progresso;
import hfsguardadir.gui.controller.FrmImportarDiretorioController;

public class FrmImportarDiretorioProgresso implements IProgressoLog {

    FrmImportarDiretorioController form;
    double valor;
    
    public FrmImportarDiretorioProgresso(FrmImportarDiretorioController form) {
        this.form = form;
    }

    @Override
    public void ProgressoLog(Progresso progresso) {
        /*
        if (progresso.getPosicao() == 0) {
            this.form.pbImportar.setMinimum(progresso.getMinimo());
            this.form.pbImportar.setMaximum(progresso.getMaximo());            
        }
        this.form.pbImportar.setValue(progresso.getPosicao());
        */
        
        if (progresso.getPosicao() > 0) {
            valor = (double)progresso.getPosicao()/(double)progresso.getMaximo();
            this.form.pbImportar.setProgress(valor);
        }
        
        if (!progresso.getLog().isEmpty()) {
            int pos = this.form.memoImportaDir.getItems().size();
            this.form.memoImportaDir.getItems().add(pos, progresso.getLog());
            this.form.memoImportaDir.getSelectionModel().select(pos);
            this.form.barraStatus2.setText(String.valueOf(pos));

            /*
            if ((pos % 30) == 0) {
                this.form.memoImportaDir.update(this.form.memoImportaDir.getGraphics());
                this.form.update(this.form.getGraphics());
            }            
            */
        }
    }

}
