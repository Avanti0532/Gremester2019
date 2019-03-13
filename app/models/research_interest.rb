class ResearchInterest < ActiveRecord::Base
  has_many :profiles, through: :research_interests_profiles
end
