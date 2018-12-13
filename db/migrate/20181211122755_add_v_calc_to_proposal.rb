class AddVCalcToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :v_calc, :float
  end
end
