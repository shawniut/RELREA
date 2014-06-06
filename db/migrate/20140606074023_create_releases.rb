class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :project_id
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
