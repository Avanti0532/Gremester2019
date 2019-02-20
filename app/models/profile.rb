
class Profile < ActiveRecord::Base
  belongs_to :student
  has_many :applications
end
