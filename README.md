Rocket Elevators API 

https://apexrockets.xyz/

This week we added API to the web site making it more complete and functional for the company.
We've add 7 API.

Google Maps

To make a dynamiq map, in order to geolocate our customers on a map and display statistics on a location with the Location of the Building, Number of floors in the building  ,Client name, Number of Batteries, Columns and Elevator and Full name of technical contact.
To add a marker to the map you just need to link the address to the building in the BackOffice.

Twilio API

If the status of an Elevator in the database changes to "Intervention" status, the building's technical contact will be identified and an SMS will be sent to the telephone number associated with this contact. You can put the phone number in config/administrators.yml.

Slack

The Slack API leave written records and inform about certain events that occur through its infrastructure.

In the current use case, when a controller changes the status of an elevator, this status is reflected in the information system. When these status changes occur, a message is sent to the slack “elevator_operations” channel to leave a written record.

Dropbox

Dropbox API and its online storage allows storage to be done in a simple and flexible way while allowing access to the file from anywhere thanks to the multiple interfaces provided by Dropbox.

When a contact becomes a customer, the attached file will extract from the database and stored in your DropBox directory.

Sendgrid

Sendgrid is a historic and essential service provider in the field of email communication.
For Rocket Elevators, one use case to implement is sending a thank you email automatically when a contact completes the "Contact Us" form on the Rocket Elevators website. 

Google Cloud

Google Cloud application provides developers with many services. Among the most used, there is a Text-to-Speech functionality which can be used on a multitude of platforms.

The AI will make an audio file that you can listen with alot of info that you provide trough the database.

Zendesk

When the time comes to deliver quality customer service, managing customer requests should never leave a contact unanswered and ensure reasonable processing times. This is often the first of future customers.

ZenDesk is a SaaS platform to which you can subscribe and which allows you to manage the workflow that takes place when a customer comes into contact via the Website either via the “Contact Us” form or also via the “Get a Quote” form. ”In both cases, a ticket must be created in ZenDesk in the same way as a recording is added in the information system.

Zendesk Console ticket
to get access to the console
	url: apexrockets.zendesk.com
	email: apexrocketelevators@gmail.com
	password: newmoon2021!
Admin 
user: admin@apexrockets.com
mdp: 123456

-New_moon
