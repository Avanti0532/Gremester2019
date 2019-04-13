class UndergradUniversitiesController < ApplicationController
  def index
    @undergrad_universities = UndergradUniversity.order(:university_name)
  end

  def create
    if (!params[:university_name].blank? and !params[:country].blank?)
      new_rank = nil
      if (!params[:ranking].blank? and !params[:rank_type].blank?)
        if !params[:new_rank_type].blank?
          begin
            rank_type = RankType.create(:name => params[:new_rank_type])
          rescue ActiveRecord::RecordNotUnique => e
            respond_to do |format|
              format.json {
                render json: {errors: "Rank Type has been added"}
                return
              }
            end
          end
        else
          rank_type = RankType.find_by_id(params[:rank_type])
        end
        new_rank = Ranking.new(:rank => params[:ranking])
        rank_type.rankings << new_rank
      end
        new_undergrad_university = UndergradUniversity.new()
        new_undergrad_university.university_desc = params[:university_desc]
        new_undergrad_university.acceptance_rate = params[:acceptance_rate]
        new_undergrad_university.location = params[:location]
        new_undergrad_university.university_link = params[:university_link]
        new_undergrad_university.university_name = params[:university_name]
        new_undergrad_university.country_id = params[:country]
        if !new_rank.nil?
          new_undergrad_university.rankings << new_rank
        end
        new_undergrad_university.save(:validate => true)
      if !new_undergrad_university.errors.full_messages.empty?
        respond_to do |format|
          format.json {
            render json: {errors: "University name has been added"}
            return
          }
        end
      end
    end
    respond_to do |format|
      format.json {
        render json: {success: "Success"}
        return
      }
    end
  end

  def show
    google_map_key = ENV['GOOGLE_MAP'].nil? ? '' : ENV['GOOGLE_MAP']
    @google_url = 'https://maps.googleapis.com/maps/api/js?key=' << google_map_key << '&libraries=places&callback=initialize'
    id = params[:id]
    @undergrad_university = UndergradUniversity.find_by_id(id)
  end
end
