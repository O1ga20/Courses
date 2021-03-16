trigger touristTrigger on Tourist__c(after insert, after update) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            TouristService.markDuplicates(Trigger.New);
        }
        when AFTER_UPDATE {
            FlightStatus.flightStatusDeclined(Trigger.New);
        }

    }
}