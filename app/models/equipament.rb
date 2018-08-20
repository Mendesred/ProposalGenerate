class Equipament < ActiveRecord::Base

  #has_many :proposal_equipaments
  #has_many :proposals, :through => :proposal_equipaments

  def name_select
    "#{id} #{name_equipament}"
  end

end
