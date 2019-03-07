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
    it 'should render edit template' do
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
      post :update, {:current_student => {:first_name => "name", :last_name => "test"}, :profile => {:cgpa => "3.4", :toefl => 110, :gre_quant => 130, :gre_verbal => 140, :gre_writing => 4.0}}
      response.should redirect_to(profiles_path)
    end

    it 'should stay on same page on unsuccessful update' do
      mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      mock_profile = Profile.create(student_id: 1)
      controller.stub(:current_student).and_return(mock_student)
      controller.instance_eval {@profile = mock_profile}
      post :update, {:current_student => {:first_name => "name", :last_name => "test"}, :profile => {:toefl => '560'}}
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

end