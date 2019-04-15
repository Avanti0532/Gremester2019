class RemoveProfileFromFacultyEvaluation < ActiveRecord::Migration
  def change
    remove_reference :faculty_evaluations, :profile, index: true
  end
end
