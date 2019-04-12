require 'spec_helper'
require 'rails_helper'


describe FacultyEvaluationsController do
  describe 'Show method' do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      @mock_student.save
      @mock_profile = Profile.create(id:1, student_id: 1)
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      Application.create(:id => 1, :profile_id => 1)
      ProfilesUndergradUniversity.create(:profile_id => 1, :undergrad_university_id => 1, :cgpa => '3.4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
    end
    it 'should return student profile' do
      get :show, {id: 1}
      expect(assigns(:student)).to eq(@mock_student)
    end
  end

  describe 'Create method' do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      @mock_student.save
      @mock_faculty = Faculty.create(id: 1)
      controller.stub(:current_faculty).and_return(@mock_faculty)
      @mock_profile = Profile.create(id:1, student_id: 1)
      UndergradUniversity.create(:id => 1, :university_name => 'Test University')
      Application.create(:id => 1, :profile_id => 1)
      ProfilesUndergradUniversity.create(:profile_id => 1, :undergrad_university_id => 1, :cgpa => '3.4', :degree_type => 'B.A', :start_year => '2012', :end_year => '2016')
    end
    it 'should return student profile' do
      get :create, {id: 1, application_score: 4,  ee_background: 1, comment: "test comment"}
      response.should redirect_to(fViewProfile_profiles_path)
    end
  end

  describe 'Index method' do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      @mock_student.save
      @mock_faculty = Faculty.create(id: 1)
      controller.stub(:current_faculty).and_return(@mock_faculty)
      @mock_profile = Profile.create(id:1, student_id: 1)
      Application.create(:id => 1, :profile_id => 1)
      @mock_evaluation = FacultyEvaluation.new(id:1, faculty_id: 1,application_id: 1, score: 4, ee_background: 1, comment: "Good Profile")
      @mock_evaluation.save
    end

    it 'should return the faculty evaluations' do
      expect(FacultyEvaluation).to receive(:where).and_return(@mock_evaluation)
      get :index
    end

    it 'should render index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'showEvaluations method' do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      @mock_student.save
      @mock_faculty = Faculty.create(id: 1, first_name: 'James', last_name: 'Gordon', university_id: 1)
      controller.stub(:current_faculty).and_return(@mock_faculty)
      @mock_faculty1= Faculty.create(id: 2, first_name: 'Lily', last_name: 'Green', university_id: 1)
      @mock_profile = Profile.create(id:1, student_id: 1)
      Application.create(:id => 1, :profile_id => 1, :university_id => 1)
      @mock_evaluation = FacultyEvaluation.new(id:1, faculty_id: 1,application_id: 1, score: 4, ee_background: 1, comment: "Good Profile")
      @mock_evaluation.save
      @mock_evaluation1 = FacultyEvaluation.new(id:2, faculty_id: 2,application_id: 1, score: 3, ee_background: 1, comment: "Good to admit")
      @mock_evaluation1.save
    end

    it 'should return evaluations of other faculty members' do
      expect(FacultyEvaluation).to receive(:where).with("faculty_id!= #{@mock_faculty.id} AND application_id = 1").and_return(@mock_evaluation1)
      get :showEvaluations,  {"id"=>"1"}
    end

    it 'should render show evaluation template' do
      get :showEvaluations,  {"id"=>"1"}
      expect(response).to render_template('faculty_evaluations/showEvaluations')
    end
  end
end