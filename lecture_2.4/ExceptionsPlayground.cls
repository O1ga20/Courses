public class ExceptionsPlayground {
    public class CustomException extends Exception {}
    
    public static void generateCustomException() {
        try {
            Tourist__c touristFirst = new Tourist__c ();
            Flight__c flighttouristFirst = new Flight__c(
                Status__c = Constants.FLIGHT_STATUS_ACCEPTED,
                Tourist__c = touristFirst.Id,
                Trip__c = 'a085g0000011IV3AAM'
            );
            Insert flighttouristFirst;
        } catch (DmlException e) {
            throw new CustomException('An exception ' + e.getCause());
        }
    }
    
    public static void generateRegularException() {
        try {
            Tourist__c touristFirst = new Tourist__c ();
            Flight__c nameFlight = FlightManager.getName(touristFirst);
        } catch (QueryException qe) {
            System.debug('The following exception has occurred: ' + qe.getMessage());
        }
    }
    
    public static void handleExceptions() {
        try {
            generateCustomException();
            generateRegularException();
        } catch(DmlException e) {
            System.debug('DmlException caught');    
        } catch(QueryException qe) {
            System.debug('QueryException caught');    
        } catch(Exception ex) {
            System.debug('Exception caught');    
        }
    }
}