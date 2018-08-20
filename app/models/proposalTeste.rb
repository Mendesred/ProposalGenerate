class Proposal < ActiveRecord::Base
  belongs_to :city
  belongs_to :rotation
  belongs_to :company
  #belongs_to :role  #por hora a conecção sera has_many

  has_many :proposal_equipaments
  has_many :proposal_roles
  #has_many :equipaments, :through => :proposal_equipaments




  accepts_nested_attributes_for :proposal_equipaments, allow_destroy:true
  accepts_nested_attributes_for :proposal_roles, allow_destroy:true

  after_save :sum_equipament

  private

  def sum_equipament
    @proposal.proposal_equipaments.each do |proposal_equipament| # for usado para pegar todos os equipamentos adcionados na proposta.
    totalEquipamento += (proposal_equipament.quantidade*
                          (proposal_equipament.equipament.valor.to_f / 
                            proposal_equipament.equipament.depreciacao.to_f ))# total do valor de equipamento (usar na soma de totais).
  end
    update_column(:totalEquipamento, (totalEquipamento))
  end 
end

 # fim do for proposal_equipament.
