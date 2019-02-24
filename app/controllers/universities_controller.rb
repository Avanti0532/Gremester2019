class UniversitiesController < ApplicationController

  def show
    id = params[:id]
    @university = University.find(id)
  end
  def index
    if params[:ranking_from] && params[:ranking_to] && params[:type] then
      @universities = University.where("rank >= ? AND rank <= ? AND university_type = ?", params[:ranking_from], params[:ranking_to], params[:type])
      @ranking_from = params[:ranking_from]
      @ranking_to = params[:ranking_to]
      @type = params[:type]
    elsif params[:ranking_from] && params[:ranking_to] then
      @universities = University.where("rank >= ? AND rank <= ?", params[:ranking_from], params[:ranking_to])
      @ranking_from = params[:ranking_from]
      @ranking_to = params[:ranking_to]
    elsif params[:type] then
      @universities = University.where("university_type = ?", params[:type])
      @type = params[:type]
    else
      @universities = University.all
    end
  end
end