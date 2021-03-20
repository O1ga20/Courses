public class AutomaticFillingTrip {

    @InvocableMethod(label = 'Automatic tourist registration'
        description = 'Registration of free tourists'
        category = 'Trip__c')
    public static void fillingTrip(List <Trip__c> trip) {

        List<Tourist__c> freeTourists = TouristManager.getNotRegisteredOnTheTrip();
        trip = [
            SELECT Id,
            Name,
            Minimum_Age__c,
            (SELECT Id, Tourist__r.Name, Tourist__r.Age__c FROM Flights__r)
            FROM Trip__c
        ];
        List<Tourist__c> filteredTourists = new List<Tourist__c> ();
        List<Flight__c> registerAtourist = new List<Flight__c> ();

        for (Tourist__c touristFirst: freeTourists) {

            for (Trip__c tripsFirst: trip) {
                if (touristFirst.Age__c > tripsFirst.Minimum_Age__c && !filteredTourists.contains(touristFirst)) {
                    filteredTourists.add(touristFirst);
                    Flight__c newRegister = new Flight__c();
                    newRegister.Tourist__c = touristFirst.Id;
                    newRegister.Trip__c = tripsFirst.Id;
                    newRegister.Status__c = 'Accepted';
                    registerAtourist.add(newRegister);
                }
            }
        }
        insert registerAtourist;
    }
}