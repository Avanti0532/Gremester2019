class CreateJoinTableResearchInterestProfiles < ActiveRecord::Migration
  def change
    create_join_table :profiles, :research_interests do |t|
      t.index [:profile_id, :research_interest_id], name: 'profile_research_interest'
      t.index [:research_interest_id, :profile_id], name: 'research_interest_profile'
    end
  end
end
