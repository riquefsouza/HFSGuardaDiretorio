package hfsguardadiretorio.gui;

import hfsguardadiretorio.comum.Rotinas;

import org.gnome.gdk.WindowTypeHint;
import org.gnome.gtk.AttachOptions;
import org.gnome.gtk.Button;
import org.gnome.gtk.ButtonBoxStyle;
import org.gnome.gtk.CellRendererText;
import org.gnome.gtk.Dialog;
import org.gnome.gtk.Frame;
import org.gnome.gtk.HButtonBox;
import org.gnome.gtk.Label;
import org.gnome.gtk.PolicyType;
import org.gnome.gtk.ScrolledWindow;
import org.gnome.gtk.Table;
import org.gnome.gtk.TreeView;
import org.gnome.gtk.TreeViewColumn;
import org.gnome.gtk.TreeViewColumnSizing;
import org.gnome.gtk.VBox;
import org.gnome.gtk.Window;
import org.gnome.gtk.WindowPosition;

public class FrmInfoDiretorio extends Dialog
{
	private VBox dialog_vbox3;
	private VBox vbox3;
	private Frame frame1;
	private Table table1;
	private Label labArquivoComum;
	private Label labArquivoOculto;
	private Label labArquivoSistema;
	private Label labLegendaDiretorio;
	private Label labVolumeID;
	private Label labArquivoSomenteLeitura;
	private ScrolledWindow scrollTabela1;
	private TreeView tabelaInfo;
	private TreeViewColumn colunaInfoItem;
	private TreeViewColumn colunaInfoDescricao;
	private HButtonBox dialog_action_area3;
	private Button btnOk;


