class UndergradUniversitiesController < ApplicationController
  def create
    puts 'here in rb'
    puts params[:university_name]
    puts params[:country]
    if (!params[:university_name].blank? and !params[:country].blank?)
      new_rank = nil
      if (!params[:ranking].blank? and !params[:rank_type].blank?)
        if !params[:new_rank_type].blank?
          rank_type = RankType.create(:name => params[:new_rank_type])
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
      current_student.current_profile.undergrad_universities << new_undergrad_university
    end
      redirect_to :back
  end
end