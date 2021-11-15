class CreateFactElevator < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_elevators do |t|
      t.integer :SerialNumber
      t.datetime :Date_of_Commissioning
      t.integer :BuildingId
      t.integer :CustomerId
      t.string :Building_City
      t.timestamps
    end
  end
end
