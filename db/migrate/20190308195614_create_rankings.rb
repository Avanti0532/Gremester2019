class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :rank_type
      t.references :undergrad_university
      t.integer :rank
      t.timestamps null: false
    end
  end
end
