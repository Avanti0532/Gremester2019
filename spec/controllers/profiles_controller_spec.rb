require 'spec_helper'
require 'rails_helper'

describe ProfilesController do
  describe 'show current user profile' do
    it 'should render index template' do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      controller.stub(:current_student).and_return(mock_student)
      get :index, {:id => 1}
      response.should render_template('index')
    end

    it 'should populate profile data when it is null' do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      controller.stub(:current_student).and_return(mock_student)
      get :index, {:id => 1}
      expect(assigns(:profile)).not_to be_nil
    end
  end
  describe 'edit current user profile' do
    it 'should render edit template when profile is created' do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      controller.stub(:current_student).and_return(mock_student)
      get :edit, {:id => 1}
      response.should render_template('edit')
    end

    it 'should populate profile data when it is null' do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      controller.stub(:current_student).and_return(mock_student)
      get :index, {:id => 1}
      expect(assigns(:profile)).not_to be_nil
    end
  end
  describe 'update current user profile' do
    it 'should redirect to profile on successful update' do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      mock_profile = Profile.create(student_id: 1)
      controller.stub(:current_student).and_return(mock_student)
      controller.instance_eval {@profile = mock_profile}
      post :update, {"profile"=>{"photo_id"=>"", "college"=>"uiowa", "cgpa"=>"3.4", "toefl"=>"110", "gre_writing"=>"4.0", "gre_quant"=>"130", "gre_verbal"=>"140", "interested_major"=>"", "interested_term"=>"", "interested_year"=>"", "year_work_exp"=>"", "month_work_exp"=>"", "sop"=>"", "resume"=>"", "additional_attachment"=>""}, "current_student"=>{"first_name"=>"Avanti", "last_name"=>"Deshmukh"}, "id"=>"1"}
      response.should redirect_to(profiles_path)
    end

    it 'should stay on same page on unsuccessful update' do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      mock_profile = Profile.create(student_id: 1)
      controller.stub(:current_student).and_return(mock_student)
      controller.instance_eval {@profile = mock_profile}
      post :update, {"profile"=>{"photo_id"=>"", "college"=>"uiowa", "cgpa"=>"3.4", "toefl"=>"110", "gre_writing"=>"9.0", "gre_quant"=>"890", "gre_verbal"=>"140", "interested_major"=>"", "interested_term"=>"", "interested_year"=>"", "year_work_exp"=>"", "month_work_exp"=>"", "sop"=>"", "resume"=>"", "additional_attachment"=>""}, "current_student"=>{"first_name"=>"Avanti", "last_name"=>"Deshmukh"}, "id"=>"1"}
      response.should render_template('edit')
    end
  end
  describe 'show list of schools' do
    it 'should show list of schools added by a student' do
      application = Application.new(id: 1, profile_id: 1, university_id: 1, applied: 't', applied_date: '2019-01-02', admitted: 't', admitted_date: '2019-03-05', rejected: '', rejected_date:'')
      application.save
      expect(Application).to receive(:where).with(profile_id: '1').and_return(application)
      get :showschools, {:id => '1'}
      response.should render_template('profiles/sInterestedSchools')
    end
  end

  describe 'Add schools' do
    before :each do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      @mock_profile = Profile.create(id:1, student_id: 1)
      controller.stub(:current_student).and_return(mock_student)
      controller.instance_eval {@profile = @mock_profile}
      @university = University.new(id: 1, rank: 1, university_name: 'Stanford University')
      @university.save
      @application_new = Application.new(:id => 2, :profile_id=> 1, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'t',:admitted_date=>'2019-04-23',:rejected=>'',:rejected_date=>'')
      @application_new.save
      @application = Application.new(:id => 1, :profile_id=> 1, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'')
      @application.save
      format = double("format")
      format.should_receive(:js).and_return("location.reload();")
      controller.should_receive(:respond_to).and_yield(format)
    end
    it 'should throw error when fields are empty' do
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"", "sel_opt"=>""}
      expect(flash[:notice]).to eq('Please enter all the fields')
    end
    it 'should call appropriate model method to add school to database' do
      expect(University).to receive(:find_by_university_name).with("Stanford University").and_return(@university)
      allow(Application).to receive(:where).and_return(nil)
      expect(Application).to receive(:add_school!).and_return(@application)
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted"}
    end
    it 'should flash successful message when school is added successfully' do
      expect(University).to receive(:find_by_university_name).with("Stanford University").and_return(@university)
      allow(Application).to receive(:where).and_return(nil)
      expect(Application).to receive(:add_school!).and_return(@application)
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted"}
      expect(flash[:notice]).to eq('University application successfully added to database')
    end
    it 'should flash error message when school is not added to the database' do
      expect(University).to receive(:find_by_university_name).with("Stanford University").and_return(@university)
      allow(Application).to receive(:where).and_return(nil)
      expect(Application).to receive(:add_school!).and_return(nil)
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted"}
      expect(flash[:notice]).to eq('Error while saving application to database')
    end
    it 'should flash error message when school is already present in the database' do
      expect(University).to receive(:find_by_university_name).with("Stanford University").and_return(@university)
      allow(Application).to receive(:where).and_return(@application_new)
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted"}
      expect(flash[:notice]).to eq('University is already present. Please add a new one')
    end
    it 'shoud render interested school template' do
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted"}
      expect(response).to render_template("profiles/addschools")
    end
  end

  describe 'Delete Schools' do
  before :each do
    mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
    @mock_profile = Profile.create(id:1, student_id: 1)
    controller.stub(:current_student).and_return(mock_student)
    controller.instance_eval {@profile = @mock_profile}
    @univ_id = "1"
    @application = Application.new(:id => 1, :profile_id=> 1, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'')
    @application.save
    @deletion = double("application")
  end
    it 'should flash successful message when school is deleted successfully' do
      allow(Application.where(profile_id: @mock_profile.id, university_id:@univ_id)).to receive(:destroy_all).and_return(@deletion)
      post :deleteschools, {"university_id"=> "1"}
      expect(flash[:notice]).to eq('University is deleted successfully')
    end
    it 'should flash unsuccessful message for unsuccessful deletion' do
      allow(Application.where(profile_id: @mock_profile.id, university_id: "2")).to receive(:destroy_all).and_return(nil)
      post :deleteschools, {"university_id"=> "1"}
      expect(flash[:notice]).to eq('Error while deleting University')
    end
  end
end
