class CreateProposalEquipaments < ActiveRecord::Migration
  def change
    create_table :proposal_equipaments do |t|
      t.references :type_equipament, index: true, foreign_key: true
      t.references :equipament, index: true, foreign_key: true
      t.references :proposal, index: true, foreign_key: true
      t.string :name_equipament
      t.float :quantidade
      t.float :depreciacao_aux
      t.float :valor_equipament
      t.float :valor_depreciado

      t.timestamps null: false
    end
  end
end
