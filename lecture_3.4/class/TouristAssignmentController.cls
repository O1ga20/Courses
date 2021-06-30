public class TouristAssignmentController {
    
    @AuraEnabled 
    public static List<Trip__c> getTrips(Id touristId){
        Tourist__c tourist = TouristManager.getTourist(touristId);
        List<Trip__c> trips = TripManager.getTripValid(tourist);
        return trips;
    } 
    
    @AuraEnabled 
    public static Trip__c getTrip(Id tripId) {
        Trip__c trip = TripManager.getTrip(tripId);
        return trip;
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
    public static Weather_Daily_Forecast__c fetchWeather(Id spacePoint) {
        Weather_Daily_Forecast__c weather = WeatherForecastManager.getWeather(spacePoint);
        return weather;
    }
}