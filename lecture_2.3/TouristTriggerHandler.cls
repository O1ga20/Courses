public class TouristTriggerHandler {
    public static Boolean isFirstTime = true;
    
    public static void onBeforeInsert(List<Tourist__c> newTourists) {
        TouristService.markDuplicates(newTourists);
    }
    
    public static void onAfterUpdate(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) return;
        List<Flight__c> flights = FlightManager.getByActiveTourists(newTourists);
        List<Flight__c> newStatus = new List<Flight__c> ();
        
        for (Flight__c flightFirst: flights) {
            flightFirst.Status__c = Constants.FLIGHT_STATUS_DECLINED;
            newStatus.add(flightFirst);            
        }
        update newStatus;
    }
}