class RemoveUndergradIndex < ActiveRecord::Migration
  def change
    remove_index(:undergrad_universities, :name => "index_undergrad_universities_on_university_name")
    add_index :undergrad_universities, [:country_id, :university_name], unique: true
  end
end
