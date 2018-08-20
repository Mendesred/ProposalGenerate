class AddNameEndRoleToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :nome, :string
    add_column :admins, :privilegio, :integer
  end
end
