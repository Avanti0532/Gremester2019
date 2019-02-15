module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_admin
      flash.clear
      redirect_to rails_admin_path, notice: "You are logged in"
    elsif current_faculty
      redirect_to root_path, notice: "You are logged in"
    elsif current_student
      flash.clear
      redirect_to root_path, notice: "You are logged in"
    end
  end
end