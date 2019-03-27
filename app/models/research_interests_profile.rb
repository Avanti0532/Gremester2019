class ResearchInterestsProfile < ActiveRecord::Base
  belongs_to :profile
  belongs_to :research_interest
end