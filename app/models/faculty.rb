class Faculty < ActiveRecord::Base
  include ImageUploader::Attachment.new(:id_card)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :email, :password, :username, presence: true
  validates_format_of :email, :with => /.*\.edu\Z/, :message => "Please provide an university email"
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

end