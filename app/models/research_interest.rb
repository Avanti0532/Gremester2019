class ResearchInterest < ActiveRecord::Base
  has_many :research_interests_profiles
  has_many :profiles, through: :research_interests_profiles
end
