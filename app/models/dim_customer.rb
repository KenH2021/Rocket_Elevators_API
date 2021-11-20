class DimCustomer < SecondBase::Base
  def self.buildDimension(customer_id)
    customer = Customer.find(customer_id)
    dimension = DimCustomer.find_or_create_by(Company_Name: customer.company_name)
    dimension.Creation_Date = customer.created_at
    dimension.Contact_Full_Name = customer.company_contact
    dimension.Contact_Email = customer.company_email
    dimension.NbElevators = 0
    customer.buildings.each do |building|
      building.batteries.each do |battery|
        battery.columns.each do |column|
          column.elevators.each do
            dimension.NbElevators += 1
          end
        end
      end
    end
    dimension.Customer_City = customer.address.city
    dimension.save
    return dimension.id
  end
end
