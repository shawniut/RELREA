class AddWeightToRattributes < ActiveRecord::Migration
  def change
    add_column :rattributes, :weight, :float
  end
end
