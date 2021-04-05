public with sharing class FlightCleanerBatch implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents {
    private final String query = 
        'SELECT Id, Status__c, CreatedDate, Tourist__c ' +
        'FROM Flight__c ' +
        'WHERE Status__c = \'Declined\' OR CreatedDate> NEXT_N_DAYS: 30';
    private Integer counter = 1;
    private Map<Tourist__c, Integer> touristOnFlight = new Map<Tourist__c, Integer> ();
    private List<Tourist__c> tourists = new List<Tourist__c> ();
    private String recordlink = '';
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Flight__c> flights) {
        tourists = TouristManager.getByFlights(flights);
        Map<Id, Tourist__c> touristsMap = new Map<Id, Tourist__c> (tourists);
        
        for (Flight__c flight : flights) {
            Tourist__c tourist = touristsMap.get(flight.Tourist__c);
            if(touristOnFlight.containsKey(tourist)) {
                touristOnFlight.put(tourist, counter++);
            } else {
                touristOnFlight.put(tourist, 1);
            }
        }
        delete flights;
    }
    
    public void finish(Database.BatchableContext BC) {
        Send_Email__mdt mail = [
            SELECT Id, 
            Email__c
            FROM Send_Email__mdt LIMIT 1
        ];
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {mail.Email__c};
        message.subject = 'Flight cleaner Batch';
        for (Tourist__c tourist : tourists) {
            recordlink += '<a href="' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + tourist.Id + '">"' 
                + tourist.Name + ' ' + tourist.LastName__c + '"</a>' + ' : ' + touristOnFlight.get(tourist) + '<br>';
        }
        message.setHtmlBody('Batch completed. Flights removed. ' +
                            'Tourists and the number of remote flights for each tourist: ' + '<br>' + recordlink);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {message});
    }
}