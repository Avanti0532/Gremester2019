class CreateJoinTableProfilesUndergradUniversities < ActiveRecord::Migration
  def change
    create_table :profiles_undergrad_universities do |t|
      t.references :profile
      t.references :undergrad_university
    end
  end
end
