class CountriesController < ApplicationController
  def index
    @all_countries = Country.order(:name).pluck(:name, :id)
    respond_to do |format|
      format.json {
        render json: {countries: @all_countries}
      }
    end
  end
end