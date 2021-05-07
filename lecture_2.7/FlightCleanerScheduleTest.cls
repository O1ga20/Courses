@IsTest
public class FlightCleanerScheduleTest {
    
    @IsTest
    static void testSchedule() {
        TestDataFactory.createFlights();
        String sch = '0 0 0 * * ?';
        String jobRunningTime = '2021-05-08 00:00:00';
        Test.startTest();
        FlightCleanerSchedule cleaner = new FlightCleanerSchedule();
        String jobID = System.schedule('Cleaning flights', sch, cleaner);
        Test.stopTest();
        system.assertEquals(1, [SELECT count() FROM CronTrigger], 'A job should be scheduled');
    }
}