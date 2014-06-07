class AddStartDateToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :start_date, :date
  end
end
