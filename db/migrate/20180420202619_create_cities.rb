class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :nome
      t.float :feriado
      t.float :valeTransporte
      t.float :issqn

      t.timestamps null: false
    end
  end
end
