require 'spec_helper'
require 'rails_helper'

RSpec.describe UndergradUniversitiesController, type: :controller do

describe UndergradUniversitiesController do
  describe 'create method' do
    before :each do
      @mock_student = Student.new(id: 1, first_name: 'Avanti',last_name: 'Deshmukh',email: 'avanti532@gmail.com', password: '1234567', username: 'avanti')
      @mock_student.save
      @mock_profile = Profile.create(id:1, student_id: 1)
      controller.stub(:current_student).and_return(@mock_student)
      controller.instance_eval {@profile = @mock_profile}
      @rank = RankType.new(id: 1, name: 'US News')
      @rank.save
      @undergrad = UndergradUniversity.new
      request.env['HTTP_REFERER'] = 'http://localhost:3000/profiles/1/edit?'
      @before_count = UndergradUniversity.count
    end
  it 'should save the university details on successful update' do
    expect(RankType).to receive(:find_by_id).with("1").and_return(@rank)
    post :create, {"university_name"=>"University of Austria", "country"=>"15", "acceptance_rate"=>"2", "location"=>"Austria", "university_desc"=>"University of Austria is one of top most universities in Austria.", "ranking"=>"4", "rank_type"=>"1", "university_link"=>"https://uausria.edu"}
    expect(UndergradUniversity.count).not_to eq(@before_count)
    expect(response).to redirect_to :back
  end
  it 'should create new rank type when new rank type is listed' do
    @ranktype = RankType.new(id: 2, name: 'webopedia')
    expect(RankType).to receive(:create).with(:name => 'webopedia').and_return(@ranktype)
    post :create, {"university_name"=>"University of Austria", "country"=>"15", "acceptance_rate"=>"2", "location"=>"Austria", "university_desc"=>"University of Austria is one of top most universities in Austria.", "ranking"=>"4", "rank_type"=>"Ranking type not listed", "university_link"=>"https://uausria.edu", "new_rank_type"=>"webopedia"}
    expect(UndergradUniversity.count).not_to eq(@before_count)
    expect(response).to redirect_to :back
  end
    it 'should save the university details when ranking and rank type is not specified' do
      post :create, {"university_name"=>"University of Austria", "country"=>"15", "acceptance_rate"=>"2", "location"=>"Austria", "university_desc"=>"University of Austria is one of top most universities in Austria.", "university_link"=>"https://uausria.edu"}
      expect(UndergradUniversity.count).not_to eq(@before_count)
      expect(response).to redirect_to :back
    end
  end
  describe 'index method' do
    it 'should sort an array of undergraduate universities in alphabetical order' do
      undergrad_universities = [double('university1'), double('university2')]
      expect(UndergradUniversity).to receive(:order).with(:university_name).and_return(undergrad_universities)
      get :index
    end
  end
end
end
