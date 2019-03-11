class CreateGradingScales < ActiveRecord::Migration
  def change
    create_table :grading_scales do |t|
      t.references :grading_scale_type
      t.string :percentage
      t.string :letter_grade
      t.decimal :gpa
      t.timestamps null: false
    end
  end
end
