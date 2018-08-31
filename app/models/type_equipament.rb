class TypeEquipament < ActiveRecord::Base
	has_many :equipaments
	has_many :sub_types
	has_many :equipaments_proposal
end
