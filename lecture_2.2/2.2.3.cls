public class TouristManager {
	//tourists (name, age) whose name contains John
	public static List < Tourist__c > TouristJohn(String filter1) {
		List < Tourist__c > John = [SELECT Name, Age__c FROM
		Tourist__c WHERE Name Like: filter1];
		return John;
	}

	//tourists (name, age) with the age of 20, 22, 24 years
	public static List < Tourist__c > TouristAge202224(Integer Age1, Integer Age2, Integer Age3) {
		List < Tourist__c > Age202224 = [SELECT Name, Age__c FROM Tourist__c
		WHERE Age__c = :Age1
		or Age__c = :Age2
		or Age__c = :Age3];
		return Age202224;
	}

	//tourists (name, age) who started their flight in 2020
	public static List < Tourist__c > TouristStart2020(Integer year) {
		List < Tourist__c > Start2020 = [SELECT Name, Age__c FROM Tourist__c
		WHERE Id IN(SELECT Tourist__c FROM Flight__c
		WHERE CALENDAR_YEAR(Trip__r.Start_Date__c) = :year)];
		return Start2020;
	}

	//tourists (name, age) with a list of flights (start date, name)
	public static List < Tourist__c > TouristListTrip() {
		List < Tourist__c > ListTrip = [SELECT Name, Age__c, (SELECT Trip__r.Start_Date__c, Trip__r.Name FROM Flights__r)
		FROM Tourist__c];
		return ListTrip;
	}

	//tourists (name, age) who have not checked in for any flight
	public static List < Tourist__c > TouristNotRegistered() {
		List < Tourist__c > NotRegistered = [SELECT Name, Age__c FROM Tourist__c
		WHERE Id NOT IN(SELECT Tourist__c FROM Flight__c)];
		return NotRegistered;
	}
}