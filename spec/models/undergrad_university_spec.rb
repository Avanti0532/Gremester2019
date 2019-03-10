require 'rails_helper'

RSpec.describe UndergradUniversity, type: :model do
  it { should belong_to(:country) }
  it { should have_many(:rankings) }
  it { should have_and_belong_to_many(:profiles) }
end
