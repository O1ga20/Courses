trigger touristTrigger on Tourist__c(after insert) {
	TouristService.markDuplicates(Trigger.New);
}

