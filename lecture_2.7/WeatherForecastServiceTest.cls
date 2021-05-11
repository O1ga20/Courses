@IsTest
public class WeatherForecastServiceTest {
    
    @IsTest
    static void getForecastsSsuccess_Test() {
        TestDataFactory.createSpacePoint();
        ListSpace_Point__c points = TestDataFactory.getSpacePoint();
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        HttpResponse response = new HttpResponse();
        Test.setMock(HttpCalloutMock.class, new WeatherForecastServiceMock());
                
        Test.startTest();
        	MapDate, Double temperatureByDate = 
                WeatherForecastService.getForecasts(Double.valueOf(points.get(0).Latitude__c),
                                                    Double.valueOf(points.get(0).Longitude__c));
        Test.stopTest();
        
        System.assertEquals(1, temperatureByDate.size());
        System.assertEquals(11.2, temperatureByDate.get(Date.valueOf(String.valueOf('2021-05-11'))));
    }
}