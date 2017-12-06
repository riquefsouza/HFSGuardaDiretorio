package hfsguardadiretorio.gui;

import org.gnome.gtk.HBox;
import org.gnome.gtk.PolicyType;
import org.gnome.gtk.ProgressBar;
import org.gnome.gtk.ScrolledWindow;
import org.gnome.gtk.Statusbar;
import org.gnome.gtk.TextView;
import org.gnome.gtk.VBox;
import org.gnome.gtk.Window;
import org.gnome.gtk.WindowPosition;
import org.gnome.gtk.WindowType;

public class FrmImportarDiretorio extends Window
{
	private VBox form_vbox1;
	private ScrolledWindow scrollMemo;
	private TextView memoImportaDir;
	private ProgressBar pbImportar;
	private HBox hbox3;
	private Statusbar barraStatus1;
	private Statusbar barraStatus2;


	public FrmImportarDiretorio()
	{
		super(WindowType.TOPLEVEL);
		this.barraStatus2 = new Statusbar();
		this.barraStatus2.setName("barraStatus2");
		this.barraStatus2.setCanFocus(false);
		this.barraStatus2.setSpacing(2);
	
		this.barraStatus1 = new Statusbar();
		this.barraStatus1.setName("barraStatus1");
		this.barraStatus1.setCanFocus(false);
		this.barraStatus1.setSpacing(2);
	
		this.hbox3 = new HBox(false, 0);
		this.hbox3.setName("hbox3");
		this.hbox3.setCanFocus(false);
		hbox3.packStart(barraStatus1, false, true, 0);
		hbox3.packStart(barraStatus2, true, true, 0);
	
		this.pbImportar = new ProgressBar();
		this.pbImportar.setName("pbImportar");
		this.pbImportar.setCanFocus(false);
	
		this.memoImportaDir = new TextView();
		this.memoImportaDir.setName("memoImportaDir");
		this.memoImportaDir.setCanFocus(true);
	
		this.scrollMemo = new ScrolledWindow();
		this.scrollMemo.setName("scrollMemo");
		this.scrollMemo.setCanFocus(true);
		this.scrollMemo.setPolicy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
		this.scrollMemo.add(this.memoImportaDir);
	
		this.form_vbox1 = new VBox(false, 0);
		this.form_vbox1.setName("form_vbox1");
		this.form_vbox1.setCanFocus(false);
		form_vbox1.packStart(scrollMemo, true, true, 0);
		form_vbox1.packStart(pbImportar, false, true, 0);
		form_vbox1.packStart(hbox3, false, true, 0);
	
		this.setName("frmImportarDiretorio");
		this.setSizeRequest(895, 572);
		this.setCanFocus(false);
		this.setTitle("Importando Diretório");
		this.setResizable(false);
		this.setModal(true);
		this.setPosition(WindowPosition.CENTER);
		this.setDefaultSize(895, 572);
		this.setDecorated(false);
		this.add(form_vbox1);
		this.showAll();
	

		
	}

	public static void mostrar() 
	{
		FrmImportarDiretorio frmImportarDiretorio = new FrmImportarDiretorio();
		frmImportarDiretorio.setPosition(WindowPosition.CENTER_ALWAYS);
		frmImportarDiretorio.show();
	}

	
}
