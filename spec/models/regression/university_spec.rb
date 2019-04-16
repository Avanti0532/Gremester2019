require 'rails_helper'

RSpec.describe University, regressor: true do

  # === Relations ===
  
  
  it { is_expected.to have_many :applications }
  it { is_expected.to have_many :faculties }

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :rank }
  it { is_expected.to have_db_column :university_name }
  it { is_expected.to have_db_column :university_type }
  it { is_expected.to have_db_column :acceptance_rate }
  it { is_expected.to have_db_column :tuition }
  it { is_expected.to have_db_column :location }
  it { is_expected.to have_db_column :weather }
  it { is_expected.to have_db_column :university_link }
  it { is_expected.to have_db_column :university_desc }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["university_name"] }

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end