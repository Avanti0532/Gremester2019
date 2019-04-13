class AddLowPercentHighPercentToGradingScales < ActiveRecord::Migration
  def change
    add_column :grading_scales, :low_percent, :integer
    add_column :grading_scales, :high_percent, :integer
  end
end
