public class FlightStatus {
    public static void flightStatusDeclined(List < Tourist__c > newTourists) {
        for (Tourist__c touristFlight: newTourists) {
            List < Flight__c > registration = [
                SELECT Status__c,
                Tourist__c
                FROM Flight__c
                WHERE Tourist__c =: touristFlight.Id
            ];
            if (touristFlight.Active__c == false) {
                for (Integer i = 0; i < registration.size(); i++) {
                    registration.get(i).Status__c = 'Declined';
                    update registration;
                }
            }
        }
    }
}