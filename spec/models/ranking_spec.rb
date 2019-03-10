require 'rails_helper'

RSpec.describe Ranking, type: :model do
  it { should belong_to(:rank_type) }
end
