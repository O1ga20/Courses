trigger TouristTrigger on Tourist__c(after insert) {
	TouristService.markDuplicates(Trigger.New);
}
//taking into account that there is no insert in the markDuplicates method
