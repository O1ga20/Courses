public class TouristService {
    
    @future
    public static void markDuplicates(Set<Id> touristIds) {
        if (touristIds == null || touristIds.isEmpty()) return;
        List<Tourist__c> newTourists = TouristManager.getTourists(touristIds);
        Set<String> lastnames =  new Set<String> ();
        Set<String> emails = new Set<String> ();
        
        for (Tourist__c t : newTourists) {
            lastnames.add(t.LastName__c);
            emails.add(t.Email__c);
        }
        List<Tourist__c> touristsAll = TouristManager.getTheSame(lastnames, emails);
        
        for (Tourist__c touristFirst : newTourists) {
            
            for (Tourist__c touristSecond : touristsAll) {
                Boolean isSameEmail = (touristFirst.Email__c == touristSecond.Email__c);
                Boolean isSameLastName = (touristFirst.LastName__c == touristSecond.LastName__c);
                if (isSameEmail && isSameLastName) {
                    touristFirst.IsDuplicate__c = true;
                }
            }
        }
        update newTourists;
    }
}