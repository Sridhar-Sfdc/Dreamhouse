/**
 * @className: AirlineReservationApp
 * @description: This class provides methods and controls the entire airline reservation process.
 * @Version: 1.0
 * @dependencies objects: Flight__c, Passenger__c
 * @fields: Flight__c.Departure_Time__c, Flight__c.Flight_Number__c, Flight__c.Scheduled_Time__c, Flight__c.Status__c, Passenger__c.Email__c, Passenger__c.First_Name__c, Passenger__c.Last_Name__c, Passenger__c.Passenger_Number__c, Passenger__c.Ticket_Number__c
 */

 public with sharing class AirlineReservationApp {
    
    /**
     * @description: Assembles and displays an HTML table of Flight__c records.
     * @return: PageReference
     */
    public PageReference displayFlightList() {
        // Query for Flight__c records and build the table
        List<Flight__c> flightList = [SELECT Id, Flight_Number__c, Scheduled_Time__c, Status__c FROM Flight__c];
        
        return null;
    }
    
    /**
     * @description: Assembles and displays an HTML form for booking a new flight.
     * @return: PageReference
     */
    public PageReference bookFlight() {
        // Query for Passenger__c records and build the form
        List<Passenger__c> passengerList = [SELECT Id, First_Name__c, Last_Name__c, Passenger_Number__c, Email__c FROM Passenger__c];
        
        return null;
    }
    
    /**
     * @description: Books a new flight for the specified number of passengers.
     * @param: Integer passengerCount
     * @return: PageReference
     */
    public PageReference bookFlight(Integer passengerCount) {
        // Create new Flight__c record
        Flight__c newFlight = new Flight__c();
        
        // Set other fields as needed
        newFlight.Departure_Time__c = System.now();
        newFlight.Status__c = 'Booked';
        
        // Insert the new Flight__c record
        insert newFlight;
        
        // Create new Passenger__c records for each passenger
        List<Passenger__c> newPassengers = new List<Passenger__c>();
        for (Integer i = 0; i < passengerCount; i++) {
            Passenger__c newPassenger = new Passenger__c();
            newPassenger.First_Name__c = 'New';
            newPassenger.Last_Name__c = 'Passenger ' + i;
            newPassenger.Passenger_Number__c = 'PN-' + i;
            newPassenger.Ticket_Number__c = 'TK-' + i;
            newPassenger.Flight__c = newFlight.Id;
            
            newPassengers.add(newPassenger);
        }
        
        // Insert the new Passenger__c records
        insert newPassengers;
        
        // Redirect to the displayFlightList page
        return Page.FlightList;
    }
    
    /**
     * @description: Cancels the booking of a flight.
     * @return: PageReference
     */
    public PageReference cancelFlightBooking() {
        // Cancel the booking of the current flight
        Flight__c currentFlight = [SELECT Id FROM Flight__c WHERE Status__c = 'Booked' LIMIT 1];
        currentFlight.Status__c = 'Cancelled';
        update currentFlight;
        
        // Redirect to the bookFlight page
        return Page.BookFlight;
    }
}
