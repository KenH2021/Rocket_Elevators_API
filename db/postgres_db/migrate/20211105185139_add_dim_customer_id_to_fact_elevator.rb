class AddDimCustomerIdToFactElevator < ActiveRecord::Migration[5.2]
  def change
    add_column :fact_elevators, :dim_customer_id, :integer
  end
end
