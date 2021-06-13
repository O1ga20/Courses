public class TripManager {
    
    public static List<Trip__c> getAndTourists(List<Trip__c> trips) {
        if (trips == null || trips.isEmpty()) {
            return new List<Trip__c> ();
        }
        List<Trip__c> andTourists = [
            SELECT Id,
            Name,
            Minimum_Age__c,
            (SELECT Id, Tourist__r.Name, Tourist__r.Age__c FROM Flights__r)
            FROM Trip__c 
            WHERE Id IN :trips
        ];
        return andTourists;
    }
    
    public static List<Trip__c> getIdMinAgeDate(List<Flight__c> newFlights) {
        if (newFlights == null || newFlights.isEmpty()) {
            return new List<Trip__c> ();
        }
        Set<Id> tripFlights = new Set<Id> ();
        for (Flight__c flight : newFlights) {
            tripFlights.add(flight.Trip__c);
        }
        List<Trip__c> trips = [
            SELECT Minimum_Age__c,
            Start_Date__c
            FROM Trip__c
            WHERE Id IN: tripFlights
        ];
        return trips;
    }
    
    public static  Trip__c getTrip(Id tripId) {
        if (tripId == null) {
            return new Trip__c ();
        }
         Trip__c trip = [
            SELECT Minimum_Age__c,
            Start_Date__c,
            End_Date__c,
            Seats__c
            FROM Trip__c
            WHERE Id =: tripId
        ];
        return trip;
    }
}