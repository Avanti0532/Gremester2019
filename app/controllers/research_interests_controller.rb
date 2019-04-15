class ResearchInterestsController < ApplicationController
  def index
    @research_interests = ResearchInterest.order(:name)
  end
end
