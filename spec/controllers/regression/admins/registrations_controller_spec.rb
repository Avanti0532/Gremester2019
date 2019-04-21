require 'rails_helper'

RSpec.describe Admins::RegistrationsController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/admins/sign_up').to('admins/registrations#new', {}) }
  it { should route(:patch, '/admins').to('admins/registrations#update', {}) } 
  it { should route(:post, '/admins').to('admins/registrations#create', {}) } 
  it { should route(:get, '/admins/cancel').to('admins/registrations#cancel', {}) }
  it { should route(:get, '/admins/edit').to('admins/registrations#edit', {}) }
  it { should route(:delete, '/admins').to('admins/registrations#destroy', {}) } 
end