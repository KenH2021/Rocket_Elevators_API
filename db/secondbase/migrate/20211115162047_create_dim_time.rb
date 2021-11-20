class CreateDimTime < ActiveRecord::Migration[5.2]
  def change
    create_table :dim_times do |t|
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :form_type
    end
  end
end
