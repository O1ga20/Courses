trigger FlightCleanerBatchTrigger on BatchApexErrorEvent (after insert) {
    
    if(TouristTriggerHandler.isFirstTime){
        TouristTriggerHandler.isFirstTime = false;
        
        switch on Trigger.operationType {
            when AFTER_INSERT {
                FlightCleanerBatchTriggerHandler.onAfterInsert(Trigger.new);
            }
        }
    }
}