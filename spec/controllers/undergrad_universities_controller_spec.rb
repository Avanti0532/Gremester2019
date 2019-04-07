require 'spec_helper'
require 'rails_helper'

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
      Country.create(id: 2, name: 'India')
      UndergradUniversity.create(country_id: 2, university_name: 'University of Iowa')
      RankType.create(id: 3, name: 'world rank')
      @undergrad = UndergradUniversity.new
      @before_count = UndergradUniversity.count
    end
  it 'should save the university details on successful update' do
    expect(RankType).to receive(:find_by_id).with("1").and_return(@rank)
    post :create, {"university_name"=>"University of Austria", "country"=>"15", "acceptance_rate"=>"2", "location"=>"Austria", "university_desc"=>"University of Austria is one of top most universities in Austria.", "ranking"=>"4", "rank_type"=>"1", "university_link"=>"https://uausria.edu", format: :json}
    expect(UndergradUniversity.count).not_to eq(@before_count)
    @expected = {
        :success    => 'Success'
    }.to_json
    response.body.should == @expected
  end
  it 'should create new rank type when new rank type is listed' do
    @ranktype = RankType.new(id: 2, name: 'webopedia')
    expect(RankType).to receive(:create).with(:name => 'webopedia').and_return(@ranktype)
    post :create, {"university_name"=>"University of Austria", "country"=>"15", "acceptance_rate"=>"2", "location"=>"Austria", "university_desc"=>"University of Austria is one of top most universities in Austria.", "ranking"=>"4", "rank_type"=>"Ranking type not listed", "university_link"=>"https://uausria.edu", "new_rank_type"=>"webopedia", format: :json}
    expect(UndergradUniversity.count).not_to eq(@before_count)
    @expected = {
        :success    => 'Success'
    }.to_json
    response.body.should == @expected
  end
    it 'should save the university details when ranking and rank type is not specified' do
      post :create, {"university_name"=>"University of America", "country"=>"15", "acceptance_rate"=>"2", "location"=>"Austria", "university_desc"=>"University of Austria is one of top most universities in Austria.", "university_link"=>"https://uausria.edu", format: :json}
      expect(UndergradUniversity.count).not_to eq(@before_count)
      @expected = {
          :success    => 'Success'
      }.to_json
      response.body.should == @expected
    end
    it 'should give error if university already exists' do
      expect(RankType).to receive(:find_by_id).with("1").and_return(@rank)
      post :create, {"university_name"=>"University of Iowa", "country"=>"2", "acceptance_rate"=>"2", "location"=>"Austria", "university_desc"=>"University of Austria is one of top most universities in Austria.", "ranking"=>"4", "rank_type"=>"1", "university_link"=>"https://uausria.edu", format: :json}
      expect(UndergradUniversity.count).to eq(@before_count)
      @expected = {
          :errors    => 'University name has been added'
      }.to_json
      response.body.should == @expected
    end
    it 'should give error if rank type already exists' do
      post :create, {"university_name"=>"University of Austria", "country"=>"15", "acceptance_rate"=>"2", "location"=>"Austria", "university_desc"=>"University of Austria is one of top most universities in Austria.", "ranking"=>"4", "rank_type"=>"Ranking type not listed", "university_link"=>"https://uausria.edu", "new_rank_type"=>"world rank", format: :json}
      expect(UndergradUniversity.count).to eq(@before_count)
      @expected = {
          :errors    => 'Rank Type has been added'
      }.to_json
      response.body.should == @expected
    end
  end
  describe 'index method' do
    it 'should sort an array of undergraduate universities in alphabetical order' do
      undergrad_universities = [double('university1'), double('university2')]
      expect(UndergradUniversity).to receive(:order).with(:university_name).and_return(undergrad_universities)
      get :index
    end
  end

  describe 'show method' do
    before :each do
      @undergrad_universities = UndergradUniversity.create(id: 1, country_id: 2, university_name: 'University of Iowa')
    end
    it 'should find the university by id'do
      expect(UndergradUniversity).to receive(:find_by_id).with("1").and_return(@undergrad_universities)
      get :show, {:id => 1}
    end
  end
end

