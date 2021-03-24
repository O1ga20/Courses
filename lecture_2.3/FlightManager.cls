public class FlightManager {
    
     public static List<Flight__c> getStatusTourist(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) {
            return new List<Flight__c> ();
        }
        List<Flight__c> statusTourist = [
                SELECT Status__c,
                Tourist__c
                FROM Flight__c
                WHERE Tourist__c = :newTourists
            ];
        return statusTourist;
    }
}