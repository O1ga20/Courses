public without sharing class TouristAssignmentController {
    
    @AuraEnabled(cacheable=true)
    public static List<Trip__c> getTrips(Id touristId){
        Tourist__c tourist = TouristManager.getTourist(touristId);
        List<Trip__c> trips = TripManager.getTripValid(tourist);
        return trips;
    } 
    
    @AuraEnabled(cacheable=true)
    public static Trip__c getTrip(Id tripId) {
        Trip__c trip = TripManager.getTrip(tripId);
        return trip;
    }
    
    @AuraEnabled
    public static void createFlight(Id tripId, Id touristId) {
       TripService.createFlight(tripId, touristId);
    }
    
    @AuraEnabled(cacheable=true)
    public static Space_Point__c getNameCity(Id tripId) {
        Trip__c trip = TripManager.getTrip(tripId);
        Id spacePoint = trip.Departure_Space_Point__c;
        Space_Point__c point = SpacePointManager.getPoint(spacePoint);
        return point;
    }
    
    @AuraEnabled(cacheable=true)
    public static Weather_Daily_Forecast__c fetchWeather(Id spacePoint) {
        Weather_Daily_Forecast__c weather = WeatherForecastManager.getWeather(spacePoint);
        return weather;
    }
}