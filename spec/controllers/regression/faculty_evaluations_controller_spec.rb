require 'rails_helper'

RSpec.describe FacultyEvaluationsController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/faculty_evaluations').to('faculty_evaluations#index', {}) }
  it { should route(:post, '/faculty_evaluations/1').to('faculty_evaluations#create', {:id=>"1"}) } 
  it { should route(:get, '/faculty_evaluations/1').to('faculty_evaluations#show', {:id=>"1"}) }
  it { should route(:get, '/faculty_evaluations/showEvaluations/1').to('faculty_evaluations#showEvaluations', {:id=>"1"}) }
end