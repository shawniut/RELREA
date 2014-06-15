class AddProjectIdToJiras < ActiveRecord::Migration
  def change
    add_column :jiras, :project_id, :integer
  end
end
