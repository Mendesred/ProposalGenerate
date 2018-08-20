class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name_company
      t.float :irrf
      t.float :csll
      t.float :pis
      t.float :cofins
      t.float :seguro_aci_trabalho
      t.float :pct_reserva_tecnica

      t.timestamps null: false
    end
  end
end
