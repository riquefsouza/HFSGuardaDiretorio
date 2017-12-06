package hfsguardadir.gui;

import hfsguardadir.comum.IProgressoLog;
import hfsguardadir.comum.Progresso;
import hfsguardadir.gui.controller.FrmPrincipalController;

public class FrmPrincipalProgresso implements IProgressoLog {

    FrmPrincipalController form;
    double valor;

    public FrmPrincipalProgresso(FrmPrincipalController form) {
        this.form = form;        
    }

    @Override
    public void ProgressoLog(Progresso progresso) {
        /*
        if (progresso.getPosicao() == 0) {
            this.form.pb.setMinimum(progresso.getMinimo());
            this.form.pb.setMaximum(progresso.getMaximo());
        }
        */
        if (progresso.getPosicao() > 0) {
            valor = (double)progresso.getPosicao()/(double)progresso.getMaximo();
            this.form.pb.setProgress(valor);
            //this.form.pb.update(this.form.pb.getGraphics());
        }  
    }

}
