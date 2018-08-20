class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :type
      t.float :value

      t.timestamps null: false
    end
  end
end
