package hfsguardadir.objetos;

public class InfoDiretorio {

    private String item;
    private String descricao;

    public InfoDiretorio(String item, String descricao){
        this.item = item;
        this.descricao = descricao;
    }
    
    /**
     * @return the item
     */
    public String getItem() {
        return item;
    }

    /**
     * @param item the item to set
     */
    public void setItem(String item) {
        this.item = item;
    }

    /**
     * @return the descricao
     */
    public String getDescricao() {
        return descricao;
    }

    /**
     * @param descricao the descricao to set
     */
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

}
