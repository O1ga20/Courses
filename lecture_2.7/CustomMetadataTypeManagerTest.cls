@IsTest
public class CustomMetadataTypeManagerTest {
    
    @IsTest
    static void testGetRecords() {
        String customMetadataTypeName = 'Send_Email__mdt';
        List<SObject> records = CustomMetadataTypeManager.getRecords(customMetadataTypeName);
        System.assertEquals(1, records.size());
    }
}