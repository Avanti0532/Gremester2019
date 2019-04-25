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
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      @mock_profile = Profile.create(id:1, student_id: 1)
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      ProfilesUndergradUniversity.create(:profile_id => 1, :undergrad_university_id => 1, :cgpa => '3.4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
    end
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
      Country.create(:id => 1, :name => 'United States')
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      ProfilesUndergradUniversity.create(:profile_id => 1, :undergrad_university_id => 1, :cgpa => '3.4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
    end
    it 'should redirect to profile on successful update' do

      post :update, {"citizenship" => "1", "profile"=>{"photo_id"=>"", "college"=>"uiowa", "toefl"=>"110", "gre_writing"=>"4.0", "gre_quant"=>"130", "gre_verbal"=>"140", "interested_major"=>"", "interested_term"=>"", "interested_year"=>"", "year_work_exp"=>"", "sop"=>"", "resume"=>"", "additional_attachment"=>""}, "current_student"=>{"first_name"=>"Avanti", "last_name"=>"Deshmukh"}, "id"=>1, "country" => 1, "undergrad_universities" => 1, "research_interest" => [1], "profiles_undergrad_university" =>  {"cgpa" => "2.5"},  "grading_scale" => "Standard", "additional_research_interest" => "testing interest", "major_undergrad" => "Computer Science", "degree_undergrad" => "BA", "undergrad_end_year" => "2016", "undergrad_start_year" => "2012"}
      response.should redirect_to(profile_path)
    end

    it 'should stay on same page on unsuccessful update' do
      post :update, {"profile"=>{"photo_id"=>"", "college"=>"uiowa", "toefl"=>"110", "gre_writing"=>"9.0", "gre_quant"=>"890", "gre_verbal"=>"140", "interested_major"=>"", "interested_term"=>"", "interested_year"=>"", "year_work_exp"=>"", "sop"=>"", "resume"=>"", "additional_attachment"=>""}, "current_student"=>{"first_name"=>"Avanti", "last_name"=>"Deshmukh"}, "id"=>1}
      response.should render_template('edit')
    end

  end
  describe 'show list of schools' do
    it 'should show list of schools added by a student' do
      application = Application.new(id: 1, profile_id: 1, university_id: 1, applied: 't', applied_date: '2019-01-02', admitted: 't', admitted_date: '2019-03-05', rejected: '', rejected_date:'',:term => 'Fall', :year => '2020')
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
      @application_new = Application.new(:id => 2, :profile_id=> 1, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'t',:admitted_date=>'2019-04-23',:rejected=>'',:rejected_date=>'', :term => 'Fall', :year => '2020')
      @application_new.save
      @application = Application.new(:id => 1, :profile_id=> 1, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'',:term => 'Fall', :year => '2020')
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
      expect(flash[:notice]).to eq('University is already present for the selected term and year. Please add a new one')
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
      @application = Application.new(:id => 1, :profile_id=> 1, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Fall', :year => '2019')
      @application.save
      @mock_student2 = Student.new(id: 2, first_name: 'Harsha',last_name: 'Pitawela',email: 'harsha@gmail.com', password: '1234567', username: 'harsha')
      @mock_student2.save
      @mock_profile2 = Profile.new(id:2, student_id: 2, gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile2.save
      @mock_student3 = Student.new(id: 3, first_name: 'Julia',last_name: 'Chaloupka',email: 'julia@gmail.com', password: '1234567', username: 'julia')
      @mock_student3.save
      @mock_profile3 = Profile.new(id:3, student_id: 3,gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile3.save
      @mock_student4 = Student.new(id: 4, first_name: 'Kumar',last_name: 'Sangakkara',email: 'kumar@gmail.com', password: '1234567', username: 'kumar')
      @mock_student4.save
      @mock_profile4 = Profile.new(id:4, student_id: 4,gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile4.save
      @mock_student5 = Student.new(id: 5, first_name: 'Mahela',last_name: 'Jayawardane',email: 'mahela@gmail.com', password: '1234567', username: 'mahela')
      @mock_student5.save
      @mock_profile5 = Profile.new(id:5, student_id: 5,gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile5.save
      @mock_student6 = Student.new(id: 6, first_name: 'Kobe',last_name: 'Bryant',email: 'kobe@gmail.com', password: '1234567', username: 'kobe')
      @mock_student6.save
      @mock_profile6 = Profile.new(id:6, student_id: 6,gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile6.save
      @mock_student7 = Student.new(id: 7, first_name: 'Michael',last_name: 'Jordon',email: 'michael@gmail.com', password: '1234567', username: 'michael')
      @mock_student7.save
      @mock_profile7 = Profile.new(id:7, student_id: 7,gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile7.save
      @mock_student8 = Student.new(id: 8, first_name: 'Kevin',last_name: 'Durant',email: 'kevin@gmail.com', password: '1234567', username: 'kevin')
      @mock_student8.save
      @mock_profile8 = Profile.new(id:8, student_id: 8,gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile8.save
      @mock_student9 = Student.new(id: 9, first_name: 'Stephen',last_name: 'Curry',email: 'stephen@gmail.com', password: '1234567', username: 'stephen')
      @mock_student9.save
      @mock_profile9 = Profile.new(id:9, student_id: 9,gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile9.save
      @mock_student10 = Student.new(id: 10, first_name: 'Lebron',last_name: 'James',email: 'james@gmail.com', password: '1234567', username: 'james')
      @mock_student10.save
      @mock_profile10 = Profile.new(id:10, student_id: 10,gre_quant: 160, gre_verbal: 150, degree_objective_master: 4, degree_objective_phd: 2)
      @mock_profile10.save
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
      @application2 = Application.new(:id => 2, :profile_id=> 2, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Winter', :year => '2019')
      @application2.save
      @application3 = Application.new(:id => 3, :profile_id=> 3, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Spring', :year => '2020')
      @application3.save
      @application4 = Application.new(:id => 4, :profile_id=> 4, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Summer', :year => '2020')
      @application4.save
      @application5 = Application.new(:id => 5, :profile_id=> 5, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Fall', :year => '2020')
      @application5.save
      @application6 = Application.new(:id => 6, :profile_id=> 6, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Fall', :year => '2020')
      @application6.save
      @application7 = Application.new(:id => 7, :profile_id=> 7, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Fall', :year => '2020')
      @application7.save
      @application8 = Application.new(:id => 8, :profile_id=> 8, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Fall', :year => '2020')
      @application8.save
      @application9 = Application.new(:id => 9, :profile_id=> 9, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Fall', :year => '2020')
      @application9.save
      @application10 = Application.new(:id => 10, :profile_id=> 10, :university_id => 1, :applied=>'t', :applied_date => '2019-03-06', :admitted=>'',:admitted_date=>'',:rejected=>'',:rejected_date=>'', :term => 'Fall', :year => '2020')
      @application10.save
      @mock_undergrad_university1 = UndergradUniversity.new(:id => 1, :university_name => 'University of Iowa')
      @mock_undergrad_university1.save
      @mock_undergrad_university2 = UndergradUniversity.new(:id => 2, :university_name => 'Arizona State University')
      @mock_undergrad_university2.save
      @mock_undergrad_university3 = UndergradUniversity.new(:id => 3, :university_name => 'Iowa State University')
      @mock_undergrad_university3.save
      @mock_undergrad_university4 = UndergradUniversity.new(:id => 4, :university_name => 'California State University')
      @mock_undergrad_university4.save
      @mock_undergrad_university5 = UndergradUniversity.new(:id => 5, :university_name => 'Washington State University')
      @mock_undergrad_university5.save
      @mock_undergrad_details = ProfilesUndergradUniversity.create(:profile_id => 1, :undergrad_university_id => 1, :cgpa => '3.4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 1)
      @mock_undergrad_details2 = ProfilesUndergradUniversity.create(:profile_id => 2, :undergrad_university_id => 1, :cgpa => '3.8', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 1)
      @mock_undergrad_details3 = ProfilesUndergradUniversity.create(:profile_id => 3, :undergrad_university_id => 2, :cgpa => '3.0', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 1)
      @mock_undergrad_details4 = ProfilesUndergradUniversity.create(:profile_id => 4, :undergrad_university_id => 1, :cgpa => '2.5', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 1)
      @mock_undergrad_details5 = ProfilesUndergradUniversity.create(:profile_id => 5, :undergrad_university_id => 1, :cgpa => '2.8', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 1)
      @mock_undergrad_details6 = ProfilesUndergradUniversity.create(:profile_id => 6, :undergrad_university_id => 1, :cgpa => '3.86', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 1)
      @mock_undergrad_details7 = ProfilesUndergradUniversity.create(:profile_id => 7, :undergrad_university_id => 2, :cgpa => '4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 2)
      @mock_undergrad_details8 = ProfilesUndergradUniversity.create(:profile_id => 8, :undergrad_university_id => 3, :cgpa => '9', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 3)
      @mock_undergrad_details9 = ProfilesUndergradUniversity.create(:profile_id => 9, :undergrad_university_id => 4, :cgpa => '3.7', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 4)
      @mock_undergrad_details10 = ProfilesUndergradUniversity.create(:profile_id => 10, :undergrad_university_id => 5, :cgpa => '1', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016', :grading_scale_type_id => 5)
      @mock_grading_scale_type1 = GradingScaleType.create(:id => 1, :grading_scale_name => 'Standard with A+')
      @mock_grading_scale_type2 = GradingScaleType.create(:id => 2, :grading_scale_name => 'Standard with no plus/minus')
      @mock_grading_scale_type3 = GradingScaleType.create(:id => 3, :grading_scale_name => '1 – 10 scale')
      @mock_grading_scale_type4 = GradingScaleType.create(:id => 4, :grading_scale_name => 'Standard with no A+')
      @mock_grading_scale_type5 = GradingScaleType.create(:id => 5, :grading_scale_name => 'Germany scale')
      @mock_grading_scale1 = GradingScale.create(:id => 1, :grading_scale_type_id=>1, :letter_grade=>'A+', :gpa=>4.33, :low_percent=> 97, :high_percent=>100)
      @mock_grading_scale2 = GradingScale.create(:id => 2, :grading_scale_type_id=>1, :letter_grade=>'A', :gpa=>4, :low_percent=> 93, :high_percent=>96)
      @mock_grading_scale3 = GradingScale.create(:id => 3, :grading_scale_type_id=>1, :letter_grade=>'A-', :gpa=>3.67, :low_percent=> 90, :high_percent=>92)
      @mock_grading_scale4 = GradingScale.create(:id => 4, :grading_scale_type_id=>1, :letter_grade=>'B+', :gpa=>3.33, :low_percent=> 87, :high_percent=>89)
      @mock_grading_scale5 = GradingScale.create(:id => 5, :grading_scale_type_id=>1, :letter_grade=>'B', :gpa=>3, :low_percent=> 83, :high_percent=>86)
      @mock_grading_scale6 = GradingScale.create(:id => 6, :grading_scale_type_id=>1, :letter_grade=>'B-', :gpa=>2.67, :low_percent=> 80, :high_percent=>82)
      @mock_grading_scale7 = GradingScale.create(:id => 7, :grading_scale_type_id=>1, :letter_grade=>'C+', :gpa=>2.33, :low_percent=> 77, :high_percent=>79)
      @mock_grading_scale8 = GradingScale.create(:id => 8, :grading_scale_type_id=>1, :letter_grade=>'C', :gpa=>2, :low_percent=> 73, :high_percent=>76)
      @mock_grading_scale9 = GradingScale.create(:id => 9, :grading_scale_type_id=>1, :letter_grade=>'C-', :gpa=>1.67, :low_percent=> 70, :high_percent=>72)
      @mock_grading_scale10 = GradingScale.create(:id => 10, :grading_scale_type_id=>1, :letter_grade=>'D+', :gpa=>1.33, :low_percent=> 67, :high_percent=>69)
      @mock_grading_scale11 = GradingScale.create(:id => 11, :grading_scale_type_id=>1, :letter_grade=>'D', :gpa=>1, :low_percent=> 63, :high_percent=>66)
      @mock_grading_scale12 = GradingScale.create(:id => 12, :grading_scale_type_id=>1, :letter_grade=>'D-', :gpa=>0.67, :low_percent=> 60, :high_percent=>62)
      @mock_grading_scale13 = GradingScale.create(:id => 13, :grading_scale_type_id=>1, :letter_grade=>'E', :gpa=>0, :low_percent=> 0, :high_percent=>60)
      @mock_grading_scale14 = GradingScale.create(:id => 14, :grading_scale_type_id=>2, :letter_grade=>'A', :gpa=>4, :low_percent=> 90, :high_percent=>100)
      @mock_grading_scale15 = GradingScale.create(:id => 15, :grading_scale_type_id=>2, :letter_grade=>'B', :gpa=>3, :low_percent=> 80, :high_percent=>89)
      @mock_grading_scale16 = GradingScale.create(:id => 16, :grading_scale_type_id=>2, :letter_grade=>'C', :gpa=>2, :low_percent=> 70, :high_percent=>79)
      @mock_grading_scale17 = GradingScale.create(:id => 17, :grading_scale_type_id=>2, :letter_grade=>'D', :gpa=>1, :low_percent=> 60, :high_percent=>69)
      @mock_grading_scale18 = GradingScale.create(:id => 18, :grading_scale_type_id=>2, :letter_grade=>'F', :gpa=>0, :low_percent=> 0, :high_percent=>59)
      @mock_grading_scale19 = GradingScale.create(:id => 19, :grading_scale_type_id=>3, :letter_grade=>'1', :gpa=>1, :low_percent=> 0, :high_percent=>5)
      @mock_grading_scale20 = GradingScale.create(:id => 20, :grading_scale_type_id=>3, :letter_grade=>'2', :gpa=>2, :low_percent=> 5, :high_percent=>15)
      @mock_grading_scale21 = GradingScale.create(:id => 21, :grading_scale_type_id=>3, :letter_grade=>'3', :gpa=>3, :low_percent=> 15, :high_percent=>25)
      @mock_grading_scale22 = GradingScale.create(:id => 22, :grading_scale_type_id=>3, :letter_grade=>'4', :gpa=>4, :low_percent=> 25, :high_percent=>35)
      @mock_grading_scale23 = GradingScale.create(:id => 23, :grading_scale_type_id=>3, :letter_grade=>'5', :gpa=>5, :low_percent=> 35, :high_percent=>45)
      @mock_grading_scale24 = GradingScale.create(:id => 24, :grading_scale_type_id=>3, :letter_grade=>'6', :gpa=>6, :low_percent=> 45, :high_percent=>55)
      @mock_grading_scale25 = GradingScale.create(:id => 25, :grading_scale_type_id=>3, :letter_grade=>'7', :gpa=>7, :low_percent=> 55, :high_percent=>65)
      @mock_grading_scale26 = GradingScale.create(:id => 26, :grading_scale_type_id=>3, :letter_grade=>'8', :gpa=>8, :low_percent=> 65, :high_percent=>80)
      @mock_grading_scale27 = GradingScale.create(:id => 27, :grading_scale_type_id=>3, :letter_grade=>'9', :gpa=>9, :low_percent=> 80, :high_percent=>95)
      @mock_grading_scale28 = GradingScale.create(:id => 28, :grading_scale_type_id=>3, :letter_grade=>'10', :gpa=>10, :low_percent=> 95, :high_percent=>100)
      @mock_grading_scale29 = GradingScale.create(:id => 29, :grading_scale_type_id=>4, :letter_grade=>'A', :gpa=>4, :low_percent=> 93, :high_percent=>100)
      @mock_grading_scale30 = GradingScale.create(:id => 30, :grading_scale_type_id=>4, :letter_grade=>'A-', :gpa=>3.67, :low_percent=> 90, :high_percent=>92)
      @mock_grading_scale31 = GradingScale.create(:id => 31, :grading_scale_type_id=>4, :letter_grade=>'B+', :gpa=>3.33, :low_percent=> 87, :high_percent=>89)
      @mock_grading_scale32 = GradingScale.create(:id => 32, :grading_scale_type_id=>4, :letter_grade=>'B', :gpa=>3, :low_percent=> 83, :high_percent=>86)
      @mock_grading_scale33 = GradingScale.create(:id => 33, :grading_scale_type_id=>4, :letter_grade=>'B-', :gpa=>2.67, :low_percent=> 80, :high_percent=>82)
      @mock_grading_scale34 = GradingScale.create(:id => 34, :grading_scale_type_id=>4, :letter_grade=>'C+', :gpa=>2.33, :low_percent=> 77, :high_percent=>79)
      @mock_grading_scale35 = GradingScale.create(:id => 35, :grading_scale_type_id=>4, :letter_grade=>'C', :gpa=>2, :low_percent=> 73, :high_percent=>76)
      @mock_grading_scale36 = GradingScale.create(:id => 36, :grading_scale_type_id=>4, :letter_grade=>'C-', :gpa=>1.67, :low_percent=> 70, :high_percent=>72)
      @mock_grading_scale37 = GradingScale.create(:id => 37, :grading_scale_type_id=>4, :letter_grade=>'D+', :gpa=>1.33, :low_percent=> 67, :high_percent=>69)
      @mock_grading_scale38 = GradingScale.create(:id => 38, :grading_scale_type_id=>4, :letter_grade=>'D', :gpa=>1, :low_percent=> 63, :high_percent=>66)
      @mock_grading_scale39 = GradingScale.create(:id => 39, :grading_scale_type_id=>4, :letter_grade=>'D-', :gpa=>0.67, :low_percent=> 60, :high_percent=>62)
      @mock_grading_scale40 = GradingScale.create(:id => 40, :grading_scale_type_id=>4, :letter_grade=>'F', :gpa=>0, :low_percent=> 0, :high_percent=>59)
      @mock_grading_scale41 = GradingScale.create(:id => 41, :grading_scale_type_id=>5, :letter_grade=>'A', :gpa=>1, :low_percent=> 93, :high_percent=>100)
      @mock_grading_scale42 = GradingScale.create(:id => 42, :grading_scale_type_id=>5, :letter_grade=>'A-', :gpa=>1.3, :low_percent=> 90, :high_percent=>92)
      @mock_grading_scale43 = GradingScale.create(:id => 43, :grading_scale_type_id=>5, :letter_grade=>'B+', :gpa=>1.7, :low_percent=> 87, :high_percent=>89)
      @mock_grading_scale44 = GradingScale.create(:id => 44, :grading_scale_type_id=>5, :letter_grade=>'B', :gpa=>2, :low_percent=> 83, :high_percent=>86)
      @mock_grading_scale45 = GradingScale.create(:id => 45, :grading_scale_type_id=>5, :letter_grade=>'B-', :gpa=>2.3, :low_percent=> 80, :high_percent=>82)
      @mock_grading_scale46 = GradingScale.create(:id => 46, :grading_scale_type_id=>5, :letter_grade=>'C+', :gpa=>2.7, :low_percent=> 77, :high_percent=>79)
      @mock_grading_scale47 = GradingScale.create(:id => 47, :grading_scale_type_id=>5, :letter_grade=>'C', :gpa=>3, :low_percent=> 73, :high_percent=>76)
      @mock_grading_scale48 = GradingScale.create(:id => 48, :grading_scale_type_id=>5, :letter_grade=>'C-', :gpa=>3.3, :low_percent=> 70, :high_percent=>72)
      @mock_grading_scale49 = GradingScale.create(:id => 49, :grading_scale_type_id=>5, :letter_grade=>'D+', :gpa=>3.7, :low_percent=> 67, :high_percent=>69)
      @mock_grading_scale50 = GradingScale.create(:id => 50, :grading_scale_type_id=>5, :letter_grade=>'D', :gpa=>4, :low_percent=> 63, :high_percent=>66)
      @mock_grading_scale51 = GradingScale.create(:id => 51, :grading_scale_type_id=>5, :letter_grade=>'D-', :gpa=>5, :low_percent=> 60, :high_percent=>62)
      @mock_grading_scale52 = GradingScale.create(:id => 52, :grading_scale_type_id=>5, :letter_grade=>'F', :gpa=>6, :low_percent=> 0, :high_percent=>59)
    end
    it 'should return applications in the full score ranges when score ranges are empty' do
      profiles = [@mock_profile, @mock_profile2, @mock_profile4, @mock_profile5]
      Profile.stub_chain(:where, :all).and_return(profiles)
      get :filter, {"utf8"=>"✓", "research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"", "greq_score"=>"", "grev_score"=>"", "msob_score"=>"", "phdo_score"=>"", "commit"=>"Filter"}
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
    it 'should return all applications from selected undergrad uni for year-term and later when year and term are selected with and_later-Fall 2019' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile4, @mock_profile5]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 5", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"2019", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications from selected undergrad uni for year-term and later when year and term are selected with and_later-Summer 2020' do
      profiles = [@mock_profile4, @mock_profile5]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 5", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"summer", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications when 0-100 CGPA and all scale are selected' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5, @mock_profile6,@mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all", "research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"summer", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return only German scale applications when 0-100 CGPA and Germany scale are selected' do
      profiles = [@mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"5","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"summer", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range when any term and any year are selected' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"any", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term, year and later terms selected-Spring-2020' do
      profiles = [@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"spring", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term, year and later terms selected-Summer-2020' do
      profiles = [@mock_profile4,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"summer", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term, year and later terms selected-Fall-2020' do
      profiles = [@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term, year and later terms selected-Winter-2019' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term, year and later terms selected-Winter-2019' do
      profiles = [@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term when term is selected-Fall' do
      profiles = [@mock_profile,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"any", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term when term is selected-2019' do
      profiles = [@mock_profile,@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected scale' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"any", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range when term, year and and_later are blank with scale_type all' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"", "year"=>"", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range when term and year are any with scale_type all' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"any", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range when any term and any year are selected' do
      profiles = [@mock_profile]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      # GradingScale.stub_chain(:where, :first).and_return(@mock_grading_scale41,@mock_grading_scale42,@mock_grading_scale43,@mock_grading_scale44,@mock_grading_scale45,@mock_grading_scale46,@mock_grading_scale47,@mock_grading_scale48,@mock_grading_scale49,@mock_grading_scale50,@mock_grading_scale51,@mock_grading_scale52)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"", "year"=>"", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term, year and later terms selected-Spring-2020' do
      profiles = [@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"spring", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term, year and later terms selected-Summer-2020' do
      profiles = [@mock_profile4,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"summer", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term, year and later terms selected-Fall-2020' do
      profiles = [@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term, year and later terms selected-Winter-2019' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term-year and later terms when term and year are selected and later terms not selected-Winter-2019' do
      profiles = [@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term when term is selected-Fall' do
      profiles = [@mock_profile,@mock_profile5,@mock_profile6, @mock_profile7,@mock_profile8,@mock_profile9, @mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"any", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range with selected term when term is selected-2019' do
      profiles = [@mock_profile,@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end


    it 'should return all applications in the given CGPA range in the given scale when term, year and and_later are blank' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"", "year"=>"", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end


    it 'should return all applications in the given CGPA range in the given scale with selected term-year and later terms when term, year and later terms selected-Spring-2020' do
      profiles = [@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"spring", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range in the given scale with selected term-year and later terms when term, year and later terms selected-Summer-2020' do
      profiles = [@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"summer", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range in the given scale with selected term-year and later terms when term, year and later terms selected-Fall-2020' do
      profiles = [@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range in the given scale with selected term-year and later terms when term, year and later terms selected-Winter-2019' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range in the given scale with selected term-year and later terms when term and year selected and later terms not selected-Winter-2019' do
      profiles = [@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range in the given scale with selected term when term is selected-Fall' do
      profiles = [@mock_profile,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"any", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range in the given scale with selected term when term is selected-2019' do
      profiles = [@mock_profile,@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"any", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end





    it 'should return all applications in the given CGPA range from given undergraduate college when term,year and and_later blank' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5, @mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"", "year"=>"", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college when term and year are any' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5, @mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"any", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Spring-2020' do
      profiles = [@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"spring", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Summer-2020' do
      profiles = [@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"summer", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Fall-2020' do
      profiles = [@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Winter-2019' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term and year selected and later terms not selected-Winter-2019' do
      profiles = [@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term when term is selected-Fall' do
      profiles = [@mock_profile,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"any", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college  with selected term when term is selected-2019' do
      profiles = [@mock_profile,@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end

    it 'should return only German scale applications from given undergraduate college when 0-100 CGPA and Germany scale are selected' do
      profiles = [@mock_profile10]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"5","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"5", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"", "year"=>"", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return only Standard with A+ applications from given undergraduate college when 0-100 CGPA and Standard with A+ scale are selected' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"0 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"", "year"=>"", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end


    it 'should return all applications in the given CGPA range from given undergraduate college when term,year and and_later blank' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5, @mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"", "year"=>"", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college when term and year are any' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5, @mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"any", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Spring-2020' do
      profiles = [@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"spring", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Summer-2020' do
      profiles = [@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"summer", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Fall-2020' do
      profiles = [@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Winter-2019' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term-year and later terms when term and year selected and later terms not selected-Winter-2019' do
      profiles = [@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college with selected term when term is selected-Fall' do
      profiles = [@mock_profile,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"any", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from given undergraduate college  with selected term when term is selected-2019' do
      profiles = [@mock_profile,@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"all","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end




    it 'should return all applications in the given CGPA range from the given scale from given undergraduate college when term,year and and_later blank' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5, @mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"", "year"=>"", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from the given scale  from given undergraduate college when term and year are any' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5, @mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"any", "and_later"=>"", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from the given scale  from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Spring-2020' do
      profiles = [@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"spring", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from the given scale  from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Summer-2020' do
      profiles = [@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"summer", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from the given scale  from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Fall-2020' do
      profiles = [@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"2020", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from the given scale  from given undergraduate college with selected term-year and later terms when term, year and later terms selected-Winter-2019' do
      profiles = [@mock_profile,@mock_profile2,@mock_profile3,@mock_profile4,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"on", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from the given scale  from given undergraduate college with selected term-year and later terms when term and year selected and later terms not selected-Winter-2019' do
      profiles = [@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"winter", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from the given scale  from given undergraduate college with selected term when term is selected-Fall' do
      profiles = [@mock_profile,@mock_profile5,@mock_profile6]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"fall", "year"=>"any", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
    it 'should return all applications in the given CGPA range from the given scale  from given undergraduate college  with selected term when term is selected-2019' do
      profiles = [@mock_profile,@mock_profile2]
      Profile.stub_chain(:where, :all).and_return(profiles)
      ProfilesUndergradUniversity.stub_chain(:where, :first).and_return(@mock_undergrad_details)
      get :filter, {"utf8"=>"✓", "scale_type"=>"1","research_interests"=>"any", "multiple_interests"=>"", "undergrad_university"=>"1", "cgpa_score"=>"80 - 100", "greq_score"=>"150 - 170", "grev_score"=>"130 - 170", "msob_score"=>"0 - 5", "phdo_score"=>"0 - 5", "term"=>"any", "year"=>"2019", "and_later"=>"off", "commit"=>"Filter"}
      expect(response).to render_template('profiles/fStudentList')
    end
  end

  describe "Faculty view student's profile" do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      @mock_profile = Profile.create(id:1, student_id: 1)
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      Application.create(:id => 1, :profile_id => 1)
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


  describe "delete undergrad university" do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      @mock_profile = Profile.create(id:1, student_id: 1)
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      Application.create(:id => 1, :profile_id => 1)
      @mock_undergrad_details = ProfilesUndergradUniversity.create(:id => 1, :profile_id => 1, :undergrad_university_id => 1, :cgpa => '3.4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
    end
    it 'should redirect to profiles page' do
      get :deleteUndergradUniversity, {:id => 1}
      response.should redirect_to(profile_path)
    end
  end

  describe 'Get Admission Chance' do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      controller.stub(:current_student).and_return(@mock_student)
      @mock_profile = Profile.create(id:1, student_id: 1,toefl: 90, gre_quant: 140, gre_verbal: 140, gre_writing:2)
      controller.instance_eval {@profile = @mock_profile}
      @mock_university = University.create(:id => 1,:rank => 42, :university_name => 'Iowa State University')
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      Application.create(:id => 1, :profile_id => 1)
      @mock_undergrad_details = ProfilesUndergradUniversity.create(:id => 1, :profile_id => 1, :undergrad_university_id => 1, :cgpa => '2.5', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
    end
    it 'should flash an error message when university name is blank' do
       post :getAdmissionChance, {"univ_name"=>"", "profile"=>{}}
       expect(flash[:notice]).to eq('Please select the university')
    end

    it 'should flash an error message when GRE Quantitative is blank' do
      mock_student = Student.new(id: 2, first_name: 'Lily',last_name: 'James',email: 'lily532@gmail.com', password: '1234567', username: 'lily123')
      controller.stub(:current_student).and_return(mock_student)
      mock_profile = Profile.create(id:2, student_id: 2,toefl: 100, gre_quant: nil, gre_verbal: 145, gre_writing:3.5)
      controller.instance_eval {@profile = mock_profile}
      post :getAdmissionChance, {"univ_name"=>"Iowa State University", "profile"=>{}}
      expect(flash[:notice]).to eq('Please complete your profile with GRE scores')
    end

    it 'should render result in json format for Dream University' do
      final = [57.49,'Dream']
      expect(University).to receive(:find_by_university_name).with('Iowa State University').and_return(@mock_university)
      post :getAdmissionChance, {"univ_name"=>"Iowa State University", "profile"=>{}}
      expect(JSON.parse(response.body)['result']).to eq(final)
    end

    it 'should render result in json format for Target University' do
      mock_student = Student.new(id: 2, first_name: 'Lily',last_name: 'James',email: 'lily532@gmail.com', password: '1234567', username: 'lily123')
      controller.stub(:current_student).and_return(mock_student)
      mock_profile = Profile.create(id:2, student_id: 2,toefl: 112, gre_quant: 165, gre_verbal: 150, gre_writing:3.8)
      controller.instance_eval {@profile = mock_profile}
      ProfilesUndergradUniversity.create(:id => 2, :profile_id => 2, :undergrad_university_id => 1, :cgpa => '3.7', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
      final = [73.09,'Target']
      expect(University).to receive(:find_by_university_name).with('Iowa State University').and_return(@mock_university)
      post :getAdmissionChance, {"univ_name"=>"Iowa State University", "profile"=>{}}
      expect(JSON.parse(response.body)['result']).to eq(final)
    end

    it 'should render result in json format for Safe University' do
      mock_student = Student.new(id: 2, first_name: 'Lily',last_name: 'James',email: 'lily532@gmail.com', password: '1234567', username: 'lily123')
      controller.stub(:current_student).and_return(mock_student)
      mock_profile = Profile.create(id: 2, student_id: 2,toefl: 118, gre_quant: 165, gre_verbal: 166, gre_writing:5)
      controller.instance_eval {@profile = mock_profile}
      ProfilesUndergradUniversity.create(:id => 2, :profile_id => 2, :undergrad_university_id => 1, :cgpa => '4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
      final = [80.31,'Safe']
      expect(University).to receive(:find_by_university_name).with('Iowa State University').and_return(@mock_university)
      post :getAdmissionChance, {"univ_name"=>"Iowa State University", "profile"=>{}}
      expect(JSON.parse(response.body)['result']).to eq(final)
    end
    it 'should render result in json format when university rank is greater than 50' do
      final = [66.91,'Target']
      mock_university = University.create(:id => 2,:rank => 69, :university_name => 'University of Iowa')
      expect(University).to receive(:find_by_university_name).with('University of Iowa').and_return(mock_university)
      post :getAdmissionChance, {"univ_name"=>"University of Iowa", "profile"=>{}}
      expect(JSON.parse(response.body)['result']).to eq(final)
    end
  end
end
