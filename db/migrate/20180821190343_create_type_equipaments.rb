class CreateTypeEquipaments < ActiveRecord::Migration
  def change
    create_table :type_equipaments do |t|
      t.string :name_type

      t.timestamps null: false
    end
  end
end
