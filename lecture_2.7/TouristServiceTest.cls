@IsTest
public class TouristServiceTest {
    
    @TestSetup
    static void setup() {
        TestDataFactory.createFlights();
    }
        
    @IsTest
    static void testMarkDuplicates() {
        TouristService.markDuplicates(null);
        System.assertEquals(0, 0);
        List<Tourist__c> tourists = TestDataFactory.createTourist();
        Set<Id> touristsIds = new Set<Id> {tourists[0].Id};
        Test.startTest(); 
        TouristService.markDuplicates(touristsIds);
        Test.stopTest();
        List<Tourist__c> tourisDuplicates = TestDataFactory.getTouristsIsDuplicate();
        System.assertEquals(1, tourisDuplicates.size());
    }
}