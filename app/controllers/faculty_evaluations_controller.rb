class FacultyEvaluationsController < ApplicationController
  def faculty_evaluation_params
    params.require(:faculty_evaluation).permit(:id, :score, :ee_background, :comment)
  end
    def create
    end
   def show


   end
  def new
    id = params[:id]
    @profile = Profile.find(id);

    @faculty_evaluation = FacultyEvaluation.create(faculty_evaluation_params)
    @faculty_evaluation.save

  end
end
