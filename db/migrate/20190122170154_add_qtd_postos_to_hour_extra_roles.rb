class AddQtdPostosToHourExtraRoles < ActiveRecord::Migration
  def change
    add_column :hour_extra_roles, :qtd_postos, :integer
  end
end
