require 'rails_helper'

RSpec.describe ResearchInterest, regressor: true do

  # === Relations ===
  
  
  it { is_expected.to have_many :research_interests_profiles }
  it { is_expected.to have_many :profiles }

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :name }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

end