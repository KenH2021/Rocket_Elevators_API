class CreateFactQuote < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_quotes do |t|
      t.integer :QuoteId
      t.datetime :Creation_Date
      t.string :Company_Name
      t.string :Email
      t.integer :NbElevator
      t.timestamps
    end
  end
end
