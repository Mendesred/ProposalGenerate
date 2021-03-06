class CreateProposalRoles < ActiveRecord::Migration
  def change
    create_table :proposal_roles do |t|
      t.float :qtd_postos
      t.string :cargo
      t.float :salario
      t.float :gratificacao
      t.references :proposal, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
