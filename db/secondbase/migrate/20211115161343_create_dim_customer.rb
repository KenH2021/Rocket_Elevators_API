class CreateDimCustomer < ActiveRecord::Migration[5.2]
  def change
    create_table :dim_customers do |t|
      t.datetime :Creation_Date
      t.string :Company_Name
      t.string :Contact_Full_Name
      t.string :Contact_Email
      t.integer :NbElevators
      t.string :Customer_City
      t.timestamps
    end
  end
end
