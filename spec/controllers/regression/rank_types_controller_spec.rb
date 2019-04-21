require 'rails_helper'

RSpec.describe RankTypesController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/rank_types').to('rank_types#index', {}) }
end