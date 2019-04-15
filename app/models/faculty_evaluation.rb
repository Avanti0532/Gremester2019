class FacultyEvaluation < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :application
end
