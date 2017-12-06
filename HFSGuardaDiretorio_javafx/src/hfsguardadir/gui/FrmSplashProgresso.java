package hfsguardadir.gui;

import hfsguardadir.comum.IProgressoLog;
import hfsguardadir.comum.Progresso;
import hfsguardadir.gui.controller.FrmSplashController;

public class FrmSplashProgresso implements IProgressoLog {

    private final FrmSplashController form;
    private double valor;

    public FrmSplashProgresso(FrmSplashController form) {
        this.form = form;
    }

    @Override
    public void ProgressoLog(Progresso progresso) {
        if (progresso.getPosicao() == 0) {
            this.form.pb.setProgress(progresso.getMinimo());
            //this.form.pb.setMaximum(progresso.getMaximo());
        }
        if (progresso.getPosicao() > 0) {
            valor = (double)progresso.getPosicao()/(double)progresso.getMaximo();
            this.form.pb.setProgress(valor);
        }  
    }

}
