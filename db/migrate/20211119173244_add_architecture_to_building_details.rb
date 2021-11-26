class AddArchitectureToBuildingDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :building_details, :department, :string
  end
end
