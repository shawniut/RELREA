class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :url
      t.string :repo
      t.string :user

      t.timestamps
    end
  end
end
