trigger TouristTrigger on Tourist__c(after insert, after update) {
	switch on Trigger.operationType {
		when AFTER_INSERT {
			TouristService.markDuplicates(Trigger.New);
		}
		when AFTER_UPDATE {
			for (Tourist__c touristFlight: Trigger.New) {
				List < Flight__c > registration = [SELECT Status__c, Tourist__c FROM Flight__c WHERE Tourist__c = :touristFlight.Id];
				if (touristFlight.Active__c == false) {
					for (Integer i = 0; i < registration.size(); i++) {
						registration.get(i).Status__c = 'Declined';
						update registration;
					}

				}
			}
		}

	}
}