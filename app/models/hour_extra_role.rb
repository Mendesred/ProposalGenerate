class HourExtraRole < ActiveRecord::Base
	belongs_to :role
	belongs_to :proposal_hour_extra


	after_save :routine_save

	private
	def routine_save
		
		cargo = self.role.cargo 
		update_column(:cargo, (cargo))
		salario = self.role.salario
		update_column(:salario, (salario))
		
	end
end
