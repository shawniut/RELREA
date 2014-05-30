class AddMetricIdToRattributes < ActiveRecord::Migration
  def change
    add_column :rattributes, :metric_id, :string
  end
end
