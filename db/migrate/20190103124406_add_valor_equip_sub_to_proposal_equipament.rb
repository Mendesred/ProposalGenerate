class AddValorEquipSubToProposalEquipament < ActiveRecord::Migration
  def change
    add_column :proposal_equipaments, :valorEquipSub, :float
  end
end
