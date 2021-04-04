trigger FlightCleanerBatchTrigger on BatchApexErrorEvent (after insert) {
    
    switch on Trigger.operationType {
        when AFTER_INSERT {
            FlightCleanerBatchTriggerHandler.onAfterInsert(Trigger.new);
        }
    }
}