@IsTest
public class TouristRestServiceTest {
    
    @TestVisible
    private static List<Tourist__c> tourist;
    static {
        tourist = TestDataFactory.createTourist();
    }
    
    @IsTest
    static void testGetTouristsSsuccess_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = URL.getSalesforceBaseUrl().toExternalForm() + '/services/apexrest/Tourist';
        req.params.put('fuzzyname', tourist.get(0).Name);
        req.params.put('age', '5');
        req.httpMethod = Constants.METHOD_HTTP_GET; 
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();      
        
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals(3, RestContext.response.responseBody.size());
    }
    
    @IsTest
    static void getTouristSsuccessfulWithoutAge_Test() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = URL.getSalesforceBaseUrl().toExternalForm() + '/services/apexrest/Tourist';
        req.params.put('fuzzyname', tourist.get(0).Name); 
        req.httpMethod = Constants.METHOD_HTTP_GET;  
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();      
        
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals(3, RestContext.response.responseBody.size());
    }
    
    @IsTest
    static void getTouristsErrorNotNameTourist_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = URL.getSalesforceBaseUrl().toExternalForm() + '/services/apexrest/Tourist';
        req.params.put('age', '5');
        req.httpMethod = Constants.METHOD_HTTP_GET; 
        RestContext.request = req;
        RestContext.response = res;
        
        
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();      
        
        System.assertEquals(404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_TOURIST_NAME_EMPTY, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    static void getTouristsErrorAgeNotNumbers_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = URL.getSalesforceBaseUrl().toExternalForm() + '/services/apexrest/Tourist';
        req.params.put('fuzzyname', tourist.get(0).Name);
        req.params.put('age', 'ghjliu');
        req.httpMethod = Constants.METHOD_HTTP_GET; 
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();  
        
        System.assertEquals(404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_TOURIST_AGE_NOT_NUMBER, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    static void createTouristDuplicate_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = URL.getSalesforceBaseUrl().toExternalForm() + '/services/apexrest/Tourist';
        req.httpMethod = Constants.METHOD_HTTP_POST;  
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.createTourist('Olga', 'Taras', '2020-03-03', 'romandlickaya@gmail.com');
        Test.stopTest(); 
        
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        
        System.assertEquals(1, tourists.size(), 'Insert failed.');
        System.assertEquals(409, RestContext.response.statusCode);
        System.assertEquals(Constants.DUPLICATE, RestContext.response.responseBody.toString());
    }
    
     @IsTest
    static void createTouristTypeException_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = URL.getSalesforceBaseUrl().toExternalForm() + '/services/apexrest/Tourist';
        req.httpMethod = Constants.METHOD_HTTP_POST;  
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.createTourist('Olga', 'Taras', '2020/03/03', 'romandlickaya@gmail.com');
        Test.stopTest(); 
        
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        
        System.assertEquals(1, tourists.size(), 'Insert failed.');
        System.assertEquals(409, RestContext.response.statusCode);
        System.assertEquals('Invalid date: 2020/03/03', RestContext.response.responseBody.toString());
    }
    
    @IsTest
    static void createTouristSsuccess_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = URL.getSalesforceBaseUrl().toExternalForm() + '/services/apexrest/Tourist';
        req.httpMethod = Constants.METHOD_HTTP_POST;  
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.createTourist('Olga', 'Taras', '2020-03-03', 'roman@gmail.com');
        Test.stopTest(); 
        
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        
        System.assertEquals(2, tourists.size());
        System.assertEquals('roman@gmail.com', tourists[1].Email__c);
    }
}