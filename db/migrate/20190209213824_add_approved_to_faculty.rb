class AddApprovedToFaculty < ActiveRecord::Migration
  def change
    add_column :faculties, :approved, :boolean
    add_index  :faculties, :approved

  end
end
