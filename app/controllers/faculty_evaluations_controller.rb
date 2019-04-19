class FacultyEvaluationsController < ApplicationController
  def show
    @student = Application.find_by_id(params[:id].to_i).profile.student
  end
  def create
    id = params[:id]
    comment = nil
    if params[:application_score].blank? || params[:ee_background].blank?
      flash[:notice] = 'Score/EE Background cannot be blank. Please select the fields.'
      redirect_to faculty_evaluation_path(id)
    else
      score = params[:application_score].to_i
      ee_background = params[:ee_background].to_i
      if !params[:comment].blank?
         comment = params[:comment]
      end
      @faculty_evaluation = FacultyEvaluation.create(faculty_id: current_faculty.id, application_id: id, score: score, ee_background: ee_background, comment: comment)
      flash[:notice] = 'Your evaluation has been submitted!'
      redirect_to fViewProfile_profiles_path(id)
    end

  end

  def index
    @evaluations = FacultyEvaluation.where(faculty_id: current_faculty)
  end

  def showEvaluations
   @evaluations = FacultyEvaluation.where("faculty_id!= #{current_faculty.id} AND application_id = #{params[:id]}")
  end
end
