public class ExceptionsPlayground {
    public class CustomException extends Exception {}
    
    public static void generateCustomException() { 
        try {
            Tourist__c touristFirst = new Tourist__c ();
            Insert touristFirst;
            Flight__c flighttouristFirst = new Flight__c (Status__c = Constants.FLIGHT_STATUS_ACCEPTED, 
                                                          Tourist__c = touristFirst.Id, 
                                                          Trip__c = 'a085g0000011IV3AAM');
            Insert flighttouristFirst;
        } catch (DmlException e) {
            throw new CustomException('An exception ' + e.getCause());
        }
    }
    
    public static void generateRegularException() {
        try {
            Tourist__c touristFirst = new Tourist__c ();
            Flight__c nameFlight = FlightManager.getName(touristFirst);
            //System.debug('Name(s) of the flight(s) for which the tourist is registered: ' + nameFlight);
        } catch (QueryException qe) {
            throw qe;
        }
    }
    
    public static void handleExceptions() {
        try {
            generateCustomException();
            generateRegularException();
        } catch (Exception x) {
            Tourist__c touristSecond = new Tourist__c (Name = 'Vova', 
                                                       LastName__c = 'Ivanov', 
                                                       Birthdate__c = Date.newInstance(2002, 1, 17));
            Insert touristSecond;
            Flight__c flightTouristSecond = new Flight__c (Status__c = Constants.FLIGHT_STATUS_ACCEPTED, 
                                                           Tourist__c = touristSecond.Id, 
                                                           Trip__c = 'a085g0000011IV3AAM');
            Insert flightTouristSecond;
            Flight__c nameFlight = FlightManager.getName(touristSecond);
            //System.debug('Name(s) of the flight(s) for which the tourist is registered: ' + nameFlight);
        }
    }
}