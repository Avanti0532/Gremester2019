require 'spec_helper'
require 'rails_helper'

describe ProfilesController do
  describe 'show current user profile' do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      @mock_profile = Profile.create(id:1, student_id: 1)
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      ProfilesUndergradUniversity.create(:profile_id => 1, :undergrad_university_id => 1, :cgpa => '3.4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
    end

    it 'should render index template' do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      controller.stub(:current_student).and_return(mock_student)
      get :show, {:id => 1}
      response.should render_template('show')
    end

    it 'should populate profile data when it is null' do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      controller.stub(:current_student).and_return(mock_student)
      get :show, {:id => 1}
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
      get :show, {:id => 1}
      expect(assigns(:profile)).not_to be_nil
    end
  end
  describe 'update current user profile' do
    before :each do
      mock_student = Student.create(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      @mock_profile = Profile.create(student_id: 1)
      ResearchInterest.create(id:1)
      controller.stub(:current_student).and_return(mock_student)
      controller.instance_eval {@profile = @mock_profile}
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      ProfilesUndergradUniversity.create(:profile_id => 1, :undergrad_university_id => 1, :cgpa => '3.4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
    end
    it 'should redirect to profile on successful update' do
      post :update, {"profile"=>{"photo_id"=>"", "college"=>"uiowa", "toefl"=>"110", "gre_writing"=>"4.0", "gre_quant"=>"130", "gre_verbal"=>"140", "interested_major"=>"", "interested_term"=>"", "interested_year"=>"", "year_work_exp"=>"", "sop"=>"", "resume"=>"", "additional_attachment"=>""}, "current_student"=>{"first_name"=>"Avanti", "last_name"=>"Deshmukh"}, "id"=>1, "citizenship" => 1, "undergrad_universities" => 1, "research_interest" => [1], "profiles_undergrad_university" =>  {"cgpa" => "2.5", "grading_scale" => "Standard"}}
      response.should redirect_to(profile_path)
    end

    it 'should stay on same page on unsuccessful update' do
      post :update, {"profile"=>{"photo_id"=>"", "college"=>"uiowa", "toefl"=>"110", "gre_writing"=>"9.0", "gre_quant"=>"890", "gre_verbal"=>"140", "interested_major"=>"", "interested_term"=>"", "interested_year"=>"", "year_work_exp"=>"", "sop"=>"", "resume"=>"", "additional_attachment"=>""}, "current_student"=>{"first_name"=>"Avanti", "last_name"=>"Deshmukh"}, "id"=>1}
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
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"", "sel_opt"=>"","term"=>"","year"=>""}
      expect(flash[:notice]).to eq('Please enter all the fields')
    end
    it 'should call appropriate model method to add school to database' do
      expect(University).to receive(:find_by_university_name).with("Stanford University").and_return(@university)
      allow(Application).to receive(:where).and_return(nil)
      expect(Application).to receive(:add_school!).and_return(@application)
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted", "term"=>"Fall", "year"=>"2020"}
    end
    it 'should flash successful message when school is added successfully' do
      expect(University).to receive(:find_by_university_name).with("Stanford University").and_return(@university)
      allow(Application).to receive(:where).and_return(nil)
      expect(Application).to receive(:add_school!).and_return(@application)
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted", "term"=>"Fall", "year"=>"2020"}
      expect(flash[:notice]).to eq('University application successfully added to database')
    end
    it 'should flash error message when school is not added to the database' do
      expect(University).to receive(:find_by_university_name).with("Stanford University").and_return(@university)
      allow(Application).to receive(:where).and_return(nil)
      expect(Application).to receive(:add_school!).and_return(nil)
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted", "term"=>"Fall", "year"=>"2020"}
      expect(flash[:notice]).to eq('Error while saving application to database')
    end
    it 'should flash error message when school is already present in the database' do
      expect(University).to receive(:find_by_university_name).with("Stanford University").and_return(@university)
      allow(Application).to receive(:where).and_return(@application_new)
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted", "term"=>"Fall", "year"=>"2020"}
      expect(flash[:notice]).to eq('University is already present. Please add a new one')
    end
    it 'should render interested school template' do
      post :addschools, {"univ_name"=>"Stanford University", "datepicker"=>"03/06/2019", "sel_opt"=>"Applied - Accepted", "term"=>"Fall", "year"=>"2020"}
      expect(response).to render_template("profiles/addschools")
    end
  end

  describe 'Delete Schools' do
  before :each do
    @mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
    @mock_profile = Profile.create(id:1, student_id: 1)
    controller.stub(:current_student).and_return(@mock_student)
    controller.instance_eval {@profile = @mock_profile}
    @application = Application.new(:id => 1, :profile_id=> 1, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'')
    @application.save
    @deletion = 1
  end
    it 'should flash successful message when school is deleted successfully' do
      Application.stub_chain(:delete_all, :where).with(@application.id).and_return(@deletion)
      post :deleteschools, {"application_id"=>"1", "profile"=>{}}
      expect(flash[:notice]).to eq('University is deleted successfully')
    end
    it 'should flash unsuccessful message for unsuccessful deletion' do
      Application.stub_chain(:delete_all, :where).with(:id => "2").and_return(0)
      post :deleteschools, {"application_id"=>"2", "profile"=>{}}
      expect(flash[:notice]).to eq('Error while deleting the university')
    end
  end

  describe "Get school by country" do
    it 'should assign school by country params' do
      mock_university = UndergradUniversity.create(:university_name => 'test')
      Country.stub_chain(:where, :first, :undergrad_universities, :order).and_return(mock_university)
      get :getUndergradUniversityByCountry, {"country" => "United States", format: :json}
      expect(assigns(:undergrad_universities)).to eq(mock_university)
    end
  end
  describe 'Get student list' do
    it 'should return all the applications' do
      @application = [double('application1'),double('application2')]
      Application.stub_chain(:where, :all).and_return(@application)
      get :fStudentList
    end
  end

  describe 'Get filtered student list' do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      @mock_student.save
      @mock_faculty = Faculty.new(id: 1, first_name: 'Michael', last_name: 'Jordan', email: 'michael-jordan@uiowa.edu', university_id: 1)
      @mock_faculty.save
      @mock_profile = Profile.new(id:1, student_id: 1, gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile.save
      @application = Application.new(:id => 1, :profile_id=> 1, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'')
      @application.save
      @mock_student2 = Student.new(id: 2, first_name: 'Harsha',last_name: 'Pitawela',email: 'harsha@gmail.com', password: '1234567', username: 'harsha')
      @mock_student2.save
      @mock_profile2 = Profile.new(id:2, student_id: 2, gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile2.save
      @mock_student3 = Student.new(id: 3, first_name: 'Julia',last_name: 'Chaloupka',email: 'julia@gmail.com', password: '1234567', username: 'julia')
      @mock_student3.save
      @mock_profile3 = Profile.new(id:3, student_id: 3,gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile3.save
      @mock_research_interests_profile1 = ResearchInterestsProfile.new(:id => 1, :research_interest_id => 1, :profile_id => 1)
      @mock_research_interests_profile1.save
      @mock_research_interests_profile2 = ResearchInterestsProfile.new(:id => 2, :research_interest_id => 2, :profile_id => 1)
      @mock_research_interests_profile2.save
      @mock_research_interests_profile3 = ResearchInterestsProfile.new(:id => 3, :research_interest_id => 1, :profile_id => 2)
      @mock_research_interests_profile3.save
      @mock_research_interests_profile4 = ResearchInterestsProfile.new(:id => 4, :research_interest_id => 3, :profile_id => 2)
      @mock_research_interests_profile4.save
      @mock_research_interests_profile5 = ResearchInterestsProfile.new(:id => 5, :research_interest_id => 2, :profile_id => 3)
      @mock_research_interests_profile5.save
      @mock_research_interests_profile6 = ResearchInterestsProfile.new(:id => 6, :research_interest_id => 3, :profile_id => 3)
      @mock_research_interests_profile6.save
      @mock_research_interest1 = ResearchInterest.new(:id => 1, :name => 'Artificial Intelligence')
      @mock_research_interest1.save
      @mock_research_interest2 = ResearchInterest.new(:id => 2, :name => 'Algorithms')
      @mock_research_interest2.save
      @mock_research_interest3 = ResearchInterest.new(:id => 3, :name => 'High Performance Computing')
      @mock_research_interest3.save
      @mock_research_interest4 = ResearchInterest.new(:id => 4, :name => 'Machine Learning')
      @mock_research_interest4.save
      @application2 = Application.new(:id => 2, :profile_id=> 2, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'')
      @application2.save
      @application3 = Application.new(:id => 3, :profile_id=> 3, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'')
      @application3.save
      @mock_undergrad_university1 = UndergradUniversity.new(:id => 1, :university_name => 'University of Iowa')
      @mock_undergrad_university1.save
      @mock_undergrad_university2 = UndergradUniversity.new(:id => 2, :university_name => 'Arizona State University')
      @mock_undergrad_university2.save
      @mock_profiles_undergrad_university1 = ProfilesUndergradUniversity.new(:profile_id => 1, :undergrad_university_id => 1)
      @mock_profiles_undergrad_university1.save
      @mock_profiles_undergrad_university2 = ProfilesUndergradUniversity.new(:profile_id => 2, :undergrad_university_id => 1)
      @mock_profiles_undergrad_university2.save
      @mock_profiles_undergrad_university3 = ProfilesUndergradUniversity.new(:profile_id => 3, :undergrad_university_id => 2)
      @mock_profiles_undergrad_university3.save
    end
    it 'should return applications whose profile has cgpa within the requested range' do
      profiles = [@mock_profile]
      Profile.stub_chain(:where, :all).and_return(profiles)
      get :filter, {"utf8"=>"✓", "research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"2 - 3", "greq_score"=>"130 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return applications whose profiles have requested research interests' do
      profiles = [@mock_profile,@mock_profile2]
      Profile.stub_chain(:where, :all, :merge).and_return(profiles)
      get :filter, {"utf8"=>"✓", "research_interests"=>"multiple", "multiple_interests"=>"1,4", "undergrad_university"=>"any", "cgpa_score"=>"0 - 5", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return applications whose profiles have any undergrad university and requested single research interest' do
      profiles = [@mock_profile]
      Profile.stub_chain(:where, :all, :merge).and_return(profiles)
      get :filter, {"utf8"=>"✓", "research_interests"=>"1", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 5", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return applications whose profiles have requested undergrad university' do
      profiles = [@mock_profile,@mock_profile2]
      UndergradUniversity.stub_chain(:find_by_id, :profiles, :where, :all).and_return(profiles)
      get :filter, {"utf8"=>"✓", "research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 5", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return applications whose profiles have requested undergrad university and requested single research interest' do
      profiles = [@mock_profile]
      UndergradUniversity.stub_chain(:find_by_id, :profiles, :where, :all, :merge).and_return(profiles)
      get :filter, {"utf8"=>"✓", "research_interests"=>"1", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 5", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return applications whose profiles have requested undergrad university and requested research interests' do
      profiles = [@mock_profile]
      UndergradUniversity.stub_chain(:find_by_id, :profiles, :where, :all, :merge).and_return(profiles)
      get :filter, {"utf8"=>"✓", "research_interests"=>"multiple", "multiple_interests"=>"1,4", "undergrad_university"=>"1", "cgpa_score"=>"0 - 5", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
  end

  describe "Faculty view student's profile" do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      @mock_profile = Profile.create(id:1, student_id: 1)
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      @mock_undergrad_details = ProfilesUndergradUniversity.create(:profile_id => 1, :undergrad_university_id => 1, :cgpa => '3.4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
    end
    it 'should render fViewProfile template' do
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      expect(Profile).to receive(:find_by_id).and_return(@mock_profile)
      get :fViewProfile, {:id => 1}
      response.should render_template('fViewProfile')
    end
  end

  describe "New profile method" do
    it 'should create profile' do
      @profile = [double('profile1'),double('profile2')]
      expect(Profile).to receive(:new).and_return(@profile)
      get :new
    end
  end

end
