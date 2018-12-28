class AddReciclagemToRole < ActiveRecord::Migration
  def change
    add_column :roles, :reciclagem, :integer
  end
end
