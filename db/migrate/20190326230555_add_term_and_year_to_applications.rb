class AddTermAndYearToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :term, :string
    add_column :applications, :year, :integer
  end
end
