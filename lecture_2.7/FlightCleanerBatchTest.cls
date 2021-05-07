@IsTest
public class FlightCleanerBatchTest {
    
    @IsTest
    static void testBatch() {
        TestDataFactory.createFlightsForBatch();
        Test.startTest();
        FlightCleanerBatch flightCleanerBatch = new FlightCleanerBatch();
        Database.executeBatch(flightCleanerBatch);
        Test.stopTest();
        List<Flight__c> flights = TestDataFactory.getFlights();
        System.assertEquals(0, flights.size());
    }
}