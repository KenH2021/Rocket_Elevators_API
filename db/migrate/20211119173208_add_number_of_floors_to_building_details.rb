class AddNumberOfFloorsToBuildingDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :building_details, :number_of_floors, :string
  end
end
