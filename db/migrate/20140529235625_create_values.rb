class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string :rattribute_id
      t.float :mvalue
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
