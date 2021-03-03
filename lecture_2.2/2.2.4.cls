public class TouristService {
	public static void markDuplicates(List < Tourist__c > newTourists) {
		insert newTourists;
		newTourists = [SELECT LastName__c, Email__c, IsDuplicate__c FROM Tourist__c];
		for (Tourist__c tourist1: newTourists) {
			Integer count = 0;
			for (Tourist__c tourist2: newTourists) {
				if (tourist1.Email__c == tourist2.Email__c && tourist1.LastName__c == tourist2.LastName__c) {
					count++;
					if (count > 1) {
						tourist1.IsDuplicate__c = false;
						tourist2.IsDuplicate__c = true;
						update tourist1;
						update tourist2;
					}
				}
			}
		}

	}
}
/*Anonymous
Tourist__c n = new Tourist__c();
n.Name='Ki';
n.Birthdate__c =  Date.newInstance(2010, 12, 9);
n.LastName__c = 'Co';
n.Email__c='romandlickaya@gmail.com';
List<Tourist__c> newTourists= new List<Tourist__c>();
newTourists.add(n);
TouristService.markDuplicates(newTourists);*/