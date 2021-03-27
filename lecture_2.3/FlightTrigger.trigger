trigger FlightTrigger on Flight__c(before insert) {
    
    if(FlightTriggerHandler.isFirstTime){
        FlightTriggerHandler.isFirstTime = false;
        
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                FlightTriggerHandler.validationRules(Trigger.New);
            }
        }
    }
}