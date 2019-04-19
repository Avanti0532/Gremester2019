require 'rails_helper'

RSpec.describe FacultyEvaluation, regressor: true do

  # === Relations ===
  it { is_expected.to belong_to :faculty }
  it { is_expected.to belong_to :application }

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :faculty_id }
  it { is_expected.to have_db_column :application_id }
  it { is_expected.to have_db_column :score }
  it { is_expected.to have_db_column :ee_background }
  it { is_expected.to have_db_column :comment }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["faculty_id"] }
  it { is_expected.to have_db_index ["application_id"] }

end