class UniversitiesController < ApplicationController

  def show
    id = params[:id]
    @university = University.find(id)
  end
  def index
    if params[:ranking_from] && params[:ranking_to] && params[:type] then
      if params[:type] == 'All' then
        @universities = University.where("rank >= ? AND rank <= ?", params[:ranking_from], params[:ranking_to])
      else
        @universities = University.where("rank >= ? AND rank <= ? AND university_type = ?", params[:ranking_from], params[:ranking_to], params[:type])
      end
      @ranking_from = params[:ranking_from]
      @ranking_to = params[:ranking_to]
      @type = params[:type]
    else
      @universities = University.all
    end
  end
end