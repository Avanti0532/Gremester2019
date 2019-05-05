require 'rails_helper'

RSpec.describe Student, regressor: true do

  # === Relations ===
  
  it { is_expected.to have_one :profile }
  it { is_expected.to have_one :thredded_user_detail }
  it { is_expected.to have_one :thredded_user_preference }
  it { is_expected.to have_many :thredded_posts }
  it { is_expected.to have_many :thredded_topics }
  it { is_expected.to have_many :thredded_private_posts }
  it { is_expected.to have_many :thredded_started_private_topics }
  it { is_expected.to have_many :thredded_last_user_topics }
  it { is_expected.to have_many :thredded_last_user_private_topics }
  it { is_expected.to have_many :thredded_user_messageboard_preferences }
  it { is_expected.to have_many :thredded_notifications_for_followed_topics }
  it { is_expected.to have_many :thredded_messageboard_notifications_for_followed_topics }
  it { is_expected.to have_many :thredded_notifications_for_private_topics }
  it { is_expected.to have_many :thredded_post_notifications }
  it { is_expected.to have_many :thredded_private_users }
  it { is_expected.to have_many :thredded_topic_read_states }
  it { is_expected.to have_many :thredded_private_topic_read_states }
  it { is_expected.to have_many :thredded_topic_follows }
  it { is_expected.to have_many :thredded_private_topics }
  it { is_expected.to have_many :thredded_post_moderation_records }
  it { is_expected.to have_many :thredded_post_moderated_records }

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :email }
  it { is_expected.to have_db_column :encrypted_password }
  it { is_expected.to have_db_column :username }
  it { is_expected.to have_db_column :first_name }
  it { is_expected.to have_db_column :last_name }
  it { is_expected.to have_db_column :reset_password_token }
  it { is_expected.to have_db_column :reset_password_sent_at }
  it { is_expected.to have_db_column :remember_created_at }
  it { is_expected.to have_db_column :sign_in_count }
  it { is_expected.to have_db_column :current_sign_in_at }
  it { is_expected.to have_db_column :last_sign_in_at }
  it { is_expected.to have_db_column :current_sign_in_ip }
  it { is_expected.to have_db_column :last_sign_in_ip }
  it { is_expected.to have_db_column :session_token }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }
  it { is_expected.to have_db_column :confirmation_token }
  it { is_expected.to have_db_column :confirmed_at }
  it { is_expected.to have_db_column :confirmation_sent_at }
  it { is_expected.to have_db_column :unconfirmed_email }
  it { is_expected.to have_db_column :isModerator }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["username"] }
  it { is_expected.to have_db_index ["reset_password_token"] }
  it { is_expected.to have_db_index ["email"] }

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(8)).for :password }
  it { is_expected.not_to allow_value(Faker::Lorem.characters(7)).for :password }
  it { is_expected.to allow_value(Faker::Lorem.characters(128)).for :password }
  it { is_expected.not_to allow_value(Faker::Lorem.characters(129)).for :password }

  # === Validations (Presence) ===
  context "with conditions" do
    before do
      allow(subject).to receive(:email_required?).and_return(true)
    end

    it { is_expected.to validate_presence_of :email }
  end

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_presence_of :password }
  context "with conditions" do
    before do
      allow(subject).to receive(:password_required?).and_return(true)
    end

    it { is_expected.to validate_presence_of :password }
  end

end