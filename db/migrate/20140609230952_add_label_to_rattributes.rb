class AddLabelToRattributes < ActiveRecord::Migration
  def change
    add_column :rattributes, :label, :string
  end
end
