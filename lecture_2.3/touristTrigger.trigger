trigger TouristTrigger on Tourist__c(before insert, after update) {
    
    if(TouristTriggerHandler.isFirstTime){
        TouristTriggerHandler.isFirstTime = false;
        
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                TouristTriggerHandler.onBeforeInsert(Trigger.New);
            }
            when AFTER_UPDATE {
                TouristTriggerHandler.onAfterUpdate(Trigger.New);
            }
        }
    }
}