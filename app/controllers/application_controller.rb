class ApplicationController < ActionController::Base
  before_action :set_locale
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	# pundit
	include Pundit

	#Manager pundit erros
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def pundit_user
  	current_admin #current_user em vez do pundit
	end

  def user_not_authorized
    flash[:alert] = "Você não esta autorizado a executar essa ação."
    redirect_to(request.referrer || root_path)
  end

end
