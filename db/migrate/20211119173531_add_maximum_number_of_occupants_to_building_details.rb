class AddMaximumNumberOfOccupantsToBuildingDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :building_details, :maximum_number_of_occupants, :string
  end
end
