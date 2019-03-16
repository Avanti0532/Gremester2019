require 'spec_helper'
require 'rails_helper'
require 'factory_girl'

describe CountriesController do
  describe 'Get student list' do
    it 'should return all the countries' do
      countries = [double('country'),double('country2')]
      Country.stub_chain(:order, :pluck).and_return(countries)
      get :index, {format: :json}
      expect(assigns(:all_countries)).to eq(countries)
    end
  end

end