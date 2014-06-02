class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :project_id
      t.date :next_release_date
      t.date :start_date

      t.timestamps
    end
  end
end
