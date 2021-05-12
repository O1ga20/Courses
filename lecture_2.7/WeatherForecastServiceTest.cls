@IsTest
public class WeatherForecastServiceTest {
    
    @TestVisible
    private static List<Space_Point__c> points;
    static {
        TestDataFactory.createSpacePoint();
        points = TestDataFactory.getSpacePoint();
    }
    
    @IsTest
    static void getForecastsSsuccess_Test() {
        Date day = Date.valueOf(String.valueOf('2021-05-11'));
        Test.setMock(HttpCalloutMock.class, new WeatherForecastServiceMock());
        
        Test.startTest();
        	Map<Date, Double> temperatureByDate =
            	WeatherForecastService.getForecasts(Double.valueOf(points.get(0).Latitude__c),
                                                	Double.valueOf(points.get(0).Longitude__c));
        Test.stopTest();
        
        System.assertEquals(1, temperatureByDate.size());
        System.assertEquals(11.2, temperatureByDate.get(day));
    }
    
    @IsTest
    static void getForecastsError_Test() {
        Test.setMock(HttpCalloutMock.class, new WeatherForecastServiceMockError());
        
        Test.startTest();
        	Map<Date, Double> temperatureByDate = 
            	WeatherForecastService.getForecasts(Double.valueOf(points.get(0).Latitude__c),
                                                	Double.valueOf(points.get(0).Longitude__c));
        Test.stopTest();
        
        System.assertEquals(true, WeatherForecastServiceMockError.returnValue);
        System.assertEquals(0, temperatureByDate.size());
    }
}