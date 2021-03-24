trigger validationRulesFlight on Flight__c(before insert) {

    for (Flight__c registration: Trigger.new) {
        Tourist__c touristFlight = TouristManager.getAge(registration);
        Trip__c tripFlight = TripManager.getMinimumAgeStartDate(registration);
        if (touristFlight.Age__c < tripFlight.Minimum_Age__c) {
            registration.addError('Not suitable for age.');
            registration.Tourist__c.addError('Invalid age');
            registration.Trip__c.addError('Less than the minimum age allowed for this trip');
        }
        if (tripFlight.Start_Date__c < Date.Today()) {
            registration.addError('Already flew away.');
        }
    }
}