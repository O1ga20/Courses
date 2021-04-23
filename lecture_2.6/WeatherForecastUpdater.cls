public class WeatherForecastUpdater {
    
    @future (callout = true)
    public static void updateForecasts() {
        List<Space_Point__c> points = SpacePointManager.getPoints();
        Map<Date, Decimal> temperatureByDate = new Map<Date, Decimal> ();
        List<Date> deleteWeatherDates = new List<Date> ();
        List<Date> days = WeatherForecastManager.getDaysWeather();
        List<Weather_Daily_Forecast__c> newWeather = new List<Weather_Daily_Forecast__c> ();
        
        for (Space_Point__c point : points) {
            temperatureByDate = WeatherForecastService.getForecasts(point.Latitude__c, point.Longitude__c);
            for (Date day : temperatureByDate.keySet()) {
                if (days.contains(day)) {
                    deleteWeatherDates.add(day);
                }
                Weather_Daily_Forecast__c weather = new Weather_Daily_Forecast__c (
                    Space_Point__c = point.Id,
                    Date__c = day,
                    Average_Temperature__c = temperatureByDate.get(day)
                );
                newWeather.add(weather); 
            }
        }
        List<Weather_Daily_Forecast__c> oldWeatherToTheDelete = WeatherForecastManager.getToTheDelete(deleteWeatherDates);
        delete oldWeatherToTheDelete;
        insert newWeather;
    }
}