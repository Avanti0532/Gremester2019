require 'spec_helper'
require 'rails_helper'

describe UniversitiesController do
  describe 'show universities' do
    it 'should return university information' do
      university = double('university1')
      University.should_receive(:find).with('1').and_return(university)
      get :show, {:id => '1'}
      response.should render_template('show')
    end
  end
end