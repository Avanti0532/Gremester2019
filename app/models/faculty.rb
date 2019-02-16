class Faculty < ActiveRecord::Base
  include ImageUploader::Attachment.new(:id_card)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, :email, :password, :username, presence: true
  validates_uniqueness_of :username
  validates_format_of :email, :with => /.*\.edu\Z/, :message => "Please provide an university email"
  validate :id_or_link
  before_create :skip_confirmation_notification!

  def id_or_link
    if id_card_data.blank? && weblink.blank?
      errors.add(:id_card_data, "Either id card or link to faculty is required") unless id_card_data.present? || weblink.present?
    end
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

end
