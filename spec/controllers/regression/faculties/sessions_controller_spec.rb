require 'rails_helper'

RSpec.describe Faculties::SessionsController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/faculties/sign_in').to('faculties/sessions#new', {}) }
  it { should route(:post, '/faculties/sign_in').to('faculties/sessions#create', {}) } 
  it { should route(:delete, '/faculties/sign_out').to('faculties/sessions#destroy', {}) } 
end