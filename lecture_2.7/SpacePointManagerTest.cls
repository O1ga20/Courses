@IsTest
public class SpacePointManagerTest {
    
    @IsTest
    static void testGetPoints() {
        TestDataFactory.createSpacePoint();
        List<Space_Point__c> points = SpacePointManager.getPoints();
        System.assertEquals(1, points.size());
    }
}