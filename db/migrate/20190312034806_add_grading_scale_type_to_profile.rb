class AddGradingScaleTypeToProfile < ActiveRecord::Migration
  def change
    add_reference :profiles, :grading_scale_type, index: true
  end
end
