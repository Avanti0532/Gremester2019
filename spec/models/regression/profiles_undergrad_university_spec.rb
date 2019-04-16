require 'rails_helper'

RSpec.describe ProfilesUndergradUniversity, regressor: true do

  # === Relations ===
  it { is_expected.to belong_to :profile }
  it { is_expected.to belong_to :undergrad_university }
  it { is_expected.to belong_to :grading_scale_type }
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :profile_id }
  it { is_expected.to have_db_column :undergrad_university_id }
  it { is_expected.to have_db_column :cgpa }
  it { is_expected.to have_db_column :degree_type }
  it { is_expected.to have_db_column :major }
  it { is_expected.to have_db_column :start_year }
  it { is_expected.to have_db_column :end_year }
  it { is_expected.to have_db_column :grading_scale_type_id }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["grading_scale_type_id"] }

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end