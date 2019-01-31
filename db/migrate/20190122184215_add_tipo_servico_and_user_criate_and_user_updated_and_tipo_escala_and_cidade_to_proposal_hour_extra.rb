class AddTipoServicoAndUserCriateAndUserUpdatedAndTipoEscalaAndCidadeToProposalHourExtra < ActiveRecord::Migration
  def change
    add_column :proposal_hour_extras, :tipo_servico, :string
    add_column :proposal_hour_extras, :user_criate, :string
    add_column :proposal_hour_extras, :user_update, :string
    add_column :proposal_hour_extras, :tipo_escala, :string
    add_column :proposal_hour_extras, :cidade, :string
  end
end
