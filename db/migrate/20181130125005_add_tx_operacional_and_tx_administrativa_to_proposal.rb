class AddTxOperacionalAndTxAdministrativaToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :txopracional, :float
    add_column :proposals, :txadministrativa, :float
  end
end
