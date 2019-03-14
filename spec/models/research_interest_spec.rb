require 'rails_helper'


RSpec.describe ResearchInterest, type: :model do
  it { should have_many(:profiles).through(:research_interests_profiles) }
end