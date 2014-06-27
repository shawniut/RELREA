class AddCodeToDataserviceMetrics < ActiveRecord::Migration
  def change
    add_column :dataservice_metrics, :code, :string
  end
end
