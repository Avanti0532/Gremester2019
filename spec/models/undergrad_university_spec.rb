require 'rails_helper'

RSpec.describe UndergradUniversity, type: :model do
  it { should belong_to(:country) }
  it { should have_many(:rankings) }
end
