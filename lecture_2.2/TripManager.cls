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
    
}