public class ExceptionHw {
    public class CusomException extends Exception {}

    /*Anonymous
    Tourist__c touristFirst = new Tourist__c();
	ExceptionHw.methodFirst(touristFirst);*/
    public static void methodFirst(Tourist__c touristFirst) {
        try {
            Insert touristFirst;
            Flight__c flighttouristFirst = new Flight__c(Status__c = 'Accepted', Tourist__c = touristFirst.Id, Trip__c = 'a085g0000011IV3AAM');
            Insert flighttouristFirst;
        } catch (DmlException e) {
            throw new CusomException('First exception ' + e.getCause());
        }
    }
    
    /*Anonymous
    Tourist__c touristFirst = new Tourist__c();
	ExceptionHw.methodSecond(touristFirst);*/
    public static void methodSecond(Tourist__c touristFirst) {
        try {
            Flight__c nameFlight = [SELECT Name FROM Flight__c WHERE Tourist__c =: touristFirst.Id];
            System.debug('Name(s) of the flight(s) for which the tourist is registered: ' + nameFlight);
        } catch (Exception qe) {
            throw qe;
        }
    }

    /*Anonymous
    Tourist__c touristSecond = new Tourist__c(Name = 'Vova', LastName__c = 'Ivanov', Birthdate__c = Date.newInstance(2002,1,17));
    ExceptionHw.methodThird(touristSecond);*/
    public static void methodThird(Tourist__c touristSecond) {
        try {
            methodFirst(touristSecond);
            methodSecond(touristSecond);
        } finally {
            System.debug('The end');
        }
    }

}