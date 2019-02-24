class ProfilesController < ApplicationController

  def index
    @profile = current_student.current_profile
    if(@profile.nil?)
      @profile = Profile.new()
      @profile.update_college('')
      @profile.update_gre_quant('')
      @profile.update_gre_verbal('')
      @profile.update_gre_writing('')
      @profile.update_toefl('')
      @profile.update_cgpa('')
      @profile.update_interested_major(' ')
      @profile.update_interested_term(' ')
      @profile.update_year_work_experience(' ')
      @profile.update_month_work_experience(' ')
      @profile.update_resume_data('')
      @profile.update_sop_data('')
      @profile.update_additional_attachment_data('')
    end
  end

  def edit

  end
end