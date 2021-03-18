public class AutomaticFillingTrip {

    @InvocableMethod(label = 'Automatic tourist registration'
        description = 'Registration of free tourists'
        category = 'Trip__c')
    public static void fillingTrip(List<Trip__c> trip) {

        List<Tourist__c> freeTourists = TouristManager.touristNotRegistered();
        trip = [
            SELECT Id,
            Name,
            Minimum_Age__c,
            (SELECT Id, Tourist__r.Name, Tourist__r.Age__c FROM Flights__r)
            FROM Trip__c
        ];
        List<Tourist__c> filteredTourists = new List<Tourist__c> ();
        List<Flight__c> registerAtourist = new List<Flight__c> ();

        for (Tourist__c tourist1: freeTourists) {
            for (Trip__c trips1: trip) {
                if (tourist1.Age__c > trips1.Minimum_Age__c && !filteredTourists.contains(tourist1)) {
                    filteredTourists.add(tourist1);
                    Flight__c newRegister = new Flight__c();
                    newRegister.Tourist__c = tourist1.Id;
                    newRegister.Trip__c = trips1.Id;
                    newRegister.Status__c = 'Accepted';
                    registerAtourist.add(newRegister);
                }
            }
        }
        insert registerAtourist;
    }
}