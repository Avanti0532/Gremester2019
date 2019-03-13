class RemoveMonthsWorkExperienceFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :month_work_exp
    remove_column :profiles, :year_work_exp
    add_column :profiles, :year_work_exp, :string
  end
end
