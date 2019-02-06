class ApplicationController < ActionController::Base
  before_action :authenticate_student!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #
  #

  protect_from_forgery with: :null_session

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    render text: 'Invalid authenticity token', status: :unprocessable_entity
  end

  respond_to :json

  def home
    render 'layouts/application'
  end

  private def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:username, :first_name, :last_name]
  end

end
