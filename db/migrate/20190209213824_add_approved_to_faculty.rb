class AddApprovedToFaculty < ActiveRecord::Migration
  def change
    add_column :faculties, :approved, :boolean, null: false, default: false
    add_index  :faculties, :approved
  end
end
