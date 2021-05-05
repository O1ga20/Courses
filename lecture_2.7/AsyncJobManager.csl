public class AsyncJobManager {
    
    public static List<AsyncApexJob> getJobs(Set<Id> asyncApexJobIds) {
        List<AsyncApexJob> jobs = [
            SELECT Id, 
            ApexClass.Name 
            FROM AsyncApexJob 
            WHERE Id IN :asyncApexJobIds
        ];
        return jobs;        
    }
}