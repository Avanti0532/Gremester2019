require 'rails_helper'

RSpec.describe Students::SessionsController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/students/sign_in').to('students/sessions#new', {}) }
  it { should route(:post, '/students/sign_in').to('students/sessions#create', {}) } 
  it { should route(:delete, '/students/sign_out').to('students/sessions#destroy', {}) } 
end