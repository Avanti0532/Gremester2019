class CreateUndergradUniversities < ActiveRecord::Migration
  def change
    create_table :undergrad_universities do |t|
      t.references :country, index: true
      t.references :ranking, index: true
      t.string  :university_name
      t.string  :university_type
      t.float   :acceptance_rate
      t.string  :location
      t.string  :university_link
      t.string  :university_desc
      t.timestamps null: false
    end
    add_index :undergrad_universities, :university_name, unique: true
  end
end
