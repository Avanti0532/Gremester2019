class CreateRankTypes < ActiveRecord::Migration
  def change
    create_table :rank_types do |t|
      t.string  :name
      t.timestamps null: false
    end
    add_index :rank_types, :name, unique: true
  end
end
