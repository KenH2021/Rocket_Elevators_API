class MapsController < ApplicationController
    def index
        
        @location =[]
        @floors =[]
        @names=[]
        @nb_batteries= []
        @nb_columns= []
        @nb_elevators = []
        @tech_name = []


        Building.all.each do |building|
        f=0
        x=0
        y=0
        z=0
        @location.push(building.address.number_and_street)
        @names.push(building.customer.company_contact)
        @tech_name.push(building.name_technical_building)
        @nb_columns.push(building.batteries.count)
        
            building.batteries.all.each do |battery|
                @nb_batteries.push(battery.columns.count)
                battery.columns.all.each do |column|
                    @floors.push(building.building_detail.number_of_floors)
                    @nb_elevators.push(column.elevators.count)
                end
            end
        end
        @location 
        @floors 
        @names
        @nb_batteries
        @nb_elevators 
        @tech_name
    end

    def test
       
    end
    def show
    end

end