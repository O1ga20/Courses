public class SpacePointManager {
    
    public static List<Space_Point__c> getPoints() {
        List<Space_Point__c> points = [
            SELECT Latitude__c,
            Longitude__c
            FROM Space_Point__c
        ];
        return points;
    }
}