	public FrmInfoDiretorio(Window parent)
	{
		super("", parent, true);

		this.btnOk = new Button();
		this.btnOk.setName("btnOk");
		this.btnOk.setLabel("gtk-ok");
		this.btnOk.setCanFocus(true);
	
		this.dialog_action_area3 = new HButtonBox();
		this.dialog_action_area3.setName("dialog_action_area3");
		this.dialog_action_area3.setCanFocus(false);
		this.dialog_action_area3.setLayout(ButtonBoxStyle.CENTER);
		dialog_action_area3.packStart(btnOk, false, false, 0);
	
	
	
		this.tabelaInfo = new TreeView();
		this.tabelaInfo.setName("tabelaInfo");
		this.tabelaInfo.setCanFocus(true);
		this.tabelaInfo.setModel(Rotinas.getInstancia().lsTabelaInfo());
		this.colunaInfoItem = this.tabelaInfo.appendColumn();
		this.colunaInfoItem.setResizable(true);
		this.colunaInfoItem.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaInfoItem.setTitle("Item");
		this.colunaInfoItem.setSortColumn(Rotinas.getInstancia().lsTabelaInfoColuna0);
		CellRendererText crtcolunaInfoItem = new CellRendererText(colunaInfoItem);
		crtcolunaInfoItem.setMarkup(Rotinas.getInstancia().lsTabelaInfoColuna0);
		this.colunaInfoDescricao = this.tabelaInfo.appendColumn();
		this.colunaInfoDescricao.setResizable(true);
		this.colunaInfoDescricao.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaInfoDescricao.setTitle("Descrição");
		this.colunaInfoDescricao.setSortColumn(Rotinas.getInstancia().lsTabelaInfoColuna1);
		CellRendererText crtcolunaInfoDescricao = new CellRendererText(colunaInfoDescricao);
		crtcolunaInfoDescricao.setMarkup(Rotinas.getInstancia().lsTabelaInfoColuna1);
	
		this.scrollTabela1 = new ScrolledWindow();
		this.scrollTabela1.setName("scrollTabela1");
		this.scrollTabela1.setCanFocus(true);
		this.scrollTabela1.setPolicy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
		this.scrollTabela1.add(this.tabelaInfo);
	
		this.labArquivoSomenteLeitura = new Label();
		this.labArquivoSomenteLeitura.setName("labArquivoSomenteLeitura");
		this.labArquivoSomenteLeitura.setCanFocus(false);
		this.labArquivoSomenteLeitura.setLabel("[ROL] - Arquivo Somente Leitura");
	
		this.labVolumeID = new Label();
		this.labVolumeID.setName("labVolumeID");
		this.labVolumeID.setCanFocus(false);
		this.labVolumeID.setLabel("[VOL] - Volume ID");
	
		this.labLegendaDiretorio = new Label();
		this.labLegendaDiretorio.setName("labLegendaDiretorio");
		this.labLegendaDiretorio.setCanFocus(false);
		this.labLegendaDiretorio.setLabel("[DIR] - Diretório");
	
		this.labArquivoSistema = new Label();
		this.labArquivoSistema.setName("labArquivoSistema");
		this.labArquivoSistema.setCanFocus(false);
		this.labArquivoSistema.setLabel("[SYS] - Arquivo de Sistema");
	
		this.labArquivoOculto = new Label();
		this.labArquivoOculto.setName("labArquivoOculto");
		this.labArquivoOculto.setCanFocus(false);
		this.labArquivoOculto.setLabel("[HID] - Arquivo Oculto");
	
		this.labArquivoComum = new Label();
		this.labArquivoComum.setName("labArquivoComum");
		this.labArquivoComum.setCanFocus(false);
		this.labArquivoComum.setLabel("[ARQ] - Arquivo comum");
	
		this.table1 = new Table(3, 2, true);
		this.table1.setName("table1");
		this.table1.setCanFocus(false);
		table1.attach(labArquivoComum, 0, 1, 0, 1, AttachOptions.FILL, AttachOptions.FILL, 5, 5);
		table1.attach(labArquivoOculto, 1, 2, 0, 1, AttachOptions.FILL, AttachOptions.FILL, 5, 5);
		table1.attach(labArquivoSistema, 0, 1, 1, 2, AttachOptions.FILL, AttachOptions.FILL, 5, 5);
		table1.attach(labLegendaDiretorio, 1, 2, 1, 2, AttachOptions.FILL, AttachOptions.FILL, 5, 5);
		table1.attach(labVolumeID, 0, 1, 2, 3, AttachOptions.FILL, AttachOptions.FILL, 5, 5);
		table1.attach(labArquivoSomenteLeitura, 1, 2, 2, 3, AttachOptions.FILL, AttachOptions.FILL, 5, 5);
	
		this.frame1 = new Frame("");
		this.frame1.setName("frame1");
		this.frame1.setCanFocus(false);
		this.frame1.setLabelAlign(0, 0);
		this.frame1.add(this.table1);
	
		this.vbox3 = new VBox(false, 0);
		this.vbox3.setName("vbox3");
		this.vbox3.setCanFocus(false);
		vbox3.packStart(frame1, false, true, 0);
		vbox3.packStart(scrollTabela1, true, true, 0);
	
		this.dialog_vbox3 = new VBox(false, 0);
		this.dialog_vbox3.setName("dialog_vbox3");
		this.dialog_vbox3.setCanFocus(false);
		this.dialog_vbox3.setSpacing(2);
		dialog_vbox3.packStart(vbox3, true, true, 0);
		dialog_vbox3.packStart(dialog_action_area3, false, true, 0);
	
		this.setName("frmInfoDiretorio");
		this.setSizeRequest(369, 372);
		this.setCanFocus(false);
		this.setBorderWidth(5);
		this.setTitle("Informações do Diretório / Arquivo");
		this.setResizable(false);
		this.setModal(true);
		this.setPosition(WindowPosition.CENTER);
		this.setTypeHint(WindowTypeHint.DIALOG);
		this.add(dialog_vbox3);
		this.showAll();
	

		this.btnOk.connect(new Button.Clicked(){
			@Override
			public void onClicked(Button source){
				on_btnOk_clicked(source);
			}
		});

	}

	public static void mostrar(Window parent) 
	{
		FrmInfoDiretorio frmInfoDiretorio = new FrmInfoDiretorio(parent);
		frmInfoDiretorio.setPosition(WindowPosition.CENTER_ALWAYS);
		frmInfoDiretorio.run();
		frmInfoDiretorio.destroy();
	}

	public void on_btnOk_clicked(Button source){

	}


}
