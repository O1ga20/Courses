@IsTest
public class TripManagerTest {
    
    @IsTest
    static void testGetAndTourists(){
        TestDataFactory.createFlights();
        List<Trip__c> trips = new List<Trip__c> {TestDataFactory.getTrips()[0]};
        List<Trip__c> foundtrips = TripManager.getAndTourists(null);    
        System.assertEquals(new List<Trip__c> (), foundtrips);
        foundtrips = TripManager.getAndTourists(trips);    
        System.assertEquals(1, foundtrips.size());
    }
    
    @IsTest
    static void testGetIdMinAgeDate() {
        TestDataFactory.createFlights();
        List<Flight__c> flights = TestDataFactory.getFlights();
        List<Trip__c> trips = TripManager.getIdMinAgeDate(null);    
        System.assertEquals(new List<Trip__c> (), trips);
        trips = TripManager.getIdMinAgeDate(flights);    
        System.assertEquals(2, trips.size());
    }
}