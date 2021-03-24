public class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) return;
        List<Tourist__c> touristsAll = TouristManager.getLastnameEmailIsDuplicate();
        List<Tourist__c> touristsDuplicate = new List<Tourist__c> ();
        
        for (Tourist__c touristFirst : newTourists) {
            Integer count = 0;
            
            for (Tourist__c touristSecond : touristsAll) {
                Boolean isEmail = (touristFirst.Email__c == touristSecond.Email__c);
                Boolean isLastName = (touristFirst.LastName__c == touristSecond.LastName__c);
                if (isEmail && isLastName) {
                    count++;
                    if (count > 1) {
                        touristFirst.IsDuplicate__c = true;
                        touristsDuplicate.add(touristFirst);
                    }
                }
            }
        }
        //update touristsDuplicate; //for a trigger (befor insert) this line is not needed
    }
}