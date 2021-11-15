class FactElevator < SecondBase::Base

  def self.getElevatorsData
    elevators = Elevator.where({ created_at: (Time.now - 25.hour)..Time.now })

    elevators.each do |elevator|
      fact = FactElevator.find_or_create_by(SerialNumber: elevator.serial_number)
      fact.Date_of_Commissioning = elevator.date_of_commissioning
      fact.BuildingId = elevator.column.battery.building.id
      fact.CustomerId = elevator.column.battery.building.customer.id
      fact.Building_City = elevator.column.battery.building.address.city
      fact.dim_customer_id = DimCustomer.buildDimension(fact.CustomerId)
      fact.save
    end
  end
end
