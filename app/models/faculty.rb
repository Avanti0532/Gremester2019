class Faculty < ActiveRecord::Base
  include ImageUploader::Attachment.new(:id_card)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :email, :password, :username, :weblink, :id_card, presence: true
end
