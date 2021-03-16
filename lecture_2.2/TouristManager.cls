public class TouristManager {
    //tourists (name, age) whose name contains John
    public static List<Tourist__c> touristJohn(String filter1) {
        List<Tourist__c> john = [
            SELECT Name, Age__c
            FROM Tourist__c
            WHERE Name Like: filter1
        ];
        return john;
    }

    //tourists (name, age) with the age of 20, 22, 24 years
    public static Set<Tourist__c> touristAge202224(Integer Age1, Integer Age2, Integer Age3) {
        Set<Tourist__c> age202224 = new Set<Tourist__c> ([
            SELECT Name, Age__c
            FROM Tourist__c
            WHERE Age__c =: Age1
            or Age__c =: Age2
            or Age__c =: Age3
        ]);
        return age202224;
    }

    //tourists (name, age) who started their flight in 2020
    public static List<Tourist__c> touristStart2020(Integer year) {
        List<Tourist__c> start2020 = [
            SELECT Name, Age__c
            FROM Tourist__c
            WHERE Id IN(SELECT Tourist__c FROM Flight__c WHERE CALENDAR_YEAR(Trip__r.Start_Date__c) =: year)
        ];
        return start2020;
    }

    //tourists (name, age) with a list of flights (start date, name)
    public static List<Tourist__c> touristListTrip() {
        List<Tourist__c> listTrip = [
            SELECT Name, Age__c, (SELECT Trip__r.Start_Date__c, Trip__r.Name FROM Flights__r)
            FROM Tourist__c
        ];
        return listTrip;
    }

    //tourists (name, age) who have not checked in for any flight
    public static List<Tourist__c> touristNotRegistered() {
        List<Tourist__c> notRegistered = [
            SELECT Name, Age__c
            FROM Tourist__c
            WHERE Id NOT IN(SELECT Tourist__c FROM Flight__c)
        ];
        return notRegistered;
    }
}