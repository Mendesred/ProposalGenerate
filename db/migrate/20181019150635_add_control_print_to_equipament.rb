class AddControlPrintToEquipament < ActiveRecord::Migration
  def change
    add_column :equipaments, :control_print, :integer
  end
end
