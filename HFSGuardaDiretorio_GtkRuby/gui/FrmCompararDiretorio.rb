require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	class FrmCompararDiretorio < Gtk::Window
		def initialize(frmPrincipal)
			self.Build()
			@listaCompara = List[Diretorio].new()
			@frmCompararDiretorioProgresso = FrmCompararDiretorioProgresso.new(self)
			@catalogador = frmPrincipal.Catalogador
			Arvore.Instancia.Construir(tvDiretorio1)
			Arvore.Instancia.Construir(tvDiretorio2)
			Tabela.Instancia.Construir(true, tabelaCompara)
			self.CarregarDados()
			self.LimparComparacao()
		end

		def PBar
			return self.@pb
		end

		def LabStatus1
			frameStatus1 = barraStatus1.Children[0]
			hboxStatus1 = frameStatus1.Child
			return hboxStatus1.Children[0]
		end

		def LabStatus2
			frameStatus2 = barraStatus2.Children[0]
			hboxStatus2 = frameStatus2.Child
			return hboxStatus2.Children[0]
		end

		def OnBtnCompararDiretoriosClicked(sender, e)
			sCaminhoDir1 = ""
			sCaminhoDir2 = ""
			bSelecionado = false
			tvDiretorio1.Selection.GetSelected(modelo1, iter1)
			if tvDiretorio1.Selection.IterIsSelected(iter1) then
				store1 = modelo1
				@catalogador.LerArvoreDiretorio(store1, iter1, self.LabStatus2)
				sCaminhoDir1 = self.LabStatus2.Text
				tvDiretorio2.Selection.GetSelected(modelo2, iter2)
				if tvDiretorio2.Selection.IterIsSelected(iter2) then
					store2 = modelo2
					@catalogador.LerArvoreDiretorio(store2, iter2, self.LabStatus2)
					sCaminhoDir2 = self.LabStatus2.Text
					bSelecionado = true
				end
			end
			self.LimparComparacao()
			if bSelecionado then
				self.Comparar(sCaminhoDir1, sCaminhoDir2)
			else
				Dialogo.mensagemInfo("Diretórios não selecionados!")
			end
		end

		def OnBtnSalvarLogClicked(sender, e)
			if @listaCompara.Count > 0 then
				listaLocal = StringList.new()
				sLog = Rotinas.ExtractFilePath(Rotinas.ExecutablePath()) + System.IO.Path.DirectorySeparatorChar + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) + "_Comparacao.log"
				enumerator = listaCompara.GetEnumerator()
				while enumerator.MoveNext()
					diretorio = enumerator.Current
					listaLocal.Add(diretorio.Caminho)
				end
				listaLocal.SaveToFile(sLog)
				Dialogo.mensagemInfo("Log salvo no mesmo diretório do sistema!")
			end
		end

		def OnCmbAba1Changed(sender, e)
			GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
			tvDiretorio1Store = tvDiretorio1.Model
			tvDiretorio1Store.Clear()
			aba = AbaBO.Instancia.pegaAbaPorOrdem(@catalogador.listaAbas, cmbAba1.Active + 1)
			@catalogador.CarregarArvore(tvDiretorio1, aba)
			tvDiretorio1.GrabFocus()
			self.LimparComparacao()
			GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
		end

		def OnCmbAba2Changed(sender, e)
			GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
			tvDiretorio2Store = tvDiretorio2.Model
			tvDiretorio2Store.Clear()
			aba = AbaBO.Instancia.pegaAbaPorOrdem(@catalogador.listaAbas, cmbAba2.Active + 1)
			@catalogador.CarregarArvore(tvDiretorio2, aba)
			tvDiretorio2.GrabFocus()
			self.LimparComparacao()
			GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
		end

		def CarregarDados()
			enumerator = @catalogador.listaAbas.GetEnumerator()
			while enumerator.MoveNext()
				aba = enumerator.Current
				cmbAba1.AppendText(aba.Nome)
				cmbAba2.AppendText(aba.Nome)
			end
			cmbAba1.Model.GetIterFirst(iter)
			cmbAba1.SetActiveIter(iter)
			cmbAba2.Model.GetIterFirst(iter)
			cmbAba2.SetActiveIter(iter)
		end

		def LimparComparacao()
			pb.Fraction = 0
			tabelaStore = tabelaCompara.Model
			tabelaStore.Clear()
			btnSalvarLog.Sensitive = false
			self.LabStatus2.Text = ""
		end

		def SQLCompara(aba1, aba2, caminho1, caminho2)
			sSQL = DiretorioBO.SQL_CONSULTA_ARQUIVO + " WHERE aba=" + aba1.Codigo + " AND caminho LIKE " + Rotinas.QuotedStr(caminho1 + "%") + " AND nome NOT IN (SELECT nome FROM Diretorios " + " WHERE aba=" + aba2.Codigo + " AND caminho LIKE " + Rotinas.QuotedStr(caminho2 + "%") + ")" + " ORDER BY 1, 2, 3"
			return sSQL
		end

		def Comparar(sCaminhoDir1, sCaminhoDir2)
			aba1 = AbaBO.Instancia.pegaAbaPorOrdem(@catalogador.listaAbas, cmbAba1.Active + 1)
			aba2 = AbaBO.Instancia.pegaAbaPorOrdem(@catalogador.listaAbas, cmbAba2.Active + 1)
			sSQL = self.SQLCompara(aba1, aba2, sCaminhoDir1, sCaminhoDir2)
			@listaCompara = DiretorioBO.Instancia.carregarDiretorio(sSQL, "consultaarquivo", @frmCompararDiretorioProgresso)
			if @listaCompara.Count > 0 then
				Tabela.Instancia.Carregar(true, tabelaCompara, @listaCompara, @catalogador.listaExtensoes, pb)
				tamLista = @listaCompara.Count
				self.LabStatus2.Text = tamLista.ToString()
				btnSalvarLog.Sensitive = true
			else
				Dialogo.mensagemInfo("Nenhuma diferença encontrada!")
			end
		end
	end
end