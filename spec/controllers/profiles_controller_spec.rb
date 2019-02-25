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
end