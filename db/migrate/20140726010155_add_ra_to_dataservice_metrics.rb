class AddRaToDataserviceMetrics < ActiveRecord::Migration
  def change
    add_column :dataservice_metrics, :ra, :string
  end
end
