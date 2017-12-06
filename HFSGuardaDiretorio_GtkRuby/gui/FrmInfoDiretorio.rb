require "mscorlib"

			require "mscorlib"

require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	class FrmInfoDiretorio < Gtk::Dialog
		def initialize()
			self.Build()
			self.ConstruirGrid()
		end

		def OnBtnOkClicked(sender, e)
			self.Hide()
		end

		def ConstruirGrid()
			rtexto = CellRendererText.new()
			rtexto.FontDesc = Pango.FontDescription.FromString("Bold")
			tabelaInfo.AppendColumn("Item", rtexto, "text", 0)
			tabelaInfo.AppendColumn("Descrição", CellRendererText.new(), "text", 1)
			#tabelaInfo.Columns [0].MinWidth = 108;
			#tabelaInfo.Columns [1].MinWidth = 214;
			tabelaInfo.Columns[0].SortColumnId = 1
			tabelaInfo.Columns[0].Resizable = true
			tabelaInfo.Columns[0].Sizing = TreeViewColumnSizing.Autosize
			tabelaInfo.Columns[1].SortColumnId = 1
			tabelaInfo.Columns[1].Resizable = true
			tabelaInfo.Columns[1].Sizing = TreeViewColumnSizing.Autosize
			lstore = ListStore.new(System::String.to_clr_type, System::String.to_clr_type)
			tabelaInfo.Model = lstore
		end

		def setDiretorio(diretorio)
			if diretorio != nil then
				lstore = tabelaInfo.Model
				lstore.AppendValues("Aba:", diretorio.Aba.Nome)
				lstore.AppendValues("Nome:", diretorio.Nome)
				lstore.AppendValues("Tamanho:", diretorio.TamanhoFormatado)
				lstore.AppendValues("Tipo:", diretorio.Tipo.Nome)
				lstore.AppendValues("Modificado:", diretorio.ModificadoFormatado)
				lstore.AppendValues("Atributos:", diretorio.Atributos)
				lstore.AppendValues("Caminho:", diretorio.Caminho)
			end
		end
	end
end