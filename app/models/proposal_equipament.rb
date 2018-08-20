class ProposalEquipament < ActiveRecord::Base
  belongs_to :equipament
  belongs_to :proposal

  accepts_nested_attributes_for :equipament, reject_if: :all_blank, allow_destroy:true
end
