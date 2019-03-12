class ProfilesController < ApplicationController
  def profile_params
    params.require(:profile).permit(:id, :photo_id, :sop, :resume, :additional_attachment, :cgpa, :college, :toefl, :gre_writing, :gre_verbal, :gre_quant, :interested_major, :interested_term, :interested_year, :year_work_exp, :month_work_exp)
  end

  def index
    @profiles = Profile.all
  end

  def show
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

  def getUndergradUniversityByCountry
    @undergrad_universities = Country.where(:name => params[:country]).first.undergrad_universities
    respond_to do |format|
      format.json {
        render json: {undergrad_universities: @undergrad_universities}
      }
    end
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
    if !params[:undergrad_universities].blank?
      undergrad = UndergradUniversity.find_by_id(params[:undergrad_universities].to_i)
      @profile.undergrad_universities << undergrad
    end
    @profile.save(:validate => true)

    @profile.save(:validate => true)
    current_student.update_attribute(:first_name, @first_name) if !@first_name.blank?
    current_student.update_attribute(:last_name, @last_name) if !@last_name.blank?
    @undergrad_universities = nil
    if !@profile.errors.full_messages.empty?
      error = ''
      @profile.errors.full_messages.each do |message|
        error = error + message + ' '
      end
      flash.now[:notice] = error
      render :edit
    else
      redirect_to profile_path
    end

  end

  def showschools
    gon.universities = University.select('id, university_name')
    id = params[:id]
    @applications = Application.where(profile_id:id)
    render 'profiles/sInterestedSchools'
  end

  def addschools
    profile_id = current_student.current_profile.id
    if params[:univ_name].blank? or params[:sel_opt].blank? or params[:datepicker].blank?
      flash[:notice] = 'Please enter all the fields'
    else
      @university = University.find_by_university_name(params[:univ_name])
      @applications_new = Application.where(profile_id:profile_id, university_id: @university.id)
      if @applications_new.blank?
        @applications = Application.add_school!(profile_id,@university.id ,params[:sel_opt], params[:datepicker])
        if @applications
          flash[:notice] = 'University application successfully added to database'
        else
          flash[:notice] = 'Error while saving application to database'
        end
      else
        flash[:notice] = 'University is already present. Please add a new one'
      end
    end
    @applications = Application.where(profile_id: profile_id)
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def deleteschools
    profile_id = current_student.current_profile.id
    @deletion = Application.where(profile_id: profile_id , university_id: params[:university_id]).delete_all
    if @deletion > 0
      flash[:notice] = 'University is deleted successfully'
    else
      flash[:notice] = 'Error while deleting the university'
    end
    @applications = Application.where(profile_id: profile_id)
    redirect_to show_profiles_path(profile_id)
  end

  def fStudentList
    @applications = Application.all
  end
end
