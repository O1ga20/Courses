public class ExceptionHw {
    public class CusomException extends Exception {}

    public static void methodFirst() {
        try {
            Tourist__c touristFirst = new Tourist__c();
            Insert touristFirst;
            Flight__c flighttouristFirst = new Flight__c(Status__c = 'Accepted', Tourist__c = touristFirst.Id, Trip__c = 'a085g0000011IV3AAM');
            Insert flighttouristFirst;
        } catch (CusomException e) {
            throw new CusomException(e.getCause());
        }
    }

    public static void methodSecond() {
        try {
            Tourist__c touristFirst = new Tourist__c();
            Flight__c nameFlight = [SELECT Name FROM Flight__c WHERE Tourist__c =: touristFirst.Id];
            System.debug('Name(s) of the flight(s) for which the tourist is registered: ' + nameFlight);
        } catch (QueryException qe) {
            throw qe;
        }
    }

    public static void methodThird() {
        try {
            methodFirst();
            methodSecond();
        } catch (Exception x) {
            Tourist__c touristSecond = new Tourist__c(Name = 'Vova', LastName__c = 'Ivanov', Birthdate__c = Date.newInstance(2002, 1, 17));
            Insert touristSecond;
            Flight__c flightTouristSecond = new Flight__c(Status__c = 'Accepted', Tourist__c = touristSecond.Id, Trip__c = 'a085g0000011IV3AAM');
            Insert flightTouristSecond;
            Flight__c nameFlight = [SELECT Name FROM Flight__c WHERE Tourist__c =: touristSecond.Id];
            System.debug('Name(s) of the flight(s) for which the tourist is registered: ' + nameFlight);
        }
    }
}