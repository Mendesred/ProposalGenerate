class CreateRotations < ActiveRecord::Migration
  def change
    create_table :rotations do |t|
      t.string :tipo_escala
      t.float :dias_trabalhados
      t.float :qtd_funcionarios
      t.float :efetivo
      t.float :v_reciclagem
      t.float :fator_escala
      t.references :period, index: true, foreign_key: true
      t.float :ad_vespertido_noturno
      t.float :ad_noturno    

      t.timestamps null: false
    end
  end
end
