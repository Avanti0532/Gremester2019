require 'spec_helper'
require 'rails_helper'
require 'factory_girl'

describe RankTypesController do
  describe 'Get student list' do
    it 'should return all rank types' do
      rank_types = [double('rank_type1'),double('rank_type2')]
      RankType.stub_chain(:order, :pluck).and_return(rank_types)
      get :index, {format: :json}
      expect(assigns(:all_rank_types)).to eq(rank_types)
    end
  end

end