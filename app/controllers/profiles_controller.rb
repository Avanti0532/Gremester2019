class ProfilesController < ApplicationController
  def profile_params
    params.require(:profile).permit(:id, :photo_id, :sop, :resume, :additional_attachment, :toefl, :gre_writing, :gre_verbal, :gre_quant)
  end

  def index
    @profiles = Profile.all
  end

  def show
    @profile = current_student.current_profile

    if(@profile.nil?)
      current_student.create_profile()
      @profile = current_student.current_profile
    end
    @all_undergrads = Array.new
    @profile.undergrad_universities.each do |university|
      university_detail = ProfilesUndergradUniversity.where(:profile_id => @profile.id, :undergrad_university_id => university.id).first
      details = university.university_name
      details << ', ' << university_detail.degree_type << ' ' if !university_detail.degree_type.nil?
      details << university_detail.major if !university_detail.major.nil?
      details << "\n" << university_detail.start_year.to_s << ' - ' << university_detail.end_year.to_s if !university_detail.start_year.nil? and !university_detail.end_year.nil?
      details << "\n GPA: " << university_detail.cgpa.to_s if !university_detail.cgpa.nil?
      details << ", " << university_detail.grading_scale_type.grading_scale_name if !university_detail.grading_scale_type.nil?
      @all_undergrads << {:details => details.gsub(/\n/, '<br/>').html_safe}
    end
  end

  def edit
    @profile = current_student.current_profile
    if(@profile.nil?)
      current_student.create_profile()
      @profile = current_student.current_profile
    end
    @all_undergrads = Array.new
    @profile.undergrad_universities.each do |university|
      university_detail = ProfilesUndergradUniversity.where(:profile_id => @profile.id, :undergrad_university_id => university.id).first
      details = university.university_name
      details << ', ' << university_detail.degree_type << ' ' if !university_detail.degree_type.nil?
      details << university_detail.major if !university_detail.major.nil?
      details << "\n" << university_detail.start_year.to_s << ' - ' << university_detail.end_year.to_s if !university_detail.start_year.nil? and !university_detail.end_year.nil?
      details << "\n GPA: " << university_detail.cgpa.to_s if !university_detail.cgpa.nil?
      details << ", " << university_detail.grading_scale_type.grading_scale_name if !university_detail.grading_scale_type.nil?
      @all_undergrads << {:details => details.gsub(/\n/, '<br/>').html_safe}
    end
  end

  def new
    @profile = Profile.new
  end

  def getUndergradUniversityByCountry
    @undergrad_universities = Country.where(:name => params[:country]).first.undergrad_universities.order("university_name")
    respond_to do |format|
      format.json {
        render json: {undergrad_universities: @undergrad_universities}
      }
    end
  end

  def update
    @first_name = params[:current_student][:first_name]
    @last_name = params[:current_student][:last_name]
    @college = profile_params[:college]
    @toefl = profile_params[:toefl]
    @gre_writing = profile_params[:gre_writing]
    @gre_quant = profile_params[:gre_quant]
    @gre_verbal = profile_params[:gre_verbal]
    @interested_term = params[:interested_term]
    @interested_year = params[:interested_year]
    @year_work_exp = params[:year_work_exp]
    @profile = current_student.current_profile
    @profile.update_toefl(@toefl.to_i)  if !@toefl.blank?
    @profile.update_gre_writing(@gre_writing.to_f) if !@gre_writing.blank?
    @profile.update_gre_quant(@gre_quant.to_i)  if !@gre_quant.blank?
    @profile.update_gre_verbal(@gre_verbal.to_i) if !@gre_verbal.blank?
    @profile.update_interested_term(@interested_term)  if !@interested_term.blank?
    @profile.update_interested_year(@interested_year)  if !@interested_year.blank?
    @profile.update_year_work_experience(@year_work_exp)  if !@year_work_exp.blank?
    @profile.photo_id = profile_params[:photo_id]
    @profile.sop = profile_params[:sop]
    @profile.resume = profile_params[:resume]
    @profile.gender = params[:gender]
    @profile.degree_objective_master = params[:degree_objective_master]
    @profile.degree_objective_phd = params[:degree_objective_phd]
    @profile.additional_attachment = profile_params[:additional_attachment]
    if !params[:citizenship].blank?
      country_of_origin = Country.find_by_id(params[:citizenship].to_i)
      @profile.country = country_of_origin
    end


    if !params[:undergrad_universities].blank?
      undergrad = UndergradUniversity.find_by_id(params[:undergrad_universities].to_i)
      @profile.undergrad_universities << undergrad
      undergrad_details = ProfilesUndergradUniversity.where(:profile_id => @profile.id, :undergrad_university_id => undergrad.id).first
      if !params[:profiles_undergrad_university].blank?
        undergrad_details.cgpa = params[:profiles_undergrad_university][:cgpa].to_f if !params[:profiles_undergrad_university][:cgpa].blank?
        undergrad_details.grading_scale_type_id = params[:grading_scale].to_i if !params[:grading_scale].blank?
      end
      undergrad_details.major = params[:major_undergrad] if !params[:major_undergrad].blank?
      undergrad_details.degree_type = params[:degree_undergrad] if !params[:degree_undergrad].blank?
      undergrad_details.start_year = params[:undergrad_start_year] if !params[:undergrad_start_year].blank?
      undergrad_details.end_year = params[:undergrad_end_year] if !params[:undergrad_end_year].blank?
      undergrad_details.save
    end

    if !params[:research_interest].blank?
      has_interest = false
      all_student_interests = @profile.research_interests
      params[:research_interest].each  do |interest|
        all_student_interests.each do |i|
          if i.id.eql?(interest.to_i)
            has_interest = true
          end
        end
        if !has_interest
          all_student_interests << ResearchInterest.find_by_id(interest.to_i)
        end
        has_interest = false
      end
    end
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
    gon.universities = University.select('id, university_name').order("university_name")
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
    app_id = params[:application_id]
    @record = Application.where(id: app_id).delete_all
    if @record > 0
      flash[:notice] = 'University is deleted successfully'
    else
      flash[:notice] = 'Error while deleting the university'
    end
    @applications = Application.where(profile_id: profile_id)
    render :json => {'result' => flash[:notice]}
  end

  def fStudentList
    @applications = Application.all
    @research_interests = ResearchInterestsController.new.index
    @undergrad_universities = UndergradUniversitiesController.new.index
  end

  def filter
    if params[:cgpa_score].blank?
      cgpa_low = '0'
      cgpa_high = '5'
    else
      cgpa_values = params[:cgpa_score].to_s.split(" - ");
      cgpa_low = cgpa_values[0]
      cgpa_high = cgpa_values[1]
    end
    if params[:greq_score].blank?
      greq_low = 130
      greq_high = 170
    else
      greq_values = params[:greq_score].to_s.split(" - ");
      greq_low = greq_values[0]
      greq_high = greq_values[1]
    end
    if params[:grev_score].blank?
      grev_low = 130
      grev_high = 170
    else
      grev_values = params[:grev_score].to_s.split(" - ");
      grev_low = grev_values[0]
      grev_high = grev_values[1]
    end
    if params[:msob_score].blank?
      msob_low = 0
      msob_high = 5
    else
      msob_values = params[:msob_score].to_s.split(" - ");
      msob_low = msob_values[0]
      msob_high = msob_values[1]
    end
    if params[:phdo_score].blank?
      phdo_low = 0
      phdo_high = 5
    else
      phdo_values = params[:phdo_score].to_s.split(" - ");
      phdo_low = phdo_values[0]
      phdo_high = phdo_values[1]
    end
    unless params[:undergrad_university].blank?
      if params[:undergrad_university].to_s =~ /^any$/
        profiles_other = Profile.where("profiles.cgpa >= #{cgpa_low} AND profiles.cgpa <= #{cgpa_high} AND "+
                                           "profiles.gre_quant >= #{greq_low} AND profiles.gre_quant <= #{greq_high} AND "+
                                           "profiles.gre_verbal >= #{grev_low} AND profiles.gre_verbal <= #{grev_high} AND "+
                                           "profiles.degree_objective_phd >= #{phdo_low} AND profiles.degree_objective_phd <= #{phdo_high} AND "+
                                           "profiles.degree_objective_master >= #{msob_low} AND profiles.degree_objective_master <= #{msob_high}").all

        unless params[:research_interests].blank?
          if params[:research_interests].to_s =~ /^any$/
            profiles = profiles_other
          elsif params[:research_interests].to_s =~ /^multiple$/
            interests = params[:multiple_interests].to_s.split(",")
            profiles_research_interests = Profile.joins(:research_interests).where("research_interest_id IN (?)", interests)
            profiles = profiles_other.merge(profiles_research_interests)
          else
            interests = params[:research_interests].to_s
            profiles_research_interests = Profile.joins(:research_interests).where("research_interest_id IN (?)", interests)
            profiles = profiles_other.merge(profiles_research_interests)
          end
        end
        if profiles.length >= 1
          applications  = profiles[0].applications
          profiles.each do |profile|
            applications = applications.merge(profile.applications)
          end
          @applications = applications
        else
          @applications = nil
        end

      else

        undergrad_uni = UndergradUniversity.find_by_id(params[:undergrad_university])
        profiles_other = undergrad_uni.profiles.where("profiles.cgpa >= #{cgpa_low} AND profiles.cgpa <= #{cgpa_high} AND "+
                                                    "profiles.gre_quant >= #{greq_low} AND profiles.gre_quant <= #{greq_high} AND "+
                                                    "profiles.gre_verbal >= #{grev_low} AND profiles.gre_verbal <= #{grev_high} AND "+
                                                    "profiles.degree_objective_phd >= #{phdo_low} AND profiles.degree_objective_phd <= #{phdo_high} AND "+
                                                    "profiles.degree_objective_master >= #{msob_low} AND profiles.degree_objective_master <= #{msob_high}").all
        unless params[:research_interests].blank?
          if params[:research_interests].to_s =~ /^any$/
            profiles = profiles_other

          elsif params[:research_interests].to_s =~ /^multiple$/
            interests = params[:multiple_interests].to_s.split(",")
            profiles_research_interests = Profile.joins(:research_interests).where("research_interest_id IN (?)", interests)
            profiles = profiles_other.merge(profiles_research_interests)

          else
            interests = params[:research_interests].to_s
            profiles_research_interests = Profile.joins(:research_interests).where("research_interest_id IN (?)", interests)
            profiles = profiles_other.merge(profiles_research_interests)
          end
            if profiles.length >= 1
              applications  = profiles[0].applications
              profiles.each do |profile|
                applications = applications.merge(profile.applications)
              end
              @applications = applications
            else
              @applications = nil
            end
        end
      end
    end
    @research_interests = ResearchInterestsController.new.index
    @undergrad_universities = UndergradUniversitiesController.new.index

    render 'profiles/fStudentList'
  end
end
