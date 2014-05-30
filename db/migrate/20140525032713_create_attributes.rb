class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :project_id
      t.string :name
      t.string :value
      t.date :date

      t.timestamps
    end
  end
end
