public class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) return;
        Set<String> lastnames =  new Set<String> ();
        Set<String> emails = new Set<String> ();
        
        for (Tourist__c t : newTourists) {
            lastnames.add(t.LastName__c);
            emails.add(t.Email__c);
        }
        List<Tourist__c> touristsAll = TouristManager.getTheSame(lastnames, emails);
        
        for (Tourist__c touristFirst : newTourists) {
            
            for (Tourist__c touristSecond : touristsAll) {
                Boolean isEmail = (touristFirst.Email__c == touristSecond.Email__c);
                Boolean isLastName = (touristFirst.LastName__c == touristSecond.LastName__c);
                if (isEmail && isLastName) {
                    touristFirst.IsDuplicate__c = true;
                }
            }
        }
    }
}