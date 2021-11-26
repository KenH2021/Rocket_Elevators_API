require "faker"
number_and_street = Array["2415 Ch Ste-Foy","110 Grande Allée O","255 Av. Brock S","2250 Rue Guy","1020 Enterprise Way","3201 Jefferson Ave","425 St SW","1050 Côte du Beaver Hall","6869 Boul Métropolitain E","800 Boulevard René-Lévesque O","1800 Owens St","5505 Boul. Saint-Lauren" ]
suite_or_appartment = Array["2","4","6","12","","","1","","","","","2000"]
city = Array["Quebec","Quebec","Montreal","Montreal","Sunnyvale","Redwood City","Calgary","Montreal","Saint-Léonard","Montreal","San Francisco","Montreal"]
postal_code = Array["G1V 1T1","G1R 2G8","H4X 0A3","H3H 2M3","94089","94062","T2P 3L8","H3B 5B4","H1P 1X8","H3B 1Y8","94158","H2T 1S6"]

first_name = Array["Nicolas","Nadya","Martin","Mathieu","Patrick" ,"David","Mathieu","Thomas","Serge","Francis","Mathieu","David","Nicolas","David","Remi","Timothy","Kiril","Emmanuela","Abdul","Krista","Jonathan"]
last_name = Array["Genest","Fortier","Chantal","Houde","Thibault","Boutin","Lortie","Carrier","Savoie","Patry-Jessop","Lefrancois","Larochelle","Pineault","Amyot","Gagnon","Wever","Kleinerman","Derilus","Akeeb","Sheely","Murray"]
title = Array["CEO","Director","Assistant Director" ,"Captain","Captain","Engineer","Engineer","Engineer","Enigneer","Engineer","Engineer","Engineer","Engineer","Engineer","Engineer","Developer","Developer","Developer","Developer","Developer","Developer"]
email = Array["nicolas.genest@codeboxx.biz","nadya.fortier@codeboxx.biz","martin.chantal@codeboxx.biz","mathieu.houde@codeboxx.biz","patrick.thibault@codeboxx.biz","david.boutin@codeboxx.biz","mathieu.lortie@codeboxx.biz","thomas.carrier@codeboxx.biz","serge.savoie@codeboxx.biz","francis.patry-jessop@codeboxx.biz","mathieu.lefrancois@codeboxx.biz","david.larochelle@codeboxx.biz","nicolas.pineault@codeboxx.biz","david.amyot@codeboxx.biz","remi.gagnon@codeboxx.biz","timothy.wever@codeboxx.biz","kiril.kleinerman@codeboxx.biz","emmanuela.derilus@codeboxx.biz","abdul.akeeb@codebozz.biz","krista.sheely@codeboxx.biz","jonathan.murray@codeboxx.biz"]


for i in 0...first_name.length()
    employees = Employee.new(first_name:first_name[i], last_name:last_name[i], title:title[i], email:email[i]
    )
    employees.save
 
end

for i in 0...number_and_street.length()
    addresses = Address.new(
        type_of_address:["Home","Business","Billing","Shipping","Contact"].sample,
        status:["Verified","Partially","Unverified","Ambiguous","Conflict","Reverted"].sample,
        entity:["Customer","Lead","Building"].sample,
        country:"Canada",
        number_and_street:number_and_street[i],
        suite_or_appartment:suite_or_appartment[i],
        city:city[i],
        postal_code:postal_code[i],
        notes:Faker::Lorem.paragraph
        )
    addresses.save
end

