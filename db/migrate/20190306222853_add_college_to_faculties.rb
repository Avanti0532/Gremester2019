class AddCollegeToFaculties < ActiveRecord::Migration
  def change
    add_reference :faculties, :university, index: true
  end
end
