class University < ActiveRecord::Base
  has_many :applications
  has_many :faculties
end