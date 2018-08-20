class CreateEquipaments < ActiveRecord::Migration
  def change
    create_table :equipaments do |t|
      t.string :name_equipament
      t.float :valor
      t.float :depreciacao
      t.references :proposal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
