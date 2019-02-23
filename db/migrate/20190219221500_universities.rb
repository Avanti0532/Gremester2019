class Universities < ActiveRecord::Migration
  def change
    create_table(:universities) do |t|
      t.integer :rank
      t.string  :university_name
      t.string  :university_type
      t.float   :acceptance_rate
      t.string  :tuition
      t.string  :location
      t.string  :weather
      t.string  :university_link
      t.string  :university_desc
    end
    add_index :universities, :university_name, unique: true
  end
end
