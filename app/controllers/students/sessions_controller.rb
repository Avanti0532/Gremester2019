class Students::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy

  # to override the SessionsController#create and save profile_id to session variable : method 2
  # def create
  #   profile = Profile.joins("INNER JOIN students ON students.id=profiles.student_id AND students.username='#{current_student.username}'")
  #   session[:current_profile] = profile.id
  #   root_path
  # end
end
