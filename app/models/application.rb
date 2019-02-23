class Application < ActiveRecord::Base
  belongs_to :profile
  belongs_to :university
end
