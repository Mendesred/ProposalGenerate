module ApplicationHelper

	def criate_date(date)
	 	# formatting date: Aug, 31 2007 - 9:55PM
	 	date.strftime("  %m /%b /%Y - %H:%M")
  end
  	def update_date(date)
	 	# formatting date: Aug, 31 2007 - 9:55PM
	 	date.strftime("  %m /%b /%Y ")
  end

end
