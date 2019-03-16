class ResearchInterestsController < ApplicationController
  def research_interest_params
    params.require(:research_interest).permit(:id, :name)
  end
  def index
    @research_interests = ResearchInterest.order(:name)
  end
end
