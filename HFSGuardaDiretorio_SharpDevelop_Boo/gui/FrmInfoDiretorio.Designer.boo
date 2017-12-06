/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 11:11
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace HFSGuardaDiretorio.gui

partial internal class FrmInfoDiretorio:

	private components as System.ComponentModel.IContainer = null

	
	protected override def Dispose(disposing as bool):
		if disposing:
			if components is not null:
				components.Dispose()
		super.Dispose(disposing)

	
	private def InitializeComponent():
		listViewItem1 as System.Windows.Forms.ListViewItem = System.Windows.Forms.ListViewItem('Aba:')
		listViewItem2 as System.Windows.Forms.ListViewItem = System.Windows.Forms.ListViewItem('Nome:')
		listViewItem3 as System.Windows.Forms.ListViewItem = System.Windows.Forms.ListViewItem('Tamanho:')
		listViewItem4 as System.Windows.Forms.ListViewItem = System.Windows.Forms.ListViewItem('Tipo:')
		listViewItem5 as System.Windows.Forms.ListViewItem = System.Windows.Forms.ListViewItem('Modificado:')
		listViewItem6 as System.Windows.Forms.ListViewItem = System.Windows.Forms.ListViewItem('Atributos:')
		listViewItem7 as System.Windows.Forms.ListViewItem = System.Windows.Forms.ListViewItem('Caminho:')
		self.groupBox1 = System.Windows.Forms.GroupBox()
		self.label5 = System.Windows.Forms.Label()
		self.label6 = System.Windows.Forms.Label()
		self.label3 = System.Windows.Forms.Label()
		self.label4 = System.Windows.Forms.Label()
		self.label2 = System.Windows.Forms.Label()
		self.label1 = System.Windows.Forms.Label()
		self.lvInfo = System.Windows.Forms.ListView()
		self.columnHeader1 = System.Windows.Forms.ColumnHeader()
		self.columnHeader2 = System.Windows.Forms.ColumnHeader()
		self.btnOk = System.Windows.Forms.Button()
		self.groupBox1.SuspendLayout()
		self.SuspendLayout()
		// 
		// groupBox1
		// 
		self.groupBox1.Controls.Add(self.label5)
		self.groupBox1.Controls.Add(self.label6)
		self.groupBox1.Controls.Add(self.label3)
		self.groupBox1.Controls.Add(self.label4)
		self.groupBox1.Controls.Add(self.label2)
		self.groupBox1.Controls.Add(self.label1)
		self.groupBox1.Location = System.Drawing.Point(12, 12)
		self.groupBox1.Name = 'groupBox1'
		self.groupBox1.Size = System.Drawing.Size(340, 96)
		self.groupBox1.TabIndex = 0
		self.groupBox1.TabStop = false
		self.groupBox1.Text = 'Legenda dos Atributos'
		// 
		// label5
		// 
		self.label5.Location = System.Drawing.Point(166, 62)
		self.label5.Name = 'label5'
		self.label5.Size = System.Drawing.Size(168, 23)
		self.label5.TabIndex = 5
		self.label5.Text = '[ROL] - Arquivo Somente Leitura'
		self.label5.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// label6
		// 
		self.label6.Location = System.Drawing.Point(6, 62)
		self.label6.Name = 'label6'
		self.label6.Size = System.Drawing.Size(154, 23)
		self.label6.TabIndex = 4
		self.label6.Text = '[SYS] - Arquivo de Sistema'
		self.label6.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// label3
		// 
		self.label3.Location = System.Drawing.Point(166, 39)
		self.label3.Name = 'label3'
		self.label3.Size = System.Drawing.Size(168, 23)
		self.label3.TabIndex = 3
		self.label3.Text = '[VOL] - Volume ID'
		self.label3.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// label4
		// 
		self.label4.Location = System.Drawing.Point(6, 39)
		self.label4.Name = 'label4'
		self.label4.Size = System.Drawing.Size(154, 23)
		self.label4.TabIndex = 2
		self.label4.Text = '[HID] - Arquivo Oculto'
		self.label4.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// label2
		// 
		self.label2.Location = System.Drawing.Point(166, 16)
		self.label2.Name = 'label2'
		self.label2.Size = System.Drawing.Size(168, 23)
		self.label2.TabIndex = 1
		self.label2.Text = '[DIR] - Diretório'
		self.label2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// label1
		// 
		self.label1.Location = System.Drawing.Point(6, 16)
		self.label1.Name = 'label1'
		self.label1.Size = System.Drawing.Size(154, 23)
		self.label1.TabIndex = 0
		self.label1.Text = '[ARQ] - Arquivo comum'
		self.label1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// lvInfo
		// 
		self.lvInfo.Columns.AddRange((of System.Windows.Forms.ColumnHeader: self.columnHeader1, self.columnHeader2))
		self.lvInfo.GridLines = true
		self.lvInfo.Items.AddRange((of System.Windows.Forms.ListViewItem: listViewItem1, listViewItem2, listViewItem3, listViewItem4, listViewItem5, listViewItem6, listViewItem7))
		self.lvInfo.Location = System.Drawing.Point(18, 114)
		self.lvInfo.MultiSelect = false
		self.lvInfo.Name = 'lvInfo'
		self.lvInfo.OwnerDraw = true
		self.lvInfo.Size = System.Drawing.Size(328, 181)
		self.lvInfo.TabIndex = 1
		self.lvInfo.UseCompatibleStateImageBehavior = false
		self.lvInfo.View = System.Windows.Forms.View.Details
		self.lvInfo.DrawColumnHeader += self.LvInfoDrawColumnHeader
		self.lvInfo.DrawItem += self.LvInfoDrawItem
		self.lvInfo.DrawSubItem += self.LvInfoDrawSubItem
		// 
		// columnHeader1
		// 
		self.columnHeader1.Text = 'Item'
		self.columnHeader1.Width = 108
		// 
		// columnHeader2
		// 
		self.columnHeader2.Text = 'Descrição'
		self.columnHeader2.Width = 214
		// 
		// btnOk
		// 
		self.btnOk.Location = System.Drawing.Point(146, 309)
		self.btnOk.Name = 'btnOk'
		self.btnOk.Size = System.Drawing.Size(75, 23)
		self.btnOk.TabIndex = 2
		self.btnOk.Text = '&Ok'
		self.btnOk.UseVisualStyleBackColor = true
		self.btnOk.Click += self.BtnOkClick
		// 
		// FrmInfoDiretorio
		// 
		self.AutoScaleDimensions = System.Drawing.SizeF(6.0F, 13.0F)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(363, 344)
		self.Controls.Add(self.btnOk)
		self.Controls.Add(self.lvInfo)
		self.Controls.Add(self.groupBox1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MaximizeBox = false
		self.MinimizeBox = false
		self.Name = 'FrmInfoDiretorio'
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
		self.Text = 'Informações do Diretório / Arquivo'
		self.groupBox1.ResumeLayout(false)
		self.ResumeLayout(false)

	private columnHeader2 as System.Windows.Forms.ColumnHeader

	private columnHeader1 as System.Windows.Forms.ColumnHeader

	private btnOk as System.Windows.Forms.Button

	private lvInfo as System.Windows.Forms.ListView

	private label1 as System.Windows.Forms.Label

	private label2 as System.Windows.Forms.Label

	private label4 as System.Windows.Forms.Label

	private label3 as System.Windows.Forms.Label

	private label6 as System.Windows.Forms.Label

	private label5 as System.Windows.Forms.Label

	private groupBox1 as System.Windows.Forms.GroupBox

