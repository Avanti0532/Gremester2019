class Student < ActiveRecord::Base
  has_one :profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :first_name, :last_name, :email, :username, :password, presence: true
  validates_uniqueness_of :username
  def current_profile
    self.profile
  end

  def moderator
    if self.isModerator == true
      self
    else
      nil
    end
  end
end
