trigger validationRulesFlight on Flight__c(before insert) {

    for (Flight__c registration: Trigger.new) {
        Tourist__c touristFlight = [
            SELECT Age__c
            FROM Tourist__c
            WHERE Id =: registration.Tourist__c
        ];
        Trip__c tripFlight = [
            SELECT Minimum_Age__c,
            Start_Date__c
            FROM Trip__c
            WHERE Id =: registration.Trip__c
        ];

        if (touristFlight.Age__c < tripFlight.Minimum_Age__c) {
            registration.addError('Not suitable for age.');
            registration.Tourist__c.addError('Invalid age');
            registration.Trip__c.addError('Less than the minimum age allowed for this trip');
        }
        if (registration.Status__c == 'Past' || tripFlight.Start_Date__c < Date.Today()) {
            registration.addError('Already flew away.');
        }

    }

}