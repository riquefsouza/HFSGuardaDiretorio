package hfsguardadir.gui;

import hfsguardadir.catalogador.Catalogador;
import hfsguardadir.comum.Rotinas;
import hfsguardadir.comum.StringList;
import static hfsguardadir.comum.TipoExportarExtensao.teBMP;
import static hfsguardadir.comum.TipoExportarExtensao.teGIF;
import static hfsguardadir.comum.TipoExportarExtensao.teICO;
import static hfsguardadir.comum.TipoExportarExtensao.teJPG;
import static hfsguardadir.comum.TipoExportarExtensao.tePNG;
import static hfsguardadir.comum.TipoExportarExtensao.teTIF;
import hfsguardadir.objetos.Extensao;
import hfsguardadir.objetosbo.ExtensaoBO;
import hfsguardadir.objetosgui.Dialogo;
import hfsguardadir.objetosgui.EscolhaArquivo;
import hfsguardadir.objetosgui.TabelaExtensao;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FrmCadExtensao extends javax.swing.JDialog {
    private TabelaExtensao tabelaExtensao;
    private Catalogador catalogador;
    
    public FrmCadExtensao(java.awt.Frame parent, boolean modal) {
        super(parent, modal);        
        initComponents();
        mudarLingua();
        
        FrmPrincipal frmPrincipal = (FrmPrincipal) parent;
        catalogador = frmPrincipal.getCatalogador();        
        
        CarregarExtensoesNaGrid();
    } 

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        scrollExtensao = new javax.swing.JScrollPane();
        panelBotao = new javax.swing.JPanel();
        btnIncluir = new javax.swing.JButton();
        btnExcluir = new javax.swing.JButton();
        barraMenu = new javax.swing.JMenuBar();
        menuExtensao = new javax.swing.JMenu();
        menuIncluirExtensao = new javax.swing.JMenuItem();
        menuExcluirExtensao = new javax.swing.JMenuItem();
        menuExcluirTodasExtensoes = new javax.swing.JMenuItem();
        menuExportarTodos = new javax.swing.JMenu();
        menuExportarBitmap = new javax.swing.JMenuItem();
        menuExportarIcone = new javax.swing.JMenuItem();
        menuExportarGIF = new javax.swing.JMenuItem();
        menuExportarJPEG = new javax.swing.JMenuItem();
        menuExportarPNG = new javax.swing.JMenuItem();
        menuExportarTIFF = new javax.swing.JMenuItem();
        menuImportarTodos = new javax.swing.JMenu();
        menuImportarIconesArquivos = new javax.swing.JMenuItem();
        menuExtrairIconesArquivos = new javax.swing.JMenuItem();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("hfsguardadir/recursos/hfsguardadiretorio_pt"); // NOI18N
        setTitle(bundle.getString("FrmCadExtensao.titulo")); // NOI18N
        setModal(true);
        setResizable(false);
        getContentPane().add(scrollExtensao, java.awt.BorderLayout.CENTER);

        btnIncluir.setMnemonic('I');
        btnIncluir.setText(bundle.getString("FrmCadExtensao.btnIncluir")); // NOI18N
        btnIncluir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnIncluirActionPerformed(evt);
            }
        });
        panelBotao.add(btnIncluir);

        btnExcluir.setMnemonic('E');
        btnExcluir.setText(bundle.getString("FrmCadExtensao.btnExcluir")); // NOI18N
        btnExcluir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnExcluirActionPerformed(evt);
            }
        });
        panelBotao.add(btnExcluir);

        getContentPane().add(panelBotao, java.awt.BorderLayout.SOUTH);

        menuExtensao.setText(bundle.getString("FrmCadExtensao.menuExtensao")); // NOI18N

        menuIncluirExtensao.setText(bundle.getString("FrmCadExtensao.menuIncluirExtensao")); // NOI18N
        menuIncluirExtensao.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuIncluirExtensaoActionPerformed(evt);
            }
        });
        menuExtensao.add(menuIncluirExtensao);

        menuExcluirExtensao.setText(bundle.getString("FrmCadExtensao.menuExcluirExtensao")); // NOI18N
        menuExcluirExtensao.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuExcluirExtensaoActionPerformed(evt);
            }
        });
        menuExtensao.add(menuExcluirExtensao);

        menuExcluirTodasExtensoes.setText(bundle.getString("FrmCadExtensao.menuExcluirTodasExtensoes")); // NOI18N
        menuExcluirTodasExtensoes.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuExcluirTodasExtensoesActionPerformed(evt);
            }
        });
        menuExtensao.add(menuExcluirTodasExtensoes);

        barraMenu.add(menuExtensao);

        menuExportarTodos.setText(bundle.getString("FrmCadExtensao.menuExportarTodos")); // NOI18N

        menuExportarBitmap.setText(bundle.getString("FrmCadExtensao.menuExportarBitmap")); // NOI18N
        menuExportarBitmap.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuExportarBitmapActionPerformed(evt);
            }
        });
        menuExportarTodos.add(menuExportarBitmap);

        menuExportarIcone.setText(bundle.getString("FrmCadExtensao.menuExportarIcone")); // NOI18N
        menuExportarIcone.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuExportarIconeActionPerformed(evt);
            }
        });
        menuExportarTodos.add(menuExportarIcone);

        menuExportarGIF.setText(bundle.getString("FrmCadExtensao.menuExportarGIF")); // NOI18N
        menuExportarGIF.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuExportarGIFActionPerformed(evt);
            }
        });
        menuExportarTodos.add(menuExportarGIF);

        menuExportarJPEG.setText(bundle.getString("FrmCadExtensao.menuExportarJPEG")); // NOI18N
        menuExportarJPEG.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuExportarJPEGActionPerformed(evt);
            }
        });
        menuExportarTodos.add(menuExportarJPEG);

        menuExportarPNG.setText(bundle.getString("FrmCadExtensao.menuExportarPNG")); // NOI18N
        menuExportarPNG.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuExportarPNGActionPerformed(evt);
            }
        });
        menuExportarTodos.add(menuExportarPNG);

        menuExportarTIFF.setText(bundle.getString("FrmCadExtensao.menuExportarTIFF")); // NOI18N
        menuExportarTIFF.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuExportarTIFFActionPerformed(evt);
            }
        });
        menuExportarTodos.add(menuExportarTIFF);

        barraMenu.add(menuExportarTodos);

        menuImportarTodos.setText(bundle.getString("FrmCadExtensao.menuImportarTodos")); // NOI18N

        menuImportarIconesArquivos.setText(bundle.getString("FrmCadExtensao.menuImportarIconesArquivos")); // NOI18N
        menuImportarIconesArquivos.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuImportarIconesArquivosActionPerformed(evt);
            }
        });
        menuImportarTodos.add(menuImportarIconesArquivos);

        menuExtrairIconesArquivos.setText(bundle.getString("FrmCadExtensao.menuExtrairIconesArquivos")); // NOI18N
        menuExtrairIconesArquivos.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuExtrairIconesArquivosActionPerformed(evt);
            }
        });
        menuImportarTodos.add(menuExtrairIconesArquivos);

        barraMenu.add(menuImportarTodos);

        setJMenuBar(barraMenu);

        setSize(new java.awt.Dimension(297, 385));
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void btnIncluirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnIncluirActionPerformed
        menuIncluirExtensaoActionPerformed(null);
    }//GEN-LAST:event_btnIncluirActionPerformed

    private void btnExcluirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnExcluirActionPerformed
        menuExcluirExtensaoActionPerformed(null);
    }//GEN-LAST:event_btnExcluirActionPerformed

    private void menuIncluirExtensaoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuIncluirExtensaoActionPerformed
        EscolhaArquivo escolha = new EscolhaArquivo(
                EscolhaArquivo.PREVIEW_OPEN_DIALOG);
        int retval = escolha.mostrarAbrir(this);
        StringList log;
        
        if (retval == EscolhaArquivo.APPROVE_OPTION) {
            File arquivo = escolha.getSelectedFile();
            if (arquivo != null) {
                log = new StringList();
                try {
                    if (ExtensaoBO.getInstancia().SalvarExtensao(
                            catalogador.listaExtensoes, arquivo.getName(),
                            arquivo.getAbsolutePath(), log)) {

                        CarregarExtensoesNaGrid();

                        Dialogo.mensagemInfo(this,
                                "FrmCadExtensao.ExtensaoSalvaSucesso");
                    } else {
                        Dialogo.mensagemInfo(this,
                                "FrmCadExtensao.ExtensaoJaCadastrada");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }//GEN-LAST:event_menuIncluirExtensaoActionPerformed

    private void menuExcluirExtensaoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuExcluirExtensaoActionPerformed
        Extensao extensao;

        if (catalogador.listaExtensoes.size() > 0) {
            int res = Dialogo.confirma(this, "FrmCadExtensao.ExtensaoCertezaExcluir");
            if (res == Dialogo.YES_OPTION) {
                extensao = ExtensaoBO.getInstancia().pegaExtensaoPorOrdem(
                        catalogador.listaExtensoes, tabelaExtensao.getSelectedRow()+1);

                try {
                    if (ExtensaoBO.getInstancia().excluirExtensao(
                            catalogador.listaExtensoes, extensao.getCodigo())) {
                        CarregarExtensoesNaGrid();
                        Dialogo.mensagemInfo(this,
                                "FrmCadExtensao.ExtensaoExcluidaSucesso");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }//GEN-LAST:event_menuExcluirExtensaoActionPerformed

    private void menuExcluirTodasExtensoesActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuExcluirTodasExtensoesActionPerformed
        if (catalogador.listaExtensoes.size() > 0) {
            int res = Dialogo.confirma(this, "FrmCadExtensao.ExtensaoCertezaTodosExcluir");
            if (res == Dialogo.YES_OPTION) {
                try {
                    if (ExtensaoBO.getInstancia().excluirTodasExtensoes(
                            catalogador.listaExtensoes)) {
                        CarregarExtensoesNaGrid();
                        Dialogo.mensagemInfo(this,
                                "FrmCadExtensao.ExtensoesExcluidasSucesso");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

    }//GEN-LAST:event_menuExcluirTodasExtensoesActionPerformed

    private void menuExportarIconeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuExportarIconeActionPerformed
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(teICO, 
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo(this, "FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_menuExportarIconeActionPerformed

    private void menuExportarGIFActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuExportarGIFActionPerformed
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(teGIF, 
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo(this, "FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_menuExportarGIFActionPerformed

    private void menuExportarJPEGActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuExportarJPEGActionPerformed
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(teJPG, 
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo(this, "FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_menuExportarJPEGActionPerformed

    private void menuExportarPNGActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuExportarPNGActionPerformed
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(tePNG, 
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo(this, "FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_menuExportarPNGActionPerformed

    private void menuExportarTIFFActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuExportarTIFFActionPerformed
        try {
            if (ExtensaoBO.getInstancia().ExportarExtensao(teTIF, 
                    catalogador.listaExtensoes)) {
                Dialogo.mensagemInfo(this, "FrmCadExtensao.ExportarExtensao");
            }
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_menuExportarTIFFActionPerformed

    private void menuImportarIconesArquivosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuImportarIconesArquivosActionPerformed
        String sCaminho;
        EscolhaArquivo escolha = new EscolhaArquivo(
                EscolhaArquivo.CUSTOM_DIALOG);
        int retval = escolha.mostrar(this);
        if (retval == EscolhaArquivo.APPROVE_OPTION) {
            File arquivo = escolha.getSelectedFile();

            if (arquivo != null) {
                sCaminho = arquivo.getPath();
                try {
                    ExtensaoBO.getInstancia().ImportarExtensao(sCaminho,
                            catalogador.listaExtensoes);
                    CarregarExtensoesNaGrid();
                } catch (SQLException ex) {
                    Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IOException ex) {
                    Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
                }                
            }
        }
    }//GEN-LAST:event_menuImportarIconesArquivosActionPerformed

    private void menuExtrairIconesArquivosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuExtrairIconesArquivosActionPerformed
        String sCaminho;
        EscolhaArquivo escolha = new EscolhaArquivo(
                EscolhaArquivo.CUSTOM_DIALOG);
        int retval = escolha.mostrar(this);
        if (retval == EscolhaArquivo.APPROVE_OPTION) {
            File arquivo = escolha.getSelectedFile();

            if (arquivo != null) {
                sCaminho = arquivo.getPath();
                try {
                    ExtensaoBO.getInstancia().ExtrairExtensao(sCaminho,
                            catalogador.listaExtensoes);
                    CarregarExtensoesNaGrid();
                } catch (SQLException ex) {
                    Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
                }                
            }
        }
    }//GEN-LAST:event_menuExtrairIconesArquivosActionPerformed

    private void menuExportarBitmapActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuExportarBitmapActionPerformed
        try {
            ExtensaoBO.getInstancia().ExportarExtensao(teBMP, 
                    catalogador.listaExtensoes);
        } catch (IOException ex) {
            Logger.getLogger(FrmCadExtensao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_menuExportarBitmapActionPerformed

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JMenuBar barraMenu;
    private javax.swing.JButton btnExcluir;
    private javax.swing.JButton btnIncluir;
    private javax.swing.JMenuItem menuExcluirExtensao;
    private javax.swing.JMenuItem menuExcluirTodasExtensoes;
    private javax.swing.JMenuItem menuExportarBitmap;
    private javax.swing.JMenuItem menuExportarGIF;
    private javax.swing.JMenuItem menuExportarIcone;
    private javax.swing.JMenuItem menuExportarJPEG;
    private javax.swing.JMenuItem menuExportarPNG;
    private javax.swing.JMenuItem menuExportarTIFF;
    private javax.swing.JMenu menuExportarTodos;
    private javax.swing.JMenu menuExtensao;
    private javax.swing.JMenuItem menuExtrairIconesArquivos;
    private javax.swing.JMenuItem menuImportarIconesArquivos;
    private javax.swing.JMenu menuImportarTodos;
    private javax.swing.JMenuItem menuIncluirExtensao;
    private javax.swing.JPanel panelBotao;
    private javax.swing.JScrollPane scrollExtensao;
    // End of variables declaration//GEN-END:variables

    private void CarregarExtensoesNaGrid() {
        tabelaExtensao = new TabelaExtensao(catalogador.listaExtensoes);
        tabelaExtensao.getSelectionModel().setSelectionInterval(0, 0);        
        scrollExtensao.setViewportView(tabelaExtensao);
    }

    private void mudarLingua() {
        setTitle(Rotinas.getRecurso("FrmCadExtensao.titulo"));
        btnIncluir.setText(Rotinas.getRecurso("FrmCadExtensao.btnIncluir"));
        btnExcluir.setText(Rotinas.getRecurso("FrmCadExtensao.btnExcluir"));
        menuExtensao.setText(Rotinas.getRecurso("FrmCadExtensao.menuExtensao"));
        menuIncluirExtensao.setText(Rotinas.getRecurso("FrmCadExtensao.menuIncluirExtensao"));
        menuExcluirExtensao.setText(Rotinas.getRecurso("FrmCadExtensao.menuExcluirExtensao"));
        menuExcluirTodasExtensoes.setText(Rotinas.getRecurso("FrmCadExtensao.menuExcluirTodasExtensoes"));
        menuExportarTodos.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarTodos"));
        menuExportarBitmap.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarBitmap"));
        menuExportarIcone.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarIcone"));
        menuExportarGIF.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarGIF"));
        menuExportarJPEG.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarJPEG"));
        menuExportarPNG.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarPNG"));
        menuExportarTIFF.setText(Rotinas.getRecurso("FrmCadExtensao.menuExportarTIFF"));
        menuImportarTodos.setText(Rotinas.getRecurso("FrmCadExtensao.menuImportarTodos"));
        menuImportarIconesArquivos.setText(Rotinas.getRecurso("FrmCadExtensao.menuImportarIconesArquivos"));
        menuExtrairIconesArquivos.setText(Rotinas.getRecurso("FrmCadExtensao.menuExtrairIconesArquivos"));
    }    
}
