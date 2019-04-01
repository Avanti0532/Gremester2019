class CreateFacultyEvaluations < ActiveRecord::Migration
  def change
    create_table :faculty_evaluations do |t|
      t.references :faculty, index: true
      t.integer :score
      t.integer :ee_background
      t.string :comment
      t.timestamps null: false
    end
  end
end
