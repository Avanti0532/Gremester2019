require 'rails_helper'

RSpec.describe ResearchInterestsProfile, regressor: true do

  # === Relations ===
  it { is_expected.to belong_to :profile }
  it { is_expected.to belong_to :research_interest }
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :research_interest_id }
  it { is_expected.to have_db_column :profile_id }

  # === Database (Indexes) ===
  

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end