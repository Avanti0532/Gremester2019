require 'rails_helper'

RSpec.describe ThreddedMessageboard, regressor: true do


  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :name }
  it { is_expected.to have_db_column :slug }
  it { is_expected.to have_db_column :description }
  it { is_expected.to have_db_column :topics_count }
  it { is_expected.to have_db_column :posts_count }
  it { is_expected.to have_db_column :position }
  it { is_expected.to have_db_column :last_topic_id }
  it { is_expected.to have_db_column :messageboard_group_id }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }
  it { is_expected.to have_db_column :locked }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["slug"] }
  it { is_expected.to have_db_index ["messageboard_group_id"] }

end