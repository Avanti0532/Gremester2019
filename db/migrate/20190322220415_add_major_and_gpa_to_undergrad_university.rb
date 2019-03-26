class AddMajorAndGpaToUndergradUniversity < ActiveRecord::Migration
  def change
    add_column :profiles_undergrad_universities, :cgpa, :float
    add_column :profiles_undergrad_universities, :degree_type, :string
    add_column :profiles_undergrad_universities, :major, :string
    add_column :profiles_undergrad_universities, :start_year, :integer
    add_column :profiles_undergrad_universities, :end_year, :integer
    add_reference :profiles_undergrad_universities, :grading_scale_type, index: true
  end
end
