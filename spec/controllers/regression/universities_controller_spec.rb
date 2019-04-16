require 'rails_helper'

RSpec.describe UniversitiesController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/').to('universities#index', {}) }
  it { should route(:get, '/universities/1').to('universities#show', {:id=>"1"}) }
end