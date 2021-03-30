public class TouristManager {
    
    public static List<Tourist__c> getByName(String nameToSearch) {
        if (String.isBlank(nameToSearch)) {
            return new List<Tourist__c> ();
        }
        List<Tourist__c> selectedNames = [
            SELECT Name,
            Age__c
            FROM Tourist__c
            WHERE Name Like: nameToSearch
        ];
        return selectedNames;
    }
    
    public static List<Tourist__c> getSuitableAge(Set<Integer> ages) {
        if (ages == null || ages.isEmpty()) {
            return new List<Tourist__c> ();
        }
        List<Tourist__c> agesFound = new List<Tourist__c> ([
            SELECT Name,
            Age__c
            FROM Tourist__c
            WHERE Age__c IN : ages
        ]);
        return agesFound;
    }
    
    public static List<Tourist__c> getByStartDateYear(Integer year) {
        if (year == null || String.valueOf(year).length() != 4) {
            return new List<Tourist__c> ();
        }
        List<Tourist__c> startDateYear = [
            SELECT Name, 
            Age__c
            FROM Tourist__c
            WHERE Id IN(SELECT Tourist__c FROM Flight__c WHERE CALENDAR_YEAR(Trip__r.Start_Date__c) =: year)
        ];
        return startDateYear;
    }
    
    public static List<Tourist__c> getRegisteredOnTheTrip() {
        List<Tourist__c> registered = [
            SELECT Name,
            Age__c, 
            (SELECT Trip__r.Start_Date__c, Trip__r.Name FROM Flights__r)
            FROM Tourist__c
        ];
        return registered;
    }
    
    public static List<Tourist__c> getNotRegisteredOnTheTrip() {
        List<Tourist__c> notRegistered = [
            SELECT Name, 
            Age__c
            FROM Tourist__c
            WHERE Id NOT IN(SELECT Tourist__c FROM Flight__c)
        ];
        return notRegistered;
    }
    
    public static List<Tourist__c> getTheSame(Set<String> lastnames, Set<String> emails) {
        if ((lastnames == null && emails == null) || (lastnames.isEmpty() && emails.isEmpty())) {
            return new List<Tourist__c> ();
        }
        List<Tourist__c> same = [
            SELECT LastName__c,
            Email__c,
            IsDuplicate__c
            FROM Tourist__c
            WHERE LastName__c IN: lastnames AND Email__c IN: emails
        ];
        return same;
    }
    
    public static List<Tourist__c> getByFlights(List<Flight__c> newFlights) {
        if (newFlights == null || newFlights.isEmpty()) {
            return new List<Tourist__c> ();
        }
        Set<Id> touristsFlights = new Set<Id> ();
        for (Flight__c flight : newFlights) {
            touristsFlights.add(flight.Tourist__c);
        }
        List<Tourist__c> touristAge = [
            SELECT Age__c
            FROM Tourist__c
            WHERE Id IN: touristsFlights
        ];
        return touristAge;
    }
}