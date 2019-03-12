class Country < ActiveRecord::Base
  has_many :undergrad_universities
  has_many :profiles
end
