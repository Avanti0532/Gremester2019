require 'rails_helper'

RSpec.describe ProfilesController, regressor: true, type: :routing do
  # === Routes (REST) ===
  it { should route(:get, '/profiles/new').to('profiles#new', {}) }
  it { should route(:post, '/profiles/1').to('profiles#update', {:id=>"1"}) } 
  it { should route(:get, '/profiles/filter').to('profiles#filter', {}) }
  it { should route(:get, '/profiles/1/edit').to('profiles#edit', {:id=>"1"}) }
  it { should route(:get, '/profiles/1').to('profiles#show', {:id=>"1"}) }
  it { should route(:get, '/profiles/getUndergradUniversityByCountry').to('profiles#getUndergradUniversityByCountry', {}) }
  it { should route(:get, '/profiles/showSchools/1').to('profiles#showschools', {:id=>"1"}) }
  it { should route(:post, '/profiles/addschools').to('profiles#addschools', {}) } 
  it { should route(:post, '/profiles/deleteschools').to('profiles#deleteschools', {}) } 
  it { should route(:get, '/profiles/faculty/1').to('profiles#fViewProfile', {:id=>"1"}) }
end