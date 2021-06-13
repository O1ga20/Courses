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
        List<Tourist__c> agesFound = [
            SELECT Name,
            Age__c
            FROM Tourist__c
            WHERE Age__c IN : ages
        ];
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
    
    public static List<Tourist__c> getRegisteredOnTheTrips() {
        List<Tourist__c> registered = [
            SELECT Name,
            Age__c,
            (SELECT Trip__r.Start_Date__c, Trip__r.Name FROM Flights__r WHERE Trip__c != null)
            FROM Tourist__c
            WHERE Id IN (SELECT Tourist__c FROM Flight__c)
        ];
        return registered;
    }
    
    public static List<Tourist__c> getNotRegisteredOnTheTrips() {
        List<Tourist__c> notRegistered = [
            SELECT Name, 
            Age__c
            FROM Tourist__c
            WHERE Id NOT IN (SELECT Tourist__c FROM Flight__c)
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
    
    public static List<Tourist__c> getNotRegisteredOnTheTrip(Id tripId) {
        if (tripId == null) {
            return new List<Tourist__c> ();
        }
        List<Tourist__c>  notRegistered = [
            SELECT Name,
            LastName__c,
            Age__c,
            Email__c,
            Upcoming_Flight_Count__c
            FROM Tourist__c
            WHERE Id NOT IN (
                SELECT Tourist__c 
                FROM Flight__c 
                WHERE Trip__c = :tripId)
            ORDER BY Upcoming_Flight_Count__c ASC 
            LIMIT 10
        ];
        return notRegistered;
    }
    
    public static List<Tourist__c> getSuitableForATrip(Id tripId, Trip__c trip) {
        if (tripId == null || trip == null) {
            return new List<Tourist__c> ();
        }
        List<Tourist__c>  tourists = [
            SELECT Id,
            Name, 
            Email__c, 
            Gender__c,
            Active__c,
            Age__c
            FROM Tourist__c
            WHERE 	Active__c = true
            AND Age__c >: trip.Minimum_Age__c
            AND Id NOT IN (
                SELECT Tourist__c
                FROM Flight__c
                WHERE  ((Trip__r.Start_Date__c >=: trip.Start_Date__c 
                        AND Trip__r.Start_Date__c<=: trip.End_Date__c)
                        OR (Trip__r.End_Date__c >=: trip.Start_Date__c 
                        AND Trip__r.End_Date__c <=: trip.End_Date__c)))
        ];
        return tourists;
    }
    
    public static Integer getNumRegisteredOnTheTrip(Id tripId) {
        if (tripId == null) return null;
        List<Tourist__c> tourists = [
            SELECT Id
            FROM Tourist__c
            WHERE Id IN (
                SELECT Tourist__c 
                FROM Flight__c 
                WHERE Trip__c = :tripId)
        ];
        Integer counter = tourists.size();
        return counter;
    }
    
    public static Tourist__c getTourist(Id touristId) {
        if (touristId == null) {
            return new Tourist__c ();
        }
        Tourist__c tourist = [
            SELECT Id, 
            Name, 
            LastName__c, 
            Age__c 
            FROM Tourist__c 
            WHERE Id = :touristId
        ];
        return tourist;
    }
}