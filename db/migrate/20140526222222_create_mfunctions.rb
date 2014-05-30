class CreateMfunctions < ActiveRecord::Migration
  def change
    create_table :mfunctions do |t|
      t.string :name
      t.string :parameter

      t.timestamps
    end
  end
end
