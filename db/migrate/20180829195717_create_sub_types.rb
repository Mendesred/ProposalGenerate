class CreateSubTypes < ActiveRecord::Migration
  def change
    create_table :sub_types do |t|
      t.string :name_sub_type
      t.references :type_equipament, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
