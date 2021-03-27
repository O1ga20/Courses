public class TouristTriggerHandler {
    
    public static Boolean isFirstTime = true;
    
    public static void onBeforeInsert(List<Tourist__c> newTourists) {
        TouristService.markDuplicates(newTourists);
    }
    
    public static void onAfterUpdate(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) return;
        List<Flight__c> flights = FlightManager.getStatusTourist(newTourists);
        List<FlIght__c> newStatus = new List<FlIght__c> ();
        
        for (Flight__c flightFirst: flights) {
            flightFirst.Status__c = 'Declined';
            newStatus.add(flightFirst);            
        }
        update newStatus;
    }
}