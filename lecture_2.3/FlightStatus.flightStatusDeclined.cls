public class FlightStatus {
    
    public static void flightStatusDeclined(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) return;
        List<Flight__c> registration = FlightManager.getStatusTourist(newTourists);
        
        for (Tourist__c touristFlight: newTourists) {
            if (touristFlight.Active__c == false) {
                
                for (Integer i = 0; i < registration.size(); i++) {
                    registration.get(i).Status__c = 'Declined';
                }
            }
        }
        update registration;
    }
}