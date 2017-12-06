package hfsguardadiretorio.gui;

import org.gnome.gdk.WindowTypeHint;
import org.gnome.gtk.Button;
import org.gnome.gtk.ButtonBoxStyle;
import org.gnome.gtk.Dialog;
import org.gnome.gtk.HButtonBox;
import org.gnome.gtk.Label;
import org.gnome.gtk.VBox;
import org.gnome.gtk.Window;
import org.gnome.gtk.WindowPosition;

public class FrmSobre extends Dialog
{
	private VBox dialog_vbox1;
	private VBox vbox4;
	private Label label;
	private Label label8;
	private Label label9;
	private Label label10;
	private HButtonBox dialog_action_area1;
	private Button btbOk;


	public FrmSobre(Window parent)
	{
		super("", parent, true);

		this.btbOk = new Button();
		this.btbOk.setName("btbOk");
		this.btbOk.setLabel("_Ok");
		this.btbOk.setCanFocus(true);
	
		this.dialog_action_area1 = new HButtonBox();
		this.dialog_action_area1.setName("dialog_action_area1");
		this.dialog_action_area1.setCanFocus(false);
		this.dialog_action_area1.setLayout(ButtonBoxStyle.CENTER);
		dialog_action_area1.packStart(btbOk, false, false, 0);
	
		this.label10 = new Label();
		this.label10.setName("label10");
		this.label10.setCanFocus(false);
		this.label10.setLabel("Todos os direitos reservados, 2015");
	
		this.label9 = new Label();
		this.label9.setName("label9");
		this.label9.setCanFocus(false);
		this.label9.setLabel("Por Henrique Figueiredo de Souza");
	
		this.label8 = new Label();
		this.label8.setName("label8");
		this.label8.setCanFocus(false);
		this.label8.setLabel("Desenvolvido em C com GTK, Versão: 2.0");
	
		this.label = new Label();
		this.label.setName("label");
		this.label.setCanFocus(false);
		this.label.setLabel("HFSGuardaDir 2.0 - Catalogador de Diretórios");
	
		this.vbox4 = new VBox(false, 0);
		this.vbox4.setName("vbox4");
		this.vbox4.setCanFocus(false);
		vbox4.packStart(label, false, true, 0);
		vbox4.packStart(label8, false, true, 0);
		vbox4.packStart(label9, false, true, 0);
		vbox4.packStart(label10, false, true, 0);
	
		this.dialog_vbox1 = new VBox(false, 0);
		this.dialog_vbox1.setName("dialog_vbox1");
		this.dialog_vbox1.setCanFocus(false);
		this.dialog_vbox1.setSpacing(2);
		dialog_vbox1.packStart(vbox4, true, true, 0);
		dialog_vbox1.packStart(dialog_action_area1, false, true, 0);
	
		this.setName("frmSobre");
		this.setCanFocus(false);
		this.setBorderWidth(5);
		this.setTitle("Sobre o Catalogador");
		this.setResizable(false);
		this.setModal(true);
		this.setPosition(WindowPosition.CENTER);
		this.setDefaultSize(300, 150);
		this.setTypeHint(WindowTypeHint.DIALOG);
		this.add(dialog_vbox1);
		this.showAll();
	

		this.btbOk.connect(new Button.Clicked(){
			@Override
			public void onClicked(Button source){
				on_btbOk_clicked(source);
			}
		});

	}

	public static void mostrar(Window parent) 
	{
		FrmSobre frmSobre = new FrmSobre(parent);
		frmSobre.setPosition(WindowPosition.CENTER_ALWAYS);
		frmSobre.run();
		frmSobre.destroy();
	}

	public void on_btbOk_clicked(Button source){

	}


}
