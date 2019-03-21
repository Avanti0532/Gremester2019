require 'spec_helper'
require 'rails_helper'

describe ResearchInterestsController do
  describe 'index method' do
    it 'should sort an array of research_interests in alphabetical order' do
     research_interest = [double('research1'), double('research2')]
     expect(ResearchInterest).to receive(:order).with(:name).and_return(research_interest)
    get :index
    end
  end
end




