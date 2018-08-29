class Equipament < ActiveRecord::Base
	belongs_to :type_equipament
	has_many :proposal_equipaments
  #has_many :proposals, :through => :proposal_equipaments

  def name_select
    "N#{id}-#{name_equipament}-#{depreciacao}-#{valor}"
  end

end
