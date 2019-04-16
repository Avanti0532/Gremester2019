require 'rails_helper'

RSpec.describe ResearchInterestsController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/research_interests').to('research_interests#index', {}) }
end