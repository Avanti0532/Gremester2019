class ProfilesUndergradUniversity < ActiveRecord::Base
  belongs_to :profile
  belongs_to :undergrad_university
end