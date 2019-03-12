class CreateJoinTableProfilesUndergradUniversities < ActiveRecord::Migration
  def change
    create_table :profiles_undergrad_universities do |t|
      t.references :profiles
      t.references :undergrad_universities
      t.decimal :gpa
      t.timestamps null: false
    end
  end
end
