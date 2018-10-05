class AddValorHorasPropostaAndValorDiaPropostaToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :valor_horas_proposta, :float
    add_column :proposals, :valor_dia_proposta, :float
  end
end