75.times do
    leads = Lead.new(
        full_name_contact:Faker::Name.name ,
        company_name:Faker::Company.name,
        email:Faker::Internet.email,
        phone:Faker::PhoneNumber.phone_number,
        project_name:Faker::Company.buzzword ,
        project_description:Faker::Lorem.paragraph,
        department:["Marketing","Webdesign","Architecture"].sample,
        message:Faker::Lorem.paragraph,
        request_date:Faker::Date.between(from: 3.years.ago, to: Date.today)
        )
    leads.save
    users = User.new( 
        email:Faker::Internet.email,
        password:Faker::Alphanumeric.alphanumeric(number: 6),
        remember_created_at:Faker::Date.between(from: 3.years.ago, to: Date.today),
        )
    users.save
    customers = Customer.new(
        user_id: users.id,
        customer_creation_date:Faker::Date.between(from: 3.years.ago, to: Date.today),
        company_name:Faker::Company.name,
        company_contact:Faker::Name.name,
        company_email:Faker::Internet.email,
        company_description:Faker::Lorem.paragraph,
        service_technical_authority_name:Faker::Name.name,
        technical_authority_phone:Faker::PhoneNumber.phone_number,
        service_technical_authority_email:Faker::Internet.email,
        address_id: addresses.id
        )
    customers.save
    buildings = Building.new(
        customer_id: customers.id,
        address_id: addresses.id,
        name_administrator_building:Faker::Name.name,
        email_administrator_building:Faker::Internet.email,
        phone_administrator_building:Faker::PhoneNumber.phone_number,
        name_technical_building:Faker::Name.name,
        email_technical_building:Faker::Internet.email,
        phone_technical_building:Faker::PhoneNumber.phone_number,
        )
    buildings.save
    building_details = BuildingDetail.new(
        information_key: "Contruction Year", 
        value: Faker::Number.between(from: 1980, to: 2020) ,
        building_id: buildings.id,
        number_of_floors: Faker::Number.between(from: 5, to: 100),
        department: leads.department ,
        year_of_contruction:Faker::Number.between(from: 1980, to: 2020) ,
        maximum_number_of_occupants: Faker::Number.between(from: 5, to: 200),
        )
    building_details.save
    batteries = Battery.new(
        Type:["Residential","Commercial","Corporate","Hybrid"].sample,
        Status:["Online","Offline","Intervention"].sample,
        Operation_Certificate:Faker::Lorem.paragraph,
        Information:Faker::Lorem.paragraph,
        Notes:Faker::Lorem.paragraph,
        building_id:buildings.id,
        employee_id:employees.id,
        Creation_Date:Faker::Date.between(from: 3.years.ago, to: 2.years.ago),
        Last_Inspect:Faker::Date.between(from: 2.years.ago, to: Date.today),
        )
    batteries.save
    columns = Column.new(
        battery_id: batteries.id,
        type_of_building: ["Residential", "Commercial", "Corporate", "Hybrid"].sample ,
        number_of_floors_served: Faker::Number.between(from: 5, to: 100),
        status:["Online","Offline","Intervention"].sample,
        information:Faker::Lorem.sentence ,
        notes:Faker::Lorem.paragraph  ,
        )
    columns.save
    elevators = Elevator.new(
        column_id:columns.id,
        serial_number:Faker::Number.number(digits: 9),
        model:["Standard ","Premium","Excelium"].sample,
        type_of_building:["Residential ","Commercial","Corporate","Hybrid"].sample,
        status:["Online","Offline","Intervention","Idle"].sample,
        date_of_commissioning:Faker::Date.between(from: 3.years.ago, to: Date.today),
        date_of_last_inspection:Faker::Date.between(from: 1.years.ago, to: Date.today),
        certificate_of_inspection:Faker::Number.number(digits: 6),
        information:Faker::Lorem.paragraph,
        notes:Faker::Lorem.paragraph
        )
    elevators.save
end
# 1.times do
#     quotes = Quote.create(
#         # user_id:column_id,
#         amount_of_elevator:Faker::Number.between(from: 1, to: 10),
#         price_per_elevator:Faker::Number.between(from: 1, to: 10),
#         building_type:["Residential ","Commercial","Corporate","Hybrid"].sample,
#     )
#     quotes.save
#     # @user = ustomer.create(user_id:users.id)
# end
