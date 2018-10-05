class CreateEquipaments < ActiveRecord::Migration
  def change
    create_table :type_equipaments do |t|
      t.string :name_type

      t.timestamps null: false
    end

    create_table :sub_types do |t|
      t.string :name_sub_type
      t.references :type_equipament, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :equipaments do |t|
      t.string :fornecedor
      t.references :type_equipament, index: true, foreign_key: true
      t.references :sub_type, index: true, foreign_key: true
      t.string :name_equipament
      t.string :marca_mod
      t.integer :rec_manutencao
      t.float :valor
      t.float :depreciacao
      t.text :obs_equipament
      t.datetime :updated_date_valor
      t.timestamps null: false
    end
  end
end
