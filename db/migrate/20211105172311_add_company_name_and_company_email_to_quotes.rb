class AddCompanyNameAndCompanyEmailToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :company_name, :string
    add_column :quotes, :company_email, :string
  end
end
