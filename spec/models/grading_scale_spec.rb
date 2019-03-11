require 'rails_helper'

RSpec.describe GradingScale, type: :model do
  it {should belong_to :grading_scale_type}
end
