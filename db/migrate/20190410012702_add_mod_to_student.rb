class AddModToStudent < ActiveRecord::Migration
  def change
    add_column :students, :isModerator, :boolean, default: false
  end
end
