class AddTotalParaAjusteAndValorDeAjusteToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :total_para_ajuste, :float
    add_column :proposals, :valor_de_ajuste, :float
  end
end
