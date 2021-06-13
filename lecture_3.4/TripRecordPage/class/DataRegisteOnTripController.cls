public with sharing class DataRegisteOnTripController {
    
    @AuraEnabled
    public static List<Tourist__c> getTourists(Id tripId) {
        Trip__c trip = TripManager.getTrip(tripId);
        List<Tourist__c> tourists = TouristManager.getSuitableForATrip(tripId, trip);
        return tourists;
    }
    
    @AuraEnabled
    public static Boolean getValidTrip(Id tripId) {
        Integer counter = TouristManager.getNumRegisteredOnTheTrip(tripId);
        Trip__c trip = TripManager.getTrip(tripId);
        Integer numVacantSeats = Integer.valueOf(trip.Seats__c) - counter;
        Boolean haveVacantSeats = (numVacantSeats != 0);
        Boolean notFlyAway = (trip.Start_Date__c.format() > Date.today().format());        
        Boolean validTrip = (haveVacantSeats && notFlyAway);
        return validTrip;
    }
    
    @AuraEnabled
    public static Boolean getCheckingFreeSeatsForTourists(Id tripId, Integer numberSelectedRows) {
        Integer counter = TouristManager.getNumRegisteredOnTheTrip(tripId);
        Trip__c trip = TripManager.getTrip(tripId);
        Integer numVacantSeats = Integer.valueOf(trip.Seats__c) - counter;
        Boolean enoughSeats = numVacantSeats >= numberSelectedRows;
        return enoughSeats;
    }
    
    @AuraEnabled
    public static void createFlights(Id tripId, List<Id> touristsId) {
        List<Flight__c> newFlights = new List<Flight__c> ();
        for (Id touristId : touristsId) {
            Flight__c newFlight = new Flight__c ();
            newFlight.Tourist__c = touristId;
            newFlight.Trip__c = tripId;
            newFlight.Status__c = Constants.FLIGHT_STATUS_OFFER_PENDING;
            newFlights.add(newFlight);
        }     
        insert newFlights;
    }
}