public class MetadataManager {
    
    public static List<String> getEmails() {
        List<Send_Email__mdt> mailsMetadata = [
            SELECT Id, 
            Email__c
            FROM Send_Email__mdt
        ];
        List<String> emails = new List<String>();
        
        for (Send_Email__mdt email : mailsMetadata) {
            emails.add(email.Email__c);
        }
        return emails;
    }
}