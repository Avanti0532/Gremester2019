require 'rails_helper'

RSpec.describe Application, regressor: true do

  # === Relations ===
  it { is_expected.to belong_to :profile }
  it { is_expected.to belong_to :university }

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :profile_id }
  it { is_expected.to have_db_column :university_id }
  it { is_expected.to have_db_column :applied }
  it { is_expected.to have_db_column :applied_date }
  it { is_expected.to have_db_column :admitted }
  it { is_expected.to have_db_column :admitted_date }
  it { is_expected.to have_db_column :rejected }
  it { is_expected.to have_db_column :rejected_date }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }
  it { is_expected.to have_db_column :term }
  it { is_expected.to have_db_column :year }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["university_id"] }
  it { is_expected.to have_db_index ["profile_id"] }

end