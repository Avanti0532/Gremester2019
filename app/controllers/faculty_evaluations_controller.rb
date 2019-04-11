class FacultyEvaluationsController < ApplicationController
  def show
    @student = Application.find_by_id(params[:id].to_i).profile.student
  end
  def create
    id = params[:id]
    score = nil
    ee_background = nil
    comment = nil
    if !params[:application_score].blank?
      score = params[:application_score].to_i
    end
    if !params[:ee_background].blank?
      ee_background = params[:ee_background].to_i
    end
    if !params[:comment].blank?
      comment = params[:comment]
    end
    @student = Application.find_by_id(id.to_i).profile.student
    @faculty_evaluation = FacultyEvaluation.create(application_id: id, score: score, ee_background: ee_background, comment: comment)
    @faculty_evaluation.faculty = current_faculty
    @faculty_evaluation.save
    flash[:notice] = 'Your evaluation has been submitted!'
    redirect_to fViewProfile_profiles_path(id)
  end

  def index
    @evaluations = FacultyEvaluation.where(faculty_id: current_faculty)
  end

  def showEvaluations
   @evaluations = FacultyEvaluation.where("faculty_id!= #{current_faculty.id} AND application_id = #{params[:id]}")
  end
end
