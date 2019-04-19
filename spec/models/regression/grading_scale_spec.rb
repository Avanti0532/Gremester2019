require 'rails_helper'

RSpec.describe GradingScale, regressor: true do

  # === Relations ===
  it { is_expected.to belong_to :grading_scale_type }

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :grading_scale_type_id }
  it { is_expected.to have_db_column :letter_grade }
  it { is_expected.to have_db_column :gpa }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }
  it { is_expected.to have_db_column :low_percent }
  it { is_expected.to have_db_column :high_percent }

end