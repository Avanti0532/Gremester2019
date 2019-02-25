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
     current_student.create_profile()

    end
  end

  def update
    @first_name = params[:current_student][:first_name]
    @last_name = params[:current_student][:last_name]
    @gpa = params[:profile][:cgpa].to_f
    @college = params[:profile][:college]
    @toefl = params[:profile][:toefl].to_i
    @gre_writing = params[:profile][:gre_writing].to_f
    @gre_quant = params[:profile][:gre_quant].to_i
    @gre_verbal = params[:profile][:gre_verbal].to_i
    @interested_major = params[:profile][:interested_major]
    @interested_term = params[:profile][:interested_term]
    @interested_year = params[:profile][:interested_year]
    @year_work_exp = params[:profile][:year_work_exp]
    @month_work_exp = params[:profile][:month_work_exp]
    @profile = current_student.current_profile
    @profile.update_cgpa(@gpa)
    @profile.update_college(@college)
    @profile.update_toefl(@toefl)
    @profile.update_gre_writing(@gre_writing)
    @profile.update_gre_quant(@gre_quant)
    @profile.update_gre_verbal(@gre_verbal)
    @profile.update_interested_major(@interested_major)
    @profile.update_interested_term(@interested_term)
    @profile.update_interested_year(@interested_year)
    @profile.update_year_work_experience(@year_work_exp)
    @profile.update_month_work_experience(@month_work_exp)
    @profile.save(:validate => true)
    if !@profile.errors.full_messages.empty?
      error = ''
      @profile.errors.full_messages.each do |message|
        error = error + message + ' '
      end
      flash.now[:notice] = error
      render :edit
    else
      redirect_to profiles_path
    end

  end
end