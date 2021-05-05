@IsTest
public class WeatherForecastManagerTest {

    @IsTest
    static void testGetToTheDelete() {
       TestDataFactory.createSpacePoint();
       List<Space_Point__c> points = TestDataFactory.getSpacePoint();
       TestDataFactory.createWeatherDailyForecast(points);
       List<Weather_Daily_Forecast__c> weather = WeatherForecastManager.getToTheDelete(new List<Date> {Date.valueOf('2021-06-01')});
       System.assertEquals(1, weather.size());
    }
    
    @IsTest
    static void testGetDaysWeather() {
       TestDataFactory.createSpacePoint();
       List<Space_Point__c> points = TestDataFactory.getSpacePoint();
       TestDataFactory.createWeatherDailyForecast(points);
       List<Date> dateWeather = WeatherForecastManager.getDaysWeather();
       System.assertEquals(new List<Date> {Date.valueOf('2021-06-01')}, dateWeather);
    }
}