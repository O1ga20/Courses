public class EmailService {
    
    public static void sendEmailBatch(Map<Id, Integer> touristOnFlight) {
        String recordLink = '';
        List<Tourist__c> tourists = TouristManager.getTourists(touristOnFlight.keySet());
        List<String> emails = MetadataManager.getEmails();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(emails);
        message.setSubject(Constants.EMAIL_SUBJECT_FLIGHT_CLEANER);
        
        for (Tourist__c tourist : tourists) {
            recordLink += (
                '<a href=' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + tourist.Id + '>' 
                + tourist.Name + ' ' + tourist.LastName__c + '</a>' + 
                ' : ' + touristOnFlight.get(tourist.Id) + '<br>'
            );
        }
        message.setHtmlBody(
            'Batch completed. Flights removed. ' +
            'Tourists and the number of remote flights for each tourist: <br>' + 
            recordlink
        );
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {message});
    }
}