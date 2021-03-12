public class TouristService {
	public static void markDuplicates(List < Tourist__c > newTourists) {
		newTourists = [SELECT LastName__c, Email__c, IsDuplicate__c FROM Tourist__c];
		List < Tourist__c > TouristsDuplicate = new List < Tourist__c > ();

		for (Tourist__c tourist1: newTourists) {
			Integer count = 0;
			for (Tourist__c tourist2: newTourists) {
				if (tourist1.Email__c == tourist2.Email__c && tourist1.LastName__c == tourist2.LastName__c) {
					count++;
					if (count > 1 && tourist1.Id == tourist2.Id) {
						tourist2.IsDuplicate__c = true;
						TouristsDuplicate.add(tourist2);
					}
				}
			}
		}
		update TouristsDuplicate;

	}
}