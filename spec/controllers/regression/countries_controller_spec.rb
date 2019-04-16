require 'rails_helper'

RSpec.describe CountriesController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/countries').to('countries#index', {}) }
end