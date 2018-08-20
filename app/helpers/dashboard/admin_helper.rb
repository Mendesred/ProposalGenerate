module Dashboard::AdminHelper

	OptionsForPrivilegios = Struct.new(:id, :description)

	def option_for_privilegio
		options = []

		Admin.privilegios do|key,value|
			options.push(OptionsForPrivilegios.new(key,value))
		end

		options
	end

end
