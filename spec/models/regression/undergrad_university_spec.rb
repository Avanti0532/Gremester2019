require 'rails_helper'

RSpec.describe UndergradUniversity, regressor: true do

  # === Relations ===
  it { is_expected.to belong_to :country }
  
  it { is_expected.to have_many :rankings }
  it { is_expected.to have_many :profiles_undergrad_universities }

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :country_id }
  it { is_expected.to have_db_column :ranking_id }
  it { is_expected.to have_db_column :university_name }
  it { is_expected.to have_db_column :university_type }
  it { is_expected.to have_db_column :acceptance_rate }
  it { is_expected.to have_db_column :location }
  it { is_expected.to have_db_column :university_link }
  it { is_expected.to have_db_column :university_desc }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["ranking_id"] }
  it { is_expected.to have_db_index ["country_id"] }
  it { is_expected.to have_db_index ["country_id", "university_name"] }


end