class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :tipo_servico
      t.references :company, index: true, foreign_key: true
      t.float :desconto_vr
      t.float :cesta
      


      t.timestamps null: false
    end
  end
end
