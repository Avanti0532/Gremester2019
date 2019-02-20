class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :profile, index: true
      t.references :university, index: true
      t.boolean :applied
      t.datetime :applied_date
      t.boolean :admitted
      t.datetime :admitted_date
      t.boolean :rejected
      t.datetime :rejected_date
      t.timestamps null: false
    end
  end
end
