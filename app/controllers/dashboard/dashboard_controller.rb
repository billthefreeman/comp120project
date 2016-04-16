class Dashboard::DashboardController < ApplicationController
	before_action :configure_permitted_parameters, if: :devise_controller?


	protected
	def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:user_name, :last_name, :first_name, :phone, :email, :group_id, :password, :password_confirmation) }
	end
end