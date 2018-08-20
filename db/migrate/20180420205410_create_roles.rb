class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :cargo
      t.float :salario
      t.float :gratificacao
      t.float :vale_refeicao
      t.float :assist_medica
      t.float :seg_vida
      t.float :uniformes
      t.float :assist_Soc_Familiar
      t.float :beneficio_Natalidade
      t.float :ppr

      t.references :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
