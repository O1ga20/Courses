public class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {
        if (!newTourists.isEmpty() && newTourists!=null ) {
            newTourists = [
                SELECT LastName__c,
                Email__c,
                IsDuplicate__c
                FROM Tourist__c
            ];
            List<Tourist__c> touristsDuplicate = new List<Tourist__c> ();
            
            for (Tourist__c touristFirst: newTourists) {
                Integer count = 0;
                
                for (Tourist__c touristSecond: newTourists) {
                    if (touristFirst.Email__c == touristSecond.Email__c && touristFirst.LastName__c == touristSecond.LastName__c) {
                        count++;
                        if (count > 1 && touristFirst.Id == touristSecond.Id) {
                            touristSecond.IsDuplicate__c = true;
                            touristsDuplicate.add(touristSecond);
                        }
                    }
                }
            }
            update touristsDuplicate;
        }
    }
}