class ApplicationMainController < ApplicationController

	before_action :authenticate_admin!
	layout "mainLayouts"

end
