require 'rails_helper'

RSpec.describe UndergradUniversitiesController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/undergrad_universities').to('undergrad_universities#index', {}) }
  it { should route(:post, '/undergrad_universities').to('undergrad_universities#create', {}) } 
  it { should route(:get, '/undergrad_universities/1').to('undergrad_universities#show', {:id=>"1"}) }
end