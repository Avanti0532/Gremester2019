require 'rails_helper'

RSpec.describe HomepageController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/').to('homepage#index', {}) }
end