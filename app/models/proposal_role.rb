class ProposalRole < ActiveRecord::Base
	belongs_to :role
	belongs_to :proposal

	accepts_nested_attributes_for :role, reject_if: :all_blank, allow_destroy:true
	after_save :routine_save

	private
	def routine_save

		cargo = self.role.cargo 
		update_column(:cargo, (cargo))
		salario = self.role.salario
		update_column(:salario, (salario))
		gratificacao = self.role.gratificacao
		update_column(:gratificacao, (gratificacao))    
		
	end
end
