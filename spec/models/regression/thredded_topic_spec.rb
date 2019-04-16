require 'rails_helper'

RSpec.describe ThreddedTopic, regressor: true do

  # === Relations ===
  
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :user_id }
  it { is_expected.to have_db_column :last_user_id }
  it { is_expected.to have_db_column :title }
  it { is_expected.to have_db_column :slug }
  it { is_expected.to have_db_column :messageboard_id }
  it { is_expected.to have_db_column :posts_count }
  it { is_expected.to have_db_column :sticky }
  it { is_expected.to have_db_column :locked }
  it { is_expected.to have_db_column :hash_id }
  it { is_expected.to have_db_column :moderation_state }
  it { is_expected.to have_db_column :last_post_at }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["user_id"] }
  it { is_expected.to have_db_index ["slug"] }
  it { is_expected.to have_db_index ["moderation_state", "sticky", "updated_at"] }
  it { is_expected.to have_db_index ["messageboard_id"] }
  it { is_expected.to have_db_index ["last_post_at"] }
  it { is_expected.to have_db_index ["hash_id"] }

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end