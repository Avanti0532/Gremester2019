require 'rails_helper'

RSpec.describe ApplicationsController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:patch, '/applications/1').to('applications#update', {:id=>"1"}) } 
  it { should route(:get, '/applications/1').to('applications#show', {:id=>"1"}) }
end