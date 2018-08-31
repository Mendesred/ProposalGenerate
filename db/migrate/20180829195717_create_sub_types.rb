class CreateSubTypes < ActiveRecord::Migration
  def change
    create_table :sub_types do |t|
      t.string :name_sub_type

      t.timestamps null: false
    end
  end
end
