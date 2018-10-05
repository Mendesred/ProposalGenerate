class AddTotComReservaIndceOpIndiceAdmToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :tot_com_reserva_indce_op_indice_adm, :float
  end
end
