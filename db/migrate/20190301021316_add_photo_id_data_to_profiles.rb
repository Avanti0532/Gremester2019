class AddPhotoIdDataToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :photo_id_data, :string
    add_column :profiles, :citizenship, :string
    add_column :profiles, :degree_objective_phd, :integer
    add_column :profiles, :degree_objective_master, :integer
    add_column :profiles, :gender, :string
  end
end
