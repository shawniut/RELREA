class AddMfunctionIdToRattributes < ActiveRecord::Migration
  def change
    add_column :rattributes, :mfunction_id, :string
  end
end
