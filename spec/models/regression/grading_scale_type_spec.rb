require 'rails_helper'

RSpec.describe GradingScaleType, regressor: true do

  # === Relations ===
  
  
  it { is_expected.to have_many :grading_scales }
  it { is_expected.to have_many :profiles_undergrad_universities }

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :grading_scale_name }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["grading_scale_name"] }

end