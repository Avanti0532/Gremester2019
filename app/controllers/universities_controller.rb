class UniversitiesController < ApplicationController

  def show
    id = params[:id]
    @university = University.find(id)
  end
end