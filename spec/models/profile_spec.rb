require 'rails_helper'
require 'spec_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:student) }
end
