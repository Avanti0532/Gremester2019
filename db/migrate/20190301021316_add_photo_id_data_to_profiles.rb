class AddPhotoIdDataToProfiles < ActiveRecord::Migration
  def change
    add_reference :profiles, :country, index: true
    add_column :profiles, :photo_id_data, :text
    add_column :profiles, :degree_objective_phd, :integer
    add_column :profiles, :degree_objective_master, :integer
    add_column :profiles, :gender, :string
    remove_column :profiles, :college, :string
  end
end
