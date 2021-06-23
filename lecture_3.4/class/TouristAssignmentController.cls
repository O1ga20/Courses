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
    public static void createFlight(Id tripId, Id touristId) {
       TripService.createFlight(tripId, touristId);
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