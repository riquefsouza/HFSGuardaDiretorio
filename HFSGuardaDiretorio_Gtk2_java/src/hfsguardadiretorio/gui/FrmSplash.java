package hfsguardadiretorio.gui;

import org.gnome.gtk.Label;
import org.gnome.gtk.ProgressBar;
import org.gnome.gtk.VBox;
import org.gnome.gtk.Window;
import org.gnome.gtk.WindowPosition;
import org.gnome.gtk.WindowType;

public class FrmSplash extends Window
{
	private VBox vbox2;
	private Label label4;
	private Label label5;
	private ProgressBar pb1;


	public FrmSplash()
	{
		super(WindowType.TOPLEVEL);
		this.pb1 = new ProgressBar();
		this.pb1.setName("pb1");
		this.pb1.setCanFocus(false);
	
		this.label5 = new Label();
		this.label5.setName("label5");
		this.label5.setCanFocus(false);
		this.label5.setLabel("Catalogador de Diretórios");
	
		this.label4 = new Label();
		this.label4.setName("label4");
		this.label4.setCanFocus(false);
		this.label4.setLabel("HFSGuardaDiretorio 2.0");
	
		this.vbox2 = new VBox(false, 0);
		this.vbox2.setName("vbox2");
		this.vbox2.setCanFocus(false);
		vbox2.packStart(label4, false, true, 0);
		vbox2.packStart(label5, false, true, 0);
		vbox2.packStart(pb1, false, true, 0);
	
		this.setName("frmSplash");
		this.setSizeRequest(375, 113);
		this.setCanFocus(false);
		this.setModal(true);
		this.setPosition(WindowPosition.CENTER_ALWAYS);
		this.setDefaultSize(375, 113);
		this.setDecorated(false);
		this.add(vbox2);
		this.showAll();
	

		
	}

	public static void mostrar() 
	{
		FrmSplash frmSplash = new FrmSplash();
		frmSplash.setPosition(WindowPosition.CENTER_ALWAYS);
		frmSplash.show();
	}

	
}
