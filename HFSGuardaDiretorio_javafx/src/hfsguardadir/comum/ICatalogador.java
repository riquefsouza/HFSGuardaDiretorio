package hfsguardadir.comum;

import hfsguardadir.objetos.Aba;

public interface ICatalogador {
    public Aba getAbaSelecionada();
    public void DuploCliqueLista(String nome, String tipo);
    public void EncontrarItemLista(int codigoAba, String nome, String caminho);
}
