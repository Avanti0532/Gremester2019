require 'rails_helper'

RSpec.describe Students::RegistrationsController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/students/sign_up').to('students/registrations#new', {}) }
  it { should route(:patch, '/students').to('students/registrations#update', {}) } 
  it { should route(:post, '/students').to('students/registrations#create', {}) } 
  it { should route(:get, '/students/cancel').to('students/registrations#cancel', {}) }
  it { should route(:get, '/students/edit').to('students/registrations#edit', {}) }
  it { should route(:delete, '/students').to('students/registrations#destroy', {}) } 

end