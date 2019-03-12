class UndergradUniversity < ActiveRecord::Base
  belongs_to :country
  has_many :rankings
  has_many :profiles_undergrad_universities
  has_many :profiles, through: :profiles_undergrad_universities
  has_and_belongs_to_many :profiles
end
