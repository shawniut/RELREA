class CreateJiras < ActiveRecord::Migration
  def change
    create_table :jiras do |t|
      t.string :url
      t.string :username
      t.string :password
      t.string :project_name

      t.timestamps
    end
  end
end
