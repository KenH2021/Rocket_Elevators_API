class DropBuildingsTable < ActiveRecord::Migration[5.2]

     def up
      drop_table :buildings
    end
  
    def down
      raise ActiveRecord::IrreversibleMigration
    end
end

