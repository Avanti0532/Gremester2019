class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :student, index: true
      t.timestamps null: false
      t.integer :gre
      t.integer :toefl
      t.decimal :cgpa
      t.string :interested_major
      t.string :interested_term
      t.integer :interested_year
      t.integer :year_work_exp
      t.integer :month_work_exp
      t.text :resume_data
      t.text :sop_data
      t.text :additional_attachment_data
    end
  end
end
