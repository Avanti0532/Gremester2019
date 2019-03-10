class ProfilesController < ApplicationController
  @profile
  def profile_params
    params.require(:profile).permit(:id, :photo_id, :sop, :resume, :additional_attachment, :cgpa, :college, :toefl, :gre_writing, :gre_verbal, :gre_quant, :interested_major, :interested_term, :interested_year, :year_work_exp, :month_work_exp)
  end

  def index
    @profiles = Profile.all
  end
  def show
    if !(current_student.current_profile) then
      id = params[:id]
      @profile = Profile.joins("INNER JOIN students ON students.id=profiles.student_id AND students.username='#{id}'")
    else
      @profile = current_student.current_profile
    end

    if(@profile.nil?) then
      @profile = Profile.new()
      @profile.update_college('')
      @profile.update_gre_quant('')
      @profile.update_gre_verbal('')
      @profile.update_gre_writing('')
      @profile.update_toefl('')
      @profile.update_cgpa('')
      @profile.update_interested_major('')
      @profile.update_interested_term('')
      @profile.update_year_work_experience('')
      @profile.update_month_work_experience('')
      @profile.update_resume_data('')
      @profile.update_sop_data('')
      @profile.update_additional_attachment_data('')
    end
  end

  def edit
    @profile = current_student.current_profile
    if(@profile.nil?) then
      @profile = Profile.new()
      @profile.update_college('')
      @profile.update_gre_quant('')
      @profile.update_gre_verbal('')
      @profile.update_gre_writing('')
      @profile.update_toefl('')
      @profile.update_cgpa('')
      @profile.update_interested_major('')
      @profile.update_interested_term('')
      @profile.update_year_work_experience('')
      @profile.update_month_work_experience('')
      @profile.update_resume_data('')
      @profile.update_sop_data('')
      @profile.update_additional_attachment_data('')
      current_student.create_profile()

    end
  end

  def new
    @profile = Profile.new()
  end

  def create
    params = profile_params
    @profile = Profile.create(:college => params[:college], :cgpa => params[:cgpa], :toefl => params[:toefl],
                   :gre_quant => params[:gre_quant], :gre_verbal => params[:gre_verbal], :gre_writing => params[:gre_writing],
                   :interested_major => params[:interested_major], :interested_year => params[:interested_year],
                   :interested_term => params[:interested_term], :year_work_exp => params[:year_work_exp],
                   :month_work_exp => params[:month_work_exp], :resume => params[:resume], :sop => params[:sop],
                   :additional_attachment => params[:additional_attachment], :student_id => current_student.id)
    if !@profile.errors.full_messages.empty?
      error = ''
      @profile.errors.full_messages.each do |message|
        error = error + message + ' '
      end
      flash.now[:notice] = error
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    @first_name = params[:current_student][:first_name]
    @last_name = params[:current_student][:last_name]
    @gpa = profile_params[:cgpa]
    @college = profile_params[:college]
    @toefl = profile_params[:toefl]
    @gre_writing = profile_params[:gre_writing]
    @gre_quant = profile_params[:gre_quant]
    @gre_verbal = profile_params[:gre_verbal]
    @interested_major = profile_params[:interested_major]
    @interested_term = profile_params[:interested_term]
    @interested_year = profile_params[:interested_year]
    @year_work_exp = profile_params[:year_work_exp]
    @month_work_exp = profile_params[:month_work_exp]
    @profile = current_student.current_profile
    @profile.update_cgpa(@gpa.to_f) if !@gpa.blank?
    @profile.update_college(@college) if !@college.blank?
    @profile.update_toefl(@toefl.to_i)  if !@toefl.blank?
    @profile.update_gre_writing(@gre_writing.to_f) if !@gre_writing.blank?
    @profile.update_gre_quant(@gre_quant.to_i)  if !@gre_quant.blank?
    @profile.update_gre_verbal(@gre_verbal.to_i) if !@gre_verbal.blank?
    @profile.update_interested_major(@interested_major) if !@interested_major.blank?
    @profile.update_interested_term(@interested_term)  if !@interested_term.blank?
    @profile.update_interested_year(@interested_year)  if !@interested_year.blank?
    @profile.update_year_work_experience(@year_work_exp.to_i)  if !@year_work_exp.blank?
    @profile.update_month_work_experience(@month_work_exp.to_i)  if !@month_work_exp.blank?
    @profile.photo_id = profile_params[:photo_id]
    @profile.sop = profile_params[:sop]
    @profile.resume = profile_params[:resume]
    @profile.additional_attachment = profile_params[:additional_attachment]
    @profile.save(:validate => true)
    current_student.update_attribute(:first_name, @first_name) if !@first_name.blank?
    current_student.update_attribute(:last_name, @last_name) if !@last_name.blank?

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