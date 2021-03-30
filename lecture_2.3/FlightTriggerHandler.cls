public class FlightTriggerHandler {
    public static Boolean isFirstTime = true;
    
    public static void onBeforeInsert(List<Flight__c> newFlights) {
        if (newFlights == null || newFlights.isEmpty()) return;
        
        List<Tourist__c> tourists = TouristManager.getByFlights(newFlights);
        Map<Id,Tourist__c> touristsMap = new Map<Id,Tourist__c> (tourists);
        
        List<Trip__c> trips = TripManager.getIdMinAgeDate(newFlights);
        Map<Id,Trip__c> tripsMap = new Map<Id,Trip__c> (trips);
        
        for (Flight__c flight: newFlights) {
            Tourist__c tourist = touristsMap.get(flight.Tourist__c);
            Trip__c trip = tripsMap.get(flight.Trip__c);
            if (tourist.Age__c < trip.Minimum_Age__c) {
                flight.addError(Constants.ERROR_AGE);
            }
            if (trip.Start_Date__c < Date.Today()) {
                flight.addError(Constants.ERROR_DATE);
                flight.Trip__c.addError(Constants.ERROR_DATE);
            }
        }
    }
}