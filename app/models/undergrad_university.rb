class UndergradUniversity < ActiveRecord::Base
  belongs_to :country
  has_many :rankings
  has_and_belongs_to_many :profiles
end
