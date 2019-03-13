require 'rails_helper'

RSpec.describe ProfilesUndergradUniversity, type: :model do
  it { should belong_to(:profile) }
  it { should belong_to(:undergrad_university) }
end
