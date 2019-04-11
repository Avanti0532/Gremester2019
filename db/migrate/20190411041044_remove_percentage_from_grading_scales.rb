class RemovePercentageFromGradingScales < ActiveRecord::Migration
  def change
    remove_column :grading_scales, :percentage, :varchar
  end
end
