@IsTest
public class FlightManagerTest {
    
    @IsTest
    static void testGetByActiveTourists() {
        TestDataFactory.createFlights();
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        List<Flight__c> notActiveTourists = FlightManager.getByActiveTourists(null);    
        System.assertEquals(new List<Flight__c> (), notActiveTourists);
        notActiveTourists = FlightManager.getByActiveTourists(tourists);    
        System.assertEquals(1, notActiveTourists.size());
    }
    
    @IsTest
    static void testGetTripsAndTourists() {
        TestDataFactory.createFlights();
        List<Flight__c> flights = TestDataFactory.getFlights();
        List<Flight__c> flightToSearch = new List<Flight__c> {flights[0]};
        List<Flight__c> tripsAndTourists = FlightManager.getTripsAndTourists(null);    
        System.assertEquals(new List<Flight__c> (), tripsAndTourists);
        tripsAndTourists = FlightManager.getTripsAndTourists(flightToSearch);    
        System.assertEquals(1, tripsAndTourists.size());
    }
    
    @IsTest
    static void testGetName() {
        TestDataFactory.createFlights();
        List<Flight__c> flights = TestDataFactory.getFlights();
        List<Flight__c> nameFlightTest = TestDataFactory.getFlightsName(flights);
        List<Tourist__c> tourist = TestDataFactory.getTourists();
        List<Flight__c> nameFlight = FlightManager.getName(null);    
        System.assertEquals(new List<Flight__c> (), nameFlight);
        nameFlight = FlightManager.getName(tourist);
        System.assertEquals(nameFlightTest, nameFlight);
    }
    
    @IsTest
    static void testGetFlights() {
        TestDataFactory.createFlights();
        List<Flight__c> flights = TestDataFactory.getFlights();
        List<Id> flightsIds = new List<Id> {flights[0].Id};
        List<Flight__c> foundFlights = FlightManager.getFlights(null);    
        System.assertEquals(new List<Flight__c> (), foundFlights);
        foundFlights = FlightManager.getFlights(flightsIds); 
        System.assertEquals(1, foundFlights.size());
    }
}