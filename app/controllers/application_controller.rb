
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :email, :password, :password_confirmation, :id_card, :weblink, :university_id])
  end

  # to override the SessionsController#create and save profile_id to session variable : method 1
  # def after_sign_in_path_for(resource)
  #   profile = Profile.joins("INNER JOIN students ON students.id=profiles.student_id AND students.username='#{current_student.username}'")
  #   session[:current_profile] = profile.id
  #   root_path
  # end

end

