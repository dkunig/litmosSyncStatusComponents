@isTest
public class litmosSyncControllerTEST {
	@testSetup
    static void setupData() {
        //insert user
        Profile standardUser = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User u1 = new User(
            FirstName = 'Test Sync Controller',
            LastName = 'Test Last',
            Litmos__OriginalId__c = 13488946,
            Litmos__LitmosUserId__c = 'ABCDE',
            Litmos__Litmos_Activated__c = true,
            ProfileId = standardUser.Id,
            isActive = true,
            email='team1@adminuser.com',
            Username='team1@adminuser.com',
            alias='team1',
            TimeZoneSidKey='America/New_York',
            LocaleSidKey='en_US',
            EmailEncodingKey='UTF-8',
            LanguageLocaleKey='en_US'
        );
        insert u1;
        Litmos_Team__c team = new Litmos_Team__c(
        	Name = 'Test Team',
            Litmos_Id__c = 'TEAMTEST'
        );
        insert team;
        Litmos_Team_Member__c member = new Litmos_Team_Member__c(
        	Litmos_Team__c = team.Id,
            Learner__c = u1.Id,
            Litmos_User_Id__c = u1.Litmos__LitmosUserId__c
        );
        insert member;
        insert new Litmos__ModuleNew__c(Name = 'Test module');
        insert new Litmos__Program__c(Name = 'Test Course');
        insert new Litmos__LearningPath__c(Name='Test Learning Path');
        //user sync
        insert new Litmos_Sync_Logs__c(Type__c ='User Create',Status_of_Sync__c ='Success',User__c = u1.Id,Date_Time_of_Sync__c = Date.today());
        //module sync
        insert new Litmos_Sync_Logs__c(Type__c='Module Sync',Status_of_Sync__c ='Success',Module__c = [SELECT Id FROM Litmos__ModuleNew__c LIMIT 1].Id,Date_Time_of_Sync__c = Date.today());
        //path sync
        insert new Litmos_Sync_Logs__c(Type__c ='Learning Path Sync', Status_of_Sync__C = 'Success',Learning_Path__c = [SELECT Id FROM Litmos__LearningPath__c LIMIT 1].Id,Date_Time_of_Sync__c = Date.today());
        //program sync
        insert new Litmos_Sync_Logs__c(Type__c = 'Course Sync', Status_of_Sync__c = 'Success', Course__c = [SELECT Id FROM Litmos__Program__c LIMIT 1].Id,Date_Time_of_Sync__c = Date.today());
    }
    @isTest
    static void runTests() {
        System.assertEquals(1, litmosSyncController.getUserSyncInfo().size());
        System.assertEquals(1, litmosSyncController.getModuleSync().size());
        System.assertEquals(1, litmosSyncController.getLearningPathSync().size());
        System.assertEquals(1, litmosSyncController.getProgramSync().size());
    }
}