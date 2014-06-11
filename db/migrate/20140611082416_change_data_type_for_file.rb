class ChangeDataTypeForFile < ActiveRecord::Migration
   def self.up
    change_table :raw_files do |t|
      t.change :file, :text
    end
  end
  def self.down
    change_table :raw_files do |t|
      t.change :file, :string
    end
  end
end
