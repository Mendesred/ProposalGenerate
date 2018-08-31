class CreateEquipaments < ActiveRecord::Migration
  def change
    create_table :equipaments do |t|
      t.string :fornecedor
      t.references :type_equipament, index: true, foreign_key: true
      t.references :sub_type, index: true, foreign_key: true
      t.string :name_equipament
      t.string :maca_mod
      t.integer :rec_manutencao
      t.float :valor
      t.float :depreciacao
      t.text :obs_equipament
      t.references :proposal, index: true, foreign_key: true
      t.datetime :updated_date_valor
      t.timestamps null: false
    end
  end
end
