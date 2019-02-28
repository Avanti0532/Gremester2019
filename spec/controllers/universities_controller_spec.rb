require 'spec_helper'
require 'rails_helper'
require 'factory_girl'

describe UniversitiesController do
  describe 'show universities' do
    it 'should return university information' do
      university = double('university1')
      University.should_receive(:find).with('1').and_return(university)
      get :show, {:id => '1'}
      response.should render_template('show')
    end
  end
  describe 'GET #index universities' do
    it 'should populate an array of universities' do
      university1 = FactoryGirl.create(:university, :university_type => 'Private')
      university2 = FactoryGirl.create(:university, :university_type => 'Public')
      get :index
      expect(assigns(:universities)).to eq([university1,university2])
    end
    it 'should render the :index view' do
      get :index
      response.should render_template('index')
    end
    it 'should populate only public universities when Public type is selected' do
      university1 = FactoryGirl.create(:university, :university_type => 'Private')
      university2 = FactoryGirl.create(:university, :university_type => 'Public')
      university3 = FactoryGirl.create(:university, :university_type => 'Private')
      university4 = FactoryGirl.create(:university, :university_type => 'Public')
      params = {:type=>"Public"}
      get :index, params
      expect(assigns(:universities)).to eq([university2,university4])
    end
    it 'should populate only private universities when Private type is selected' do
      university1 = FactoryGirl.create(:university, :university_type => 'Private')
      university2 = FactoryGirl.create(:university, :university_type => 'Public')
      university3 = FactoryGirl.create(:university, :university_type => 'Private')
      university4 = FactoryGirl.create(:university, :university_type => 'Public')
      params = {:type=>"Private"}
      get :index, params
      expect(assigns(:universities)).to eq([university1,university3])
    end
    it 'should populate only universities whose ranks are between the params' do
      university5 = FactoryGirl.create(:university, :rank => 5)
      university15 = FactoryGirl.create(:university, :rank => 15)
      university45 = FactoryGirl.create(:university, :rank => 45)
      university65 = FactoryGirl.create(:university, :rank => 65)
      params = {:ranking_from => 1, :ranking_to => 25}
      get :index, params
      expect(assigns(:universities)).to eq([university5,university15])
    end
    it 'should populate only universities whose ranks are between the params and selected type' do
      university5 = FactoryGirl.create(:university, :rank => 5, :university_type => 'Private')
      university15 = FactoryGirl.create(:university, :rank => 15, :university_type => 'Public')
      university45 = FactoryGirl.create(:university, :rank => 45, :university_type => 'Private')
      university65 = FactoryGirl.create(:university, :rank => 65, :university_type => 'Public')
      params = {:ranking_from => 1, :ranking_to => 50, :type => 'Private'}
      get :index, params
      expect(assigns(:universities)).to eq([university5,university45])
    end
    it 'should populate all universities whose ranks are between the params when All type is selected' do
      university5 = FactoryGirl.create(:university, :rank => 5, :university_type => 'Private')
      university15 = FactoryGirl.create(:university, :rank => 15, :university_type => 'Public')
      university45 = FactoryGirl.create(:university, :rank => 45, :university_type => 'Private')
      university65 = FactoryGirl.create(:university, :rank => 65, :university_type => 'Public')
      params = {:ranking_from => 1, :ranking_to => 50, :type => 'All'}
      get :index, params
      expect(assigns(:universities)).to eq([university5,university15,university45])
    end
    it 'should choose selected type' do
      params = {:type => 'Private'}
      get :index, params
      expect(assigns(:type)).to eq('Private')
    end
    it 'should choose selected ranking_from and ranking_to' do
      params = {:ranking_from => '10', :ranking_to => '25'}
      get :index, params
      expect(assigns(:ranking_from)).to eq('10')
      expect(assigns(:ranking_to)).to eq('25')
    end
  end

end