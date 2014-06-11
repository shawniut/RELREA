class ChangeIdToInteger < ActiveRecord::Migration
    def self.up
    change_table :rattributes do |t|
      t.change :project_id, 'integer USING CAST(project_id AS integer)'
      t.change :metric_id, 'integer USING CAST(metric_id AS integer)'
      t.change :mfunction_id, 'integer USING CAST(mfunction_id AS integer)'
      t.change :raw_file_id, 'integer USING CAST(raw_file_id AS integer)'
    end
    change_table :infos do |t|
      t.change :project_id, 'integer USING CAST(project_id AS integer)'
    end
    change_table :raw_files do |t|
     t.change :rattribute_id, 'integer USING CAST(rattribute_id AS integer)'
    end
     
    change_table :values do |t|
     t.change :rattribute_id, 'integer USING CAST(rattribute_id AS integer)'
    end
    
    change_table :releases do |t|
     t.change :project_id, 'integer USING CAST(project_id AS integer)'
    end
  end
  # def self.down
  #   change_table :raw_files do |t|
  #     t.change :project_id, :string
  #     t.change :metric_id, :string
  #     t.change :mfunction_id, :string
  #     t.change :raw_file_id, :string
  #   end

  #   change_table :infos do |t|
  #     t.change :project_id, :string
  #   end
  #   change_table :raw_files do |t|
  #    t.change :rattribute_id, :string
  #   end
     
  #   change_table :values do |t|
  #    t.change :rattribute_id, :string
  #   end
    
  #   change_table :releases do |t|
  #    t.change :project_id, :string
  #   end
  # end
end
