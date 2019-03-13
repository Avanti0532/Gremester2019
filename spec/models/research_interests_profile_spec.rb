require 'rails_helper'

RSpec.describe ResearchInterestsProfile, type: :model do
  it { should belong_to(:profile) }
  it { should belong_to(:research_interest) }
end
