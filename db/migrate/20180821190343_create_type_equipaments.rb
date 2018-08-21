class CreateTypeEquipaments < ActiveRecord::Migration
  def change
    create_table :type_equipaments do |t|
      t.string :typeEquipament

      t.timestamps null: false
    end
  end
end
