@IsTest
public class TouristTriggerTest {
    
    @TestSetup
    static void setup() {
        TestDataFactory.createFlights();
    }
    
    @IsTest
    static void testOnAfterInsert() {
        List<Tourist__c> tourist = TestDataFactory.createTourist();
        Test.startTest(); 
        Database.SaveResult[] result = Database.insert(tourist, false);
        Test.stopTest();
        List<Tourist__c> tourisDuplicates = TestDataFactory.getTouristsIsDuplicate();
        System.debug(tourisDuplicates);
        System.assertEquals(1, tourisDuplicates.size());
    }
    
    @IsTest
    static void testOnAfterUpdate() {
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        tourists[0].Active__c = false;
        Test.startTest();
        Database.SaveResult[] result = Database.update(tourists, false);
        Test.stopTest();
        List<Flight__c> flights = TestDataFactory.getFlights();
        System.assertEquals('Declined', flights[0].Status__c);
    }
}