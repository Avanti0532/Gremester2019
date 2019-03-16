class RankTypesController < ApplicationController
  def index
    @all_rank_types = RankType.order(:name).pluck(:name, :id)
    respond_to do |format|
      format.json {
        render json: {rank_types: @all_rank_types}
      }
    end
  end
end