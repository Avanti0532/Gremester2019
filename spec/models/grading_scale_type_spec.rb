require 'rails_helper'

RSpec.describe GradingScaleType, type: :model do
  it { should have_many :grading_scales}
end
