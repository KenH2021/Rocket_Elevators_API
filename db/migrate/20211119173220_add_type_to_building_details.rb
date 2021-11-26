class AddTypeToBuildingDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :building_details, :type, :string
  end
end
