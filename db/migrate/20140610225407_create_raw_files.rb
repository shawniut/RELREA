class CreateRawFiles < ActiveRecord::Migration
  def change
    create_table :raw_files do |t|
      t.string :rattribute_id
      t.string :file
      t.string :source

      t.timestamps
    end
  end
end
