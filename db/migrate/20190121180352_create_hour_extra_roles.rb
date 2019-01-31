class CreateHourExtraRoles < ActiveRecord::Migration
  def change
    create_table :hour_extra_roles do |t|
      t.references :proposal_hour_extra, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true

      t.timestamps null: false

      t.string :cargo
			t.float :salario
			t.float :salario_um_cargo
			
    end
  end
end
