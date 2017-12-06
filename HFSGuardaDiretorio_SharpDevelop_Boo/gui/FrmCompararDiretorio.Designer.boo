/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 11:44
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace HFSGuardaDiretorio.gui

partial internal class FrmCompararDiretorio:

	private components as System.ComponentModel.IContainer = null

	
	protected override def Dispose(disposing as bool):
		if disposing:
			if components is not null:
				components.Dispose()
		super.Dispose(disposing)

	
	private def InitializeComponent():
		self.components = System.ComponentModel.Container()
		resources as System.ComponentModel.ComponentResourceManager = System.ComponentModel.ComponentResourceManager(typeof(FrmCompararDiretorio))
		self.panel1 = System.Windows.Forms.Panel()
		self.pb = System.Windows.Forms.ProgressBar()
		self.btnSalvarLog = System.Windows.Forms.Button()
		self.btnCompararDiretorios = System.Windows.Forms.Button()
		self.gpDiretorio1 = System.Windows.Forms.GroupBox()
		self.tvDiretorio1 = System.Windows.Forms.TreeView()
		self.imageList1 = System.Windows.Forms.ImageList(self.components)
		self.cmbAba1 = System.Windows.Forms.ComboBox()
		self.gpDiretorio2 = System.Windows.Forms.GroupBox()
		self.tvDiretorio2 = System.Windows.Forms.TreeView()
		self.cmbAba2 = System.Windows.Forms.ComboBox()
		self.barraStatus = System.Windows.Forms.StatusStrip()
		self.labStatus1 = System.Windows.Forms.ToolStripStatusLabel()
		self.labStatus2 = System.Windows.Forms.ToolStripStatusLabel()
		self.label1 = System.Windows.Forms.Label()
		self.lvCompara = System.Windows.Forms.ListView()
		self.columnHeader10 = System.Windows.Forms.ColumnHeader()
		self.columnHeader11 = System.Windows.Forms.ColumnHeader()
		self.columnHeader12 = System.Windows.Forms.ColumnHeader()
		self.columnHeader13 = System.Windows.Forms.ColumnHeader()
		self.columnHeader14 = System.Windows.Forms.ColumnHeader()
		self.columnHeader15 = System.Windows.Forms.ColumnHeader()
		self.panel1.SuspendLayout()
		self.gpDiretorio1.SuspendLayout()
		self.gpDiretorio2.SuspendLayout()
		self.barraStatus.SuspendLayout()
		self.SuspendLayout()
		// 
		// panel1
		// 
		self.panel1.Controls.Add(self.pb)
		self.panel1.Controls.Add(self.btnSalvarLog)
		self.panel1.Controls.Add(self.btnCompararDiretorios)
		self.panel1.Dock = System.Windows.Forms.DockStyle.Top
		self.panel1.Location = System.Drawing.Point(0, 0)
		self.panel1.Name = 'panel1'
		self.panel1.Size = System.Drawing.Size(687, 37)
		self.panel1.TabIndex = 0
		// 
		// pb
		// 
		self.pb.Location = System.Drawing.Point(136, 10)
		self.pb.Name = 'pb'
		self.pb.Size = System.Drawing.Size(446, 19)
		self.pb.Step = 1
		self.pb.TabIndex = 2
		// 
		// btnSalvarLog
		// 
		self.btnSalvarLog.Location = System.Drawing.Point(588, 8)
		self.btnSalvarLog.Name = 'btnSalvarLog'
		self.btnSalvarLog.Size = System.Drawing.Size(87, 23)
		self.btnSalvarLog.TabIndex = 1
		self.btnSalvarLog.Text = '&Salvar Log'
		self.btnSalvarLog.UseVisualStyleBackColor = true
		self.btnSalvarLog.Click += self.BtnSalvarLogClick
		// 
		// btnCompararDiretorios
		// 
		self.btnCompararDiretorios.Location = System.Drawing.Point(12, 8)
		self.btnCompararDiretorios.Name = 'btnCompararDiretorios'
		self.btnCompararDiretorios.Size = System.Drawing.Size(118, 23)
		self.btnCompararDiretorios.TabIndex = 0
		self.btnCompararDiretorios.Text = '&Comparar Diretórios'
		self.btnCompararDiretorios.UseVisualStyleBackColor = true
		self.btnCompararDiretorios.Click += self.BtnCompararDiretoriosClick
		// 
		// gpDiretorio1
		// 
		self.gpDiretorio1.Controls.Add(self.tvDiretorio1)
		self.gpDiretorio1.Controls.Add(self.cmbAba1)
		self.gpDiretorio1.Location = System.Drawing.Point(12, 43)
		self.gpDiretorio1.Name = 'gpDiretorio1'
		self.gpDiretorio1.Size = System.Drawing.Size(329, 284)
		self.gpDiretorio1.TabIndex = 1
		self.gpDiretorio1.TabStop = false
		self.gpDiretorio1.Text = 'Diretório 1'
		// 
		// tvDiretorio1
		// 
		self.tvDiretorio1.ImageIndex = 0
		self.tvDiretorio1.ImageList = self.imageList1
		self.tvDiretorio1.Location = System.Drawing.Point(6, 46)
		self.tvDiretorio1.Name = 'tvDiretorio1'
		self.tvDiretorio1.SelectedImageIndex = 0
		self.tvDiretorio1.Size = System.Drawing.Size(317, 232)
		self.tvDiretorio1.TabIndex = 1
		// 
		// imageList1
		// 
		self.imageList1.ImageStream = (resources.GetObject('imageList1.ImageStream') cast System.Windows.Forms.ImageListStreamer)
		self.imageList1.TransparentColor = System.Drawing.Color.Transparent
		self.imageList1.Images.SetKeyName(0, 'Fechar.bmp')
		self.imageList1.Images.SetKeyName(1, 'Abrir.bmp')
		// 
		// cmbAba1
		// 
		self.cmbAba1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		self.cmbAba1.FormattingEnabled = true
		self.cmbAba1.Location = System.Drawing.Point(6, 19)
		self.cmbAba1.Name = 'cmbAba1'
		self.cmbAba1.Size = System.Drawing.Size(317, 21)
		self.cmbAba1.TabIndex = 0
		self.cmbAba1.SelectedIndexChanged += self.CmbAba1SelectedIndexChanged
		// 
		// gpDiretorio2
		// 
		self.gpDiretorio2.Controls.Add(self.tvDiretorio2)
		self.gpDiretorio2.Controls.Add(self.cmbAba2)
		self.gpDiretorio2.Location = System.Drawing.Point(347, 43)
		self.gpDiretorio2.Name = 'gpDiretorio2'
		self.gpDiretorio2.Size = System.Drawing.Size(329, 284)
		self.gpDiretorio2.TabIndex = 2
		self.gpDiretorio2.TabStop = false
		self.gpDiretorio2.Text = 'Diretório 2'
		// 
		// tvDiretorio2
		// 
		self.tvDiretorio2.ImageIndex = 0
		self.tvDiretorio2.ImageList = self.imageList1
		self.tvDiretorio2.Location = System.Drawing.Point(6, 46)
		self.tvDiretorio2.Name = 'tvDiretorio2'
		self.tvDiretorio2.SelectedImageIndex = 0
		self.tvDiretorio2.Size = System.Drawing.Size(317, 232)
		self.tvDiretorio2.TabIndex = 1
		// 
		// cmbAba2
		// 
		self.cmbAba2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		self.cmbAba2.FormattingEnabled = true
		self.cmbAba2.Location = System.Drawing.Point(6, 19)
		self.cmbAba2.Name = 'cmbAba2'
		self.cmbAba2.Size = System.Drawing.Size(317, 21)
		self.cmbAba2.TabIndex = 0
		self.cmbAba2.SelectedIndexChanged += self.CmbAba2SelectedIndexChanged
		// 
		// barraStatus
		// 
		self.barraStatus.Items.AddRange((of System.Windows.Forms.ToolStripItem: self.labStatus1, self.labStatus2))
		self.barraStatus.Location = System.Drawing.Point(0, 558)
		self.barraStatus.Name = 'barraStatus'
		self.barraStatus.Size = System.Drawing.Size(687, 22)
		self.barraStatus.TabIndex = 10
		self.barraStatus.Text = 'statusStrip1'
		// 
		// labStatus1
		// 
		self.labStatus1.AutoSize = false
		self.labStatus1.BorderSides = ((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom) cast System.Windows.Forms.ToolStripStatusLabelBorderSides)
		self.labStatus1.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self.labStatus1.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self.labStatus1.Name = 'labStatus1'
		self.labStatus1.Size = System.Drawing.Size(200, 17)
		self.labStatus1.Text = 'Total de diferenças encontradas:'
		self.labStatus1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// labStatus2
		// 
		self.labStatus2.BorderSides = ((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom) cast System.Windows.Forms.ToolStripStatusLabelBorderSides)
		self.labStatus2.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self.labStatus2.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self.labStatus2.Name = 'labStatus2'
		self.labStatus2.Size = System.Drawing.Size(472, 17)
		self.labStatus2.Spring = true
		self.labStatus2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// label1
		// 
		self.label1.Location = System.Drawing.Point(8, 330)
		self.label1.Name = 'label1'
		self.label1.Size = System.Drawing.Size(138, 18)
		self.label1.TabIndex = 11
		self.label1.Text = 'Diferenças Encontradas'
		// 
		// lvCompara
		// 
		self.lvCompara.Columns.AddRange((of System.Windows.Forms.ColumnHeader: self.columnHeader10, self.columnHeader11, self.columnHeader12, self.columnHeader13, self.columnHeader14, self.columnHeader15))
		self.lvCompara.FullRowSelect = true
		self.lvCompara.GridLines = true
		self.lvCompara.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable
		self.lvCompara.Location = System.Drawing.Point(0, 351)
		self.lvCompara.MultiSelect = false
		self.lvCompara.Name = 'lvCompara'
		self.lvCompara.Size = System.Drawing.Size(687, 205)
		self.lvCompara.SmallImageList = self.imageList1
		self.lvCompara.TabIndex = 12
		self.lvCompara.UseCompatibleStateImageBehavior = false
		self.lvCompara.View = System.Windows.Forms.View.Details
		// 
		// columnHeader10
		// 
		self.columnHeader10.Text = 'Nome'
		self.columnHeader10.Width = 300
		// 
		// columnHeader11
		// 
		self.columnHeader11.Text = 'Tamanho'
		self.columnHeader11.Width = 100
		// 
		// columnHeader12
		// 
		self.columnHeader12.Text = 'Tipo'
		self.columnHeader12.Width = 70
		// 
		// columnHeader13
		// 
		self.columnHeader13.Text = 'Modificado'
		self.columnHeader13.Width = 120
		// 
		// columnHeader14
		// 
		self.columnHeader14.Text = 'Atributos'
		self.columnHeader14.Width = 90
		// 
		// columnHeader15
		// 
		self.columnHeader15.Text = 'Caminho'
		self.columnHeader15.Width = 300
		// 
		// FrmCompararDiretorio
		// 
		self.AutoScaleDimensions = System.Drawing.SizeF(6.0F, 13.0F)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(687, 580)
		self.Controls.Add(self.lvCompara)
		self.Controls.Add(self.label1)
		self.Controls.Add(self.barraStatus)
		self.Controls.Add(self.gpDiretorio2)
		self.Controls.Add(self.gpDiretorio1)
		self.Controls.Add(self.panel1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MaximizeBox = false
		self.MinimizeBox = false
		self.Name = 'FrmCompararDiretorio'
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = 'Comparar Diretórios'
		self.panel1.ResumeLayout(false)
		self.gpDiretorio1.ResumeLayout(false)
		self.gpDiretorio2.ResumeLayout(false)
		self.barraStatus.ResumeLayout(false)
		self.barraStatus.PerformLayout()
		self.ResumeLayout(false)
		self.PerformLayout()

	private columnHeader15 as System.Windows.Forms.ColumnHeader

	private columnHeader14 as System.Windows.Forms.ColumnHeader

	private columnHeader13 as System.Windows.Forms.ColumnHeader

	private columnHeader12 as System.Windows.Forms.ColumnHeader

	private columnHeader11 as System.Windows.Forms.ColumnHeader

	private columnHeader10 as System.Windows.Forms.ColumnHeader

	private lvCompara as System.Windows.Forms.ListView

	private label1 as System.Windows.Forms.Label

	private labStatus2 as System.Windows.Forms.ToolStripStatusLabel

	private labStatus1 as System.Windows.Forms.ToolStripStatusLabel

	private barraStatus as System.Windows.Forms.StatusStrip

	private imageList1 as System.Windows.Forms.ImageList

	private cmbAba2 as System.Windows.Forms.ComboBox

	private tvDiretorio2 as System.Windows.Forms.TreeView

	private gpDiretorio2 as System.Windows.Forms.GroupBox

	private tvDiretorio1 as System.Windows.Forms.TreeView

	private cmbAba1 as System.Windows.Forms.ComboBox

	private gpDiretorio1 as System.Windows.Forms.GroupBox

	public pb as System.Windows.Forms.ProgressBar

	private btnCompararDiretorios as System.Windows.Forms.Button

	private btnSalvarLog as System.Windows.Forms.Button

	private panel1 as System.Windows.Forms.Panel

