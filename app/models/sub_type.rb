class SubType < ActiveRecord::Base
	has_many :equipaments
	has_many :equipaments_proposal
	belongs_to :type_equipament

def name_select
    "#{name_sub_type} (id:#{id})"
  end

  def name_select2
    "#{name_sub_type} (#{type_equipament.name_type})"
  end


end
