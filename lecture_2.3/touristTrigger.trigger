trigger touristTrigger on Tourist__c(before insert, after update) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            TouristService.markDuplicates(Trigger.New);
        }
        when AFTER_UPDATE {
            FlightStatus.flightStatusDeclined(Trigger.New);
        }

    }
}