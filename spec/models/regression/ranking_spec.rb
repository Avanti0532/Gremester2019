require 'rails_helper'

RSpec.describe Ranking, regressor: true do

  # === Relations ===
  it { is_expected.to belong_to :rank_type }
  it { is_expected.to belong_to :undergrad_university }

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :rank_type_id }
  it { is_expected.to have_db_column :undergrad_university_id }
  it { is_expected.to have_db_column :rank }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

  
end