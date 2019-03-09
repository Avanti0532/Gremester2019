class Ranking < ActiveRecord::Base
  belongs_to :rank_type
  belongs_to :undergrad_university
end
