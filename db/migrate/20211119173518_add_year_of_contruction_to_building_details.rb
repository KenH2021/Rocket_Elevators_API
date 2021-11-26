class AddYearOfContructionToBuildingDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :building_details, :year_of_contruction, :string
  end
end
