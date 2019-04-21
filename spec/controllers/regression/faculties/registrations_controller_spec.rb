require 'rails_helper'

RSpec.describe Faculties::RegistrationsController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/faculties/sign_up').to('faculties/registrations#new', {}) }
  it { should route(:patch, '/faculties').to('faculties/registrations#update', {}) } 
  it { should route(:post, '/faculties').to('faculties/registrations#create', {}) } 
  it { should route(:get, '/faculties/cancel').to('faculties/registrations#cancel', {}) }
  it { should route(:get, '/faculties/edit').to('faculties/registrations#edit', {}) }
  it { should route(:delete, '/faculties').to('faculties/registrations#destroy', {}) } 
end