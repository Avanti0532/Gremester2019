class UndergradUniversitiesController < ApplicationController
  def undergrad_university_params
    params.require(:undergrad_university).permit(:id, :university_name)
  end
  def index
    @undergrad_universities = UndergradUniversity.all
  end
end
