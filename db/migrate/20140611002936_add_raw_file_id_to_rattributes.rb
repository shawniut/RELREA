class AddRawFileIdToRattributes < ActiveRecord::Migration
  def change
    add_column :rattributes, :raw_file_id, :string
  end
end
