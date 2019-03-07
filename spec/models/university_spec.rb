require 'rails_helper'
require 'spec_helper'

RSpec.describe University, type: :model do
  it { should have_many(:applications) }
  it { should have_many(:faculties) }
end
