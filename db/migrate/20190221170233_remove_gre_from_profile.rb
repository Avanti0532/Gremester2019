class RemoveGreFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :gre
    add_column :profiles, :gre_quant, :integer
    add_column :profiles, :gre_writing, :decimal
    add_column :profiles, :gre_verbal, :integer
  end
end
