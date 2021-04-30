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
        Set<Id> tourists = new Set<Id> ();
        for (Flight__c flight : newFlights) {
            tourists.add(flight.Tourist__c);
        }
        List<Tourist__c> touristsAge = [
            SELECT Name,
            LastName__c,
            Age__c
            FROM Tourist__c
            WHERE Id IN: tourists
        ];
        return touristsAge;
    }
    
    public static List<Tourist__c> getTourists(Set<Id> touristIds) {
        if (touristIds == null || touristIds.isEmpty()) {
            return new List<Tourist__c> ();
        }
        List<Tourist__c> tourists = [
            SELECT Id, 
            Name, 
            LastName__c, 
            Email__c 
            FROM Tourist__c 
            WHERE Id IN :touristIds
        ];
        return tourists;
    }
    
    public static List<Tourist__c> getByNameSOSL(String nameToSearch) {
        if (String.isBlank(nameToSearch)) {
            return new List<Tourist__c> ();
        }
        List<List<Tourist__c>> selected = [
            FIND :nameToSearch
            RETURNING Tourist__c (
                Name,
                Age__c
                WHERE Name = :nameToSearch)
        ];
        List<Tourist__c> selectedNames = ((List<Tourist__c>)selected[0]);
        return selectedNames;
    }
    
    public static List<Tourist__c> getSameNameAge(String touristName, String touristAge) {
        if (touristname  == null || touristAge == null) {
            return new List<Tourist__c> ();
        }
        List<List<Tourist__c>> result = [
            FIND :touristName
            RETURNING Tourist__c (
                Name, 
                Age__c 
                WHERE Name = :touristName AND Age__c = :Integer.valueOf(touristAge))
        ];
        List<Tourist__c> foundTourists = ((List<Tourist__c>)result[0]);
        return foundTourists;
    }
}