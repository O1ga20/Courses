@IsTest
public class TestDataFactory {
    
    public static void createTourists() {
        List<Tourist__c> tourists = new List<Tourist__c> {
            new Tourist__c(
                Name = 'Olga', 
                LastName__c = 'Taras', 
                Birthdate__c = Date.valueOf('2016-01-01'),
                Email__c = 'romandlickaya@gmail.com'),
             new Tourist__c(
                Name = 'Ira', 
                LastName__c = 'Ivanova', 
                Birthdate__c = Date.valueOf('2000-08-22')),
             new Tourist__c(
                Name = 'Vova', 
                LastName__c = 'Ivanov', 
                Birthdate__c = Date.valueOf('2016-03-04'))
             };
        insert tourists;
    }
    
    public static void createTourist() {
        List<Tourist__c> tourists = new List<Tourist__c> {
            new Tourist__c(
                Name = 'Inga', 
                LastName__c = 'Taras', 
                Birthdate__c = Date.valueOf('2016-01-01'))
            };
        insert tourists;
    }
    
    public static void createTrips() {
        List<Trip__c> trips = new List<Trip__c> {
            new Trip__c(
                Minimum_Age__c = 4,
                Start_Date__c = Date.valueOf('2021-06-04')),
            new Trip__c(
                Minimum_Age__c = 2,
                Start_Date__c = Date.valueOf('2022-06-04'))
            };
        insert trips;
    }
    
    public static void createFlights() {
        createTourist();
        createTrips();
        List<Tourist__c> tourists = getTourists();
        List<Trip__c> trips = getTrips();
        List<Flight__c> flights = new List<Flight__c> {
            new Flight__c(
                Status__c = 'Accepted',
                Tourist__c = tourists[0].Id,
                Trip__c = trips[0].Id),
            new Flight__c(
                Status__c = 'Accepted',
                Tourist__c = tourists[0].Id,
                Trip__c = trips[1].Id)
                };
      insert flights;
    }
    
    public static List<Tourist__c> getTourists() {
        List<Tourist__c> tourists = [
            SELECT Id,
            Name,
            LastName__c,
            Age__c,
            Email__c,
            IsDuplicate__c
            FROM Tourist__c
        ];
        return tourists;
    }
    
    public static List<Trip__c> getTrips() {
        List<Trip__c> trips = [
            SELECT Id,
            Name,
            Minimum_Age__c,
            Start_Date__c
            FROM Trip__c
        ];
        return trips;
    }
    
    public static List<Flight__c> getFlights() {
        List<Flight__c> flights = [
            SELECT Id,
            Name,
            Tourist__c,
            Trip__c
            FROM Flight__c
        ];
        return flights;
    }
    
    public static List<Flight__c> getFlightsName(List<Flight__c> flights) {
        List<Flight__c> flightsName = [
            SELECT Name
            FROM Flight__c
            WHERE Id IN :flights LIMIT 1
        ];
        return flightsName;
    }
    
     public static void createSpacePoint() {
        List<Space_Point__c> points = new List<Space_Point__c> {
            new Space_Point__c(
                City__c = 'Grodno',
                Country__c = 'Belarus',
                Latitude__c = 53.68, 
                Longitude__c = 23.82)
            };
        insert points;
    }
    
    public static List<Space_Point__c> getSpacePoint() {
        List<Space_Point__c> points = [
            SELECT Id
            FROM Space_Point__c
        ];
        return points;
    }
    
    public static void createWeatherDailyForecast(List<Space_Point__c> points) {
        List<Weather_Daily_Forecast__c> weathers = new List<Weather_Daily_Forecast__c> {
            new Weather_Daily_Forecast__c(
                Space_Point__c = points[0].Id,
                Date__c = Date.valueOf('2021-06-01'))
            };
        insert weathers;
    }
}