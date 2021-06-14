public class TouristAssignmentController {
    
    @AuraEnabled 
    public static List<Trip__c> getTrips(Id touristId){
        Tourist__c tourist = TouristManager.getTourist(touristId);
        List<Trip__c> trips = TripManager.getTripValid(tourist);
        return trips;
    } 
    
    @AuraEnabled 
    public static Integer getFreeSeatsOnTrip(Id tripId) {
        Integer counter = TouristManager.getNumRegisteredOnTheTrip(tripId);
        Trip__c trip = TripManager.getTrip(tripId);
        Integer numVacantSeats = Integer.valueOf(trip.Seats__c) - counter;
        return numVacantSeats;
    }
    
    @AuraEnabled
    public static Flight__c createFlight(Id tripId, Id touristId) {
        Flight__c newFlight = new Flight__c ();
        newFlight.Tourist__c = touristId;
        newFlight.Trip__c = tripId;
        newFlight.Status__c = Constants.FLIGHT_STATUS_OFFER_REQUESTED;
        insert newFlight;
        return newFlight;
    }
    
    @AuraEnabled
    public static Space_Point__c getNameCity(Id tripId) {
        Trip__c trip = TripManager.getTrip(tripId);
        Id spacePoint = trip.Departure_Space_Point__c;
        Space_Point__c point = SpacePointManager.getPoint(spacePoint);
        return point;
    }
    
    @AuraEnabled
    public static Weather_Daily_Forecast__c fetchWeather(Id tripId) {
        Trip__c trip = TripManager.getTrip(tripId);
        Id spacePoint = trip.Departure_Space_Point__c;
        Weather_Daily_Forecast__c weather = WeatherForecastManager.getWeather(spacePoint);
        return weather;
    }
}