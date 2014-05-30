class CreateRattributes < ActiveRecord::Migration
  def change
    create_table :rattributes do |t|
      t.string :project_id
      t.string :name
      t.float :value
      t.date :date

      t.timestamps
    end
  end
end
