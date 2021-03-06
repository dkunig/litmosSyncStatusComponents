public class litmosSyncController {
	@AuraEnabled(cacheable=true)
    public static List<Litmos_Sync_Logs__c> getUserSyncInfo() {
        return [SELECT Id,Name,User__r.Name,Date_Time_of_Sync__c,User__r.Litmos__LitmosUserId__c,Status_of_Sync__c,Sync_Issues__c FROM Litmos_Sync_Logs__c WHERE Type__c = 'User Create'];
    }
    @AuraEnabled(cacheable=true)
    public static List<Litmos_Sync_Logs__c> getModuleSync() {
        return [SELECT Id,Name,Date_Time_of_Sync__c,Status_of_Sync__c,Sync_Issues__c,Module__r.Name FROM Litmos_Sync_Logs__c WHERE Type__c = 'Module Sync'];
    }
    @AuraEnabled(cacheable=true)
    public static List<Litmos_Sync_Logs__c> getProgramSync() {
        return [SELECT Id,Name,Date_Time_of_Sync__c,Status_of_Sync__c,Sync_Issues__c,Course__r.Name FROM Litmos_Sync_Logs__c WHERE Type__c = 'Course Sync'];
    }
    @AuraEnabled(cacheable=true) 
    public static List<Litmos_Sync_Logs__c> getLearningPathSync() {
        return [SELECT Id,Name,Date_Time_of_Sync__c,Status_of_Sync__c,Sync_Issues__c,Learning_Path__r.Name FROM Litmos_Sync_Logs__c WHERE Type__c = 'Learning Path Sync'];
    }

}