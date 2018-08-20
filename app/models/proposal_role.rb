class ProposalRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :proposal

  accepts_nested_attributes_for :role, reject_if: :all_blank, allow_destroy:true
end
