public class FlightCleanerBatchTriggerHandler {
    
    public static void onAfterInsert(List<BatchApexErrorEvent> errors) {
        Set<Id> asyncApexJobIds = new Set<Id> ();
        
        for(BatchApexErrorEvent evt : errors) {
            asyncApexJobIds.add(evt.AsyncApexJobId);
        }
        Map<Id, AsyncApexJob> jobs = new Map<Id, AsyncApexJob> (
            [SELECT Id, 
             ApexClass.Name 
             FROM AsyncApexJob 
             WHERE Id IN :asyncApexJobIds]
        );
        List<Error_Log__c> records = new List<Error_Log__c> ();
        
        for(BatchApexErrorEvent evt : errors) {
            if(jobs.get(evt.AsyncApexJobId).ApexClass.Name == 'AccountUpdaterJob') {
                
                for (String item : evt.JobScope.split(',')) {
                    Error_Log__c record = new Error_Log__c(
                        Records__c = (Id)item,
                        JobId__c = evt.AsyncApexJobId,
                        Error__c = evt.ExceptionType
                    );
                    records.add(record);
                }
            }
        }
        update records;
    }
}