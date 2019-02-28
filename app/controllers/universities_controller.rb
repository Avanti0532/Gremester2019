class UniversitiesController < ApplicationController

  def show
    id = params[:id]
    @university = University.find(id)
  end
  def index
    if params[:ranking_from] && params[:ranking_to] && params[:type] then
      if params[:type] == 'All' then
        @universities = University.where("rank >= ? AND rank <= ?", params[:ranking_from],params[:ranking_to])
      else
        @universities = University.where("university_type = ? AND rank >= ? AND rank <= ?", params[:type], params[:ranking_from],params[:ranking_to])
      end
      @ranking_from = params[:ranking_from]
      @ranking_to = params[:ranking_to]
      @type = params[:type]
    elsif params[:ranking_from] && params[:ranking_to] then
      @universities = University.where("rank >= ? AND rank <= ?", params[:ranking_from], params[:ranking_to])
      @ranking_from = params[:ranking_from]
      @ranking_to = params[:ranking_to]
    elsif params[:type] then
      if params[:type] == 'All' then
        @universities = University.all
      else
        @universities = University.where("university_type = ?", params[:type])
      end
      @type = params[:type]
    else
      @universities = University.all
    end
  end
end