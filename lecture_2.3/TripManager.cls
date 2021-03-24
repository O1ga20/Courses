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
    
    public static Trip__c getMinimumAgeStartDate(Flight__c registration) {
        if (registration == null) {
            return new Trip__c ();
        }
        Trip__c tripFlight = [
            SELECT Minimum_Age__c,
            Start_Date__c
            FROM Trip__c
            WHERE Id =: registration.Trip__c
        ];
        return tripFlight;
    }
}