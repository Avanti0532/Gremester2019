class CreateJoinTableProfilesUndergradUniversities < ActiveRecord::Migration
  def change
    create_join_table :profiles, :undergrad_universities do |t|
      t.index [:profile_id, :undergrad_university_id], name: 'profile_undergrad'
      t.index [:undergrad_university_id, :profile_id], name: 'undergrad_profile'
    end
  end
end
