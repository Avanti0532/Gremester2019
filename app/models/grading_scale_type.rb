class GradingScaleType < ActiveRecord::Base
  has_many :grading_scales
  has_many :profiles
end
