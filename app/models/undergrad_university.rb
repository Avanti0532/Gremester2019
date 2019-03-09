class UndergradUniversity < ActiveRecord::Base
  belongs_to :country
  has_many :rankings
end
