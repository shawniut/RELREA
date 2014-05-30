class CreateDataserviceMetrics < ActiveRecord::Migration
  def change
    create_table :dataservice_metrics do |t|
      t.string :name
      t.string :source
      t.string :dimension
      t.string :definition

      t.timestamps
    end
  end
end
