public with sharing class FlightCleanerBatch implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents {
    private final String query = 
        'SELECT Id, Status__c, CreatedDate, Tourist__c ' +
        'FROM Flight__c ' +
        'WHERE Status__c =  \'' + Constants.FLIGHT_STATUS_DECLINED + '\'' +
        'OR CreatedDate > NEXT_N_DAYS: ' + Constants.FLIGHT_CLEANER_DAYS + '';
    private Integer counter;
    private Map<Id, Integer> touristOnFlight = new Map<Id, Integer> ();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Flight__c> flights) {
        Database.DeleteResult[] drflights = Database.delete(flights, false);
        
        for(Database.DeleteResult dr : drflights) {
            if (dr.isSuccess()) {
                
                for (Flight__c flight : flights) {
                    if(touristOnFlight.containsKey(flight.Tourist__c)) {
                        counter = touristOnFlight.get(flight.Tourist__c) + 1;
                        touristOnFlight.put(flight.Tourist__c, counter);
                    } else {
                        touristOnFlight.put(flight.Tourist__c, 1);
                    }
                }
            }
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        EmailService.sendEmailFromFlightCleanerBatch(touristOnFlight);
    }
}