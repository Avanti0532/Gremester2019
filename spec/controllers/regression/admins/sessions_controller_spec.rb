require 'rails_helper'

RSpec.describe Admins::SessionsController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/admins/sign_in').to('admins/sessions#new', {}) }
  it { should route(:post, '/admins/sign_in').to('admins/sessions#create', {}) } 
  it { should route(:delete, '/admins/sign_out').to('admins/sessions#destroy', {}) }
end