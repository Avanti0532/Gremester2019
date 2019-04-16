require 'rails_helper'

RSpec.describe ThreddedPost, regressor: true do

  # === Relations ===
  
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :user_id }
  it { is_expected.to have_db_column :content }
  it { is_expected.to have_db_column :source }
  it { is_expected.to have_db_column :postable_id }
  it { is_expected.to have_db_column :messageboard_id }
  it { is_expected.to have_db_column :moderation_state }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["user_id"] }
  it { is_expected.to have_db_index ["postable_id"] }
  it { is_expected.to have_db_index ["postable_id", "created_at"] }
  it { is_expected.to have_db_index ["moderation_state", "updated_at"] }
  it { is_expected.to have_db_index ["messageboard_id"] }

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end