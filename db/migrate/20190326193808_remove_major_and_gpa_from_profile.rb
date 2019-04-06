class RemoveMajorAndGpaFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :cgpa
    remove_column :profiles, :interested_major
    remove_column :profiles, :grading_scale_type_id
  end
end
