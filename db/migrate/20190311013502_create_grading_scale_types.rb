class CreateGradingScaleTypes < ActiveRecord::Migration
  def change
    create_table :grading_scale_types do |t|
      t.string :grading_scale_name
      t.timestamps null: false
    end
    add_index :grading_scale_types, :grading_scale_name, unique: true
  end
end
