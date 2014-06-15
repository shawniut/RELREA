class AddIsPrivateToInfos < ActiveRecord::Migration
  def change
    add_column :infos, :is_private, :boolean
  end
end
