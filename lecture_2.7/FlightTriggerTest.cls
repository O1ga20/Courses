@IsTest
public class FlightTriggerTest {
    
    @IsTest
    static void testOnBeforeInsertErrorAge() {
        Flight__c[] flight = TestDataFactory.createFlight('2020-03-03', 3, '2021-08-09', 'Accepted');
        Test.startTest();
        Database.SaveResult[] result = Database.insert(flight, false);
        Test.stopTest();
        System.assert(!result[0].isSuccess());
        System.assert(result[0].getErrors().size() > 0);
        System.assertEquals('Not suitable for age.', result[0].getErrors()[0].getMessage());
    }
    
    @IsTest
    static void testOnBeforeInsertErrorFlewAway() { 
        Flight__c[] flight = TestDataFactory.createFlight('2020-03-03', 1, '2019-08-09', 'Accepted');
        Test.startTest();
        Database.SaveResult[] result = Database.insert(flight, false);
        Test.stopTest();
        System.assert(!result[0].isSuccess());
        System.assert(result[0].getErrors().size() > 0);
        System.assertEquals('Already flew away.', result[0].getErrors()[0].getMessage());
    }
    
    @IsTest
    static void testOnBeforeInsertSuccess() { 
        Flight__c[] flight = TestDataFactory.createFlight('2020-03-03', 1, '2022-08-09', 'Accepted');
        Test.startTest();
        Database.SaveResult[] result = Database.insert(flight, false);
        Test.stopTest();
        System.assert(result[0].isSuccess());
        System.assertEquals(0, result[0].getErrors().size());
    }
}