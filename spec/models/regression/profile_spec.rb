require 'rails_helper'

RSpec.describe Profile, regressor: true do

  # === Relations ===
  it { is_expected.to belong_to :country }
  it { is_expected.to belong_to :student }
  
  it { is_expected.to have_many :applications }
  it { is_expected.to have_many :profiles_undergrad_universities }
  it { is_expected.to have_many :undergrad_universities }
  it { is_expected.to have_many :research_interests_profiles }
  it { is_expected.to have_many :research_interests }

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :student_id }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }
  it { is_expected.to have_db_column :toefl }
  it { is_expected.to have_db_column :interested_term }
  it { is_expected.to have_db_column :interested_year }
  it { is_expected.to have_db_column :resume_data }
  it { is_expected.to have_db_column :sop_data }
  it { is_expected.to have_db_column :additional_attachment_data }
  it { is_expected.to have_db_column :gre_quant }
  it { is_expected.to have_db_column :gre_writing }
  it { is_expected.to have_db_column :gre_verbal }
  it { is_expected.to have_db_column :country_id }
  it { is_expected.to have_db_column :photo_id_data }
  it { is_expected.to have_db_column :degree_objective_phd }
  it { is_expected.to have_db_column :degree_objective_master }
  it { is_expected.to have_db_column :gender }
  it { is_expected.to have_db_column :year_work_exp }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["student_id"] }
  it { is_expected.to have_db_index ["country_id"] }

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :student_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end