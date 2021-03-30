public class FlightManager {
    
    public static List<Flight__c> getByActiveTourists(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) {
            return new List<Flight__c> ();
        }
        List<Flight__c> notActiveTourists = [
            SELECT Status__c,
            Tourist__c,
            Tourist__r.Active__c
            FROM Flight__c
            WHERE Tourist__r.Active__c = false AND Tourist__c = :newTourists
        ];
        return notActiveTourists;
    }
    
    public static List<Flight__c> getTripsAndTourists(List<Flight__c> newFlights) {
        if (newFlights == null || newFlights.isEmpty()) {
            return new List<Flight__c> ();
        }
        List<Flight__c> tripsAndTourists = [
            SELECT Tourist__c,
            Trip__c,
            Tourist__r.Age__c, 
            Trip__r.Start_Date__c, 
            Trip__r.Minimum_Age__c
            FROM Flight__c
            WHERE Id IN: newFlights
        ];
        return tripsAndTourists;
    }
    
    public static Flight__c getName(Tourist__c tourist) {
        if (tourist == null) {
            return new Flight__c ();
        }
        Flight__c nameFlight = [
            SELECT Name 
            FROM Flight__c 
            WHERE Tourist__c =: tourist.Id
        ];
        return nameFlight;
    }
}