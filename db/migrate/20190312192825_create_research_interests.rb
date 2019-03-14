class CreateResearchInterests < ActiveRecord::Migration
  def change
    create_table :research_interests do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
