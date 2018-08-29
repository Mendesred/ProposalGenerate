class TypeEquipament < ActiveRecord::Base
	has_many :equipaments
	has_many :equipaments_proposal
end
