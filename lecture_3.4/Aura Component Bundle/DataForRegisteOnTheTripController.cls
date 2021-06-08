public with sharing class DataForRegisteOnTheTripController {
    
    @AuraEnabled
    public static List<Tourist__c> getTourists(Id tripId) {
        List<Trip__c> trip = TripManager.getTrip(tripId);
        List<Tourist__c> tourists = TouristManager.getSuitableForATrip(trip);
        return tourists;
    }
    
    @AuraEnabled
    public static Boolean getCheckingSeats(String tripId, Integer numberSelectedRows) {
        Integer counter = TouristManager.getNumRegisteredOnTheTrip(tripId);
        List<Trip__c> trip = TripManager.getTrip(tripId);
        Integer numVacantSeats = Integer.valueOf(trip[0].Seats__c) - counter;
        Boolean enoughSeats = numVacantSeats >= numberSelectedRows;
        return enoughSeats;
    }
}