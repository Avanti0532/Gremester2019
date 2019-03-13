class CreateJoinTableResearchInterestProfiles < ActiveRecord::Migration
  def change
    create_table :research_interests_profiles do |t|
      t.references :research_interest
      t.references :profile
    end
  end
end
