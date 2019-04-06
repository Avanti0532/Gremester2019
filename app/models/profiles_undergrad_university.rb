class ProfilesUndergradUniversity < ActiveRecord::Base
  belongs_to :profile
  belongs_to :undergrad_university
  belongs_to :grading_scale_type
end