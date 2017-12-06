package hfsguardadiretorio.gui;

import org.gnome.gtk.Menu;
import org.gnome.gtk.MenuItem;
import org.gnome.gtk.SeparatorMenuItem;

public class MenuPopup extends Menu
{
	private MenuItem menuInformacoesDiretorioArquivo;
	private MenuItem menuExcluirDiretorioSelecionado;
	private MenuItem menuExpandirDiretorios2;
	private MenuItem menuColapsarDiretorios2;
	private SeparatorMenuItem separador2;
	private MenuItem menuIncluirNovaAba2;
	private MenuItem menuAlterarNomeAbaAtiva2;
	private MenuItem menuExcluirAbaAtiva2;


	public MenuPopup()
	{
		
		this.menuExcluirAbaAtiva2 = new MenuItem("Excluir aba ativa");
		this.menuExcluirAbaAtiva2.setName("menuExcluirAbaAtiva2");
		this.menuExcluirAbaAtiva2.setCanFocus(false);
	
		this.menuAlterarNomeAbaAtiva2 = new MenuItem("Alterar nome da aba ativa");
		this.menuAlterarNomeAbaAtiva2.setName("menuAlterarNomeAbaAtiva2");
		this.menuAlterarNomeAbaAtiva2.setCanFocus(false);
	
		this.menuIncluirNovaAba2 = new MenuItem("Incluir nova aba");
		this.menuIncluirNovaAba2.setName("menuIncluirNovaAba2");
		this.menuIncluirNovaAba2.setCanFocus(false);
	
		this.separador2 = new SeparatorMenuItem();
		this.separador2.setName("separador2");
		this.separador2.setCanFocus(false);
	
		this.menuColapsarDiretorios2 = new MenuItem("Colapsar Diretórios");
		this.menuColapsarDiretorios2.setName("menuColapsarDiretorios2");
		this.menuColapsarDiretorios2.setCanFocus(false);
	
		this.menuExpandirDiretorios2 = new MenuItem("Expandir Diretórios");
		this.menuExpandirDiretorios2.setName("menuExpandirDiretorios2");
		this.menuExpandirDiretorios2.setCanFocus(false);
	
		this.menuExcluirDiretorioSelecionado = new MenuItem("Excluir Diretório Selecionado");
		this.menuExcluirDiretorioSelecionado.setName("menuExcluirDiretorioSelecionado");
		this.menuExcluirDiretorioSelecionado.setCanFocus(false);
	
		this.menuInformacoesDiretorioArquivo = new MenuItem("Informações do Diretório / Arquivo");
		this.menuInformacoesDiretorioArquivo.setName("menuInformacoesDiretorioArquivo");
		this.menuInformacoesDiretorioArquivo.setCanFocus(false);
	
		this.setName("menuPopup");
		this.setCanFocus(false);
		this.add(menuInformacoesDiretorioArquivo);
		this.showAll();
		this.add(menuExcluirDiretorioSelecionado);
		this.showAll();
		this.add(menuExpandirDiretorios2);
		this.showAll();
		this.add(menuColapsarDiretorios2);
		this.showAll();
		this.add(separador2);
		this.showAll();
		this.add(menuIncluirNovaAba2);
		this.showAll();
		this.add(menuAlterarNomeAbaAtiva2);
		this.showAll();
		this.add(menuExcluirAbaAtiva2);
		this.showAll();
	

		this.menuInformacoesDiretorioArquivo.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuInformacoesDiretorioArquivo_activate(mi);
			}
		});
		this.menuExcluirDiretorioSelecionado.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExcluirDiretorioSelecionado_activate(mi);
			}
		});
		this.menuExpandirDiretorios2.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExpandirDiretorios2_activate(mi);
			}
		});
		this.menuColapsarDiretorios2.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuColapsarDiretorios2_activate(mi);
			}
		});
		this.menuIncluirNovaAba2.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuIncluirNovaAba2_activate(mi);
			}
		});
		this.menuAlterarNomeAbaAtiva2.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuAlterarNomeAbaAtiva2_activate(mi);
			}
		});
		this.menuExcluirAbaAtiva2.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExcluirAbaAtiva2_activate(mi);
			}
		});

	}

	public static void mostrar() 
	{
		
	}

	public void on_menuInformacoesDiretorioArquivo_activate(MenuItem mi){

	}

	public void on_menuExcluirDiretorioSelecionado_activate(MenuItem mi){
		
	}

	public void on_menuExpandirDiretorios2_activate(MenuItem mi){
		
	}

	public void on_menuColapsarDiretorios2_activate(MenuItem mi){
		
	}

	public void on_menuIncluirNovaAba2_activate(MenuItem mi){
		
	}

	public void on_menuAlterarNomeAbaAtiva2_activate(MenuItem mi){
		
	}

	public void on_menuExcluirAbaAtiva2_activate(MenuItem mi){
		
	}


}
