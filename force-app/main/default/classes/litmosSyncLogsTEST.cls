@isTest
public class litmosSyncLogsTEST {
	@testSetup
    public static void testData() {
        Profile standardUser = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        List<User> users = new List<User>();
        User u1 = new User(
            FirstName = 'Test Member Updates',
            LastName = 'Sync Logs',
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
        User u2 = new User(
        	FirstName = 'Test Member Updates',
            LastName = 'Sync Logs',
            Litmos__OriginalId__c = 123456789,
            Litmos__LitmosUserId__c = 'FGHIJ',
            Litmos__Litmos_Activated__c = true,
            ProfileId = standardUser.Id,
            isActive=true,
            email='onteam@onteam.com',
            Username='onteam@onteam.com',
            alias='ontea',
            TimeZoneSidKey='America/New_York',
            LocaleSidKey='en_US',
            EmailEncodingKey='UTF-8',
            LanguageLocaleKey='en_US'
        );
        users.add(u1);
        users.add(u2);
        insert users;
        insert new Litmos__ModuleNew__c(Name = 'Test module');
        insert new Litmos__Program__c(Name = 'Test Course');
        insert new Litmos__LearningPath__c(Name='Test Learning Path');
        Litmos_Team__c team = new Litmos_Team__c(Name = 'Test Team Sync Logs',Litmos_Id__c = 'ABCDE');
        insert team;
        insert new Litmos_Team_Member__c(Litmos_Team__c = team.Id,Learner__c=u1.Id);
    }
    @isTest
    public static void testUserSyncLog() {
        Map<Id,User> users = new Map<Id,User>([SELECT Id FROM User WHERE LastName = 'Sync Logs']);
        Test.startTest();
        litmosSyncLogs.logUserSuccess(users.values());
        Test.stopTest();
        System.assertEquals(2, [SELECT count() FROM Litmos_Sync_Logs__c WHERE User__c IN : users.keySet()]);
    }
    @isTest
    public static void testUserSyncError() {
        Map<Id,User> users = new Map<Id,User>([SELECT Id FROM User WHERE LastName = 'Sync Logs']);
        Map<String,String> errors = new Map<String,String>();
        for(Id u : users.keySet()) {
            errors.put(u, 'Test Error Message');
        }
        Test.startTest();
        litmosSyncLogs.logUserErrors(users.values(), errors);
        Test.stopTest();
        System.assertEquals(2, [SELECT count() FROM Litmos_Sync_Logs__c WHERE Status_of_Sync__c = 'Error' AND Type__c = 'User Create']);
    }
    @isTest
    public static void testModuleSyncLog() {
		Map<Id,Litmos__ModuleNew__c> moduleMap = new Map<Id,Litmos__ModuleNew__c>([SELECT Id FROM Litmos__ModuleNew__c]);
        Test.startTest();
        litmosSyncLogs.logModuleSuccess(moduleMap.values());
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c = 'Module Sync' AND Module__c IN :moduleMap.keySet() AND Status_of_Sync__c = 'Success']);
    }
    @isTest static void testModuleSyncError() {
        Map<Id,Litmos__ModuleNew__c> moduleMap = new Map<Id,Litmos__ModuleNew__c>([SELECT Id FROM Litmos__ModuleNew__c]);
        Map<String,String> errors = new Map<String,String>();
        for(Id mod : moduleMap.keySet()) {
            errors.put(mod, 'Test Error Message');
        }
        Test.startTest();
        litmosSyncLogs.logModuleErrors(moduleMap.values(),errors);
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c = 'Module Sync' AND Module__c IN :moduleMap.keySet() AND Status_of_Sync__c = 'Error']);
    }
    @isTest static void testCourseSyncLog() {
        Map<Id,Litmos__Program__c> courseMap = new Map<Id,Litmos__Program__c>([SELECT Id FROM Litmos__Program__c]);
        Test.startTest();
        litmosSyncLogs.logCourseSuccess(courseMap.values());
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c = 'Course Sync' AND Course__c IN : courseMap.keySet() AND Status_of_Sync__c = 'Success']);
    }
    @isTest static void testCourseSyncError() {
        Map<Id,Litmos__Program__c> courseMap = new Map<Id,Litmos__Program__c>([SELECT Id FROM Litmos__Program__c]);
        //force database saveresult error
        Map<String,String> errors = new Map<String,String>();
        for(Id c : courseMap.keySet()) {
            errors.put(c, 'My Error');
        }
        Test.startTest();
        litmosSyncLogs.logCourseErrors(courseMap.values(),errors);
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c = 'Course Sync' AND Course__c IN : courseMap.keySet() AND Status_of_Sync__c = 'Error']);
    }
    @isTest static void testPathSync() {
        Map<Id,Litmos__LearningPath__c> paths = new Map<Id,Litmos__LearningPath__c>([SELECT Id FROM Litmos__LearningPath__c]);
        Test.startTest();
        litmosSyncLogs.logPathSucccess(paths.values());
        Test.stopTest();
        System.assertEquals(1,[SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c = 'Learning Path Sync' AND Status_of_Sync__c = 'Success' AND Learning_Path__c IN :paths.keySet()]);
    }
    @isTest static void testPathErrors() {
        Map<Id,Litmos__LearningPath__c> paths = new Map<Id,Litmos__LearningPath__c>([SELECT Id FROM Litmos__LearningPath__c]);
        Map<String,String> errors = new Map<String,String>();
        for(Id p : paths.keySet()) {
            errors.put(p, 'My Error');
        }
        Test.startTest();
        litmosSyncLogs.logPathErrors(paths.values(),errors);
        Test.stopTest();
        System.assertEquals(1,[SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c = 'Learning Path Sync' AND Status_of_Sync__c = 'Error' AND Learning_Path__c IN :paths.keySet()]);
    }
    @isTest static void testTeamsSync() {
        Map<Id,Litmos_Team__c> teams = new Map<Id,Litmos_Team__c>([SELECT Id FROM Litmos_Team__c]);
        test.startTest();
        litmosSyncLogs.logTeamsSuccess(teams.values());
        Test.stopTest();
        System.assertEquals(1,[SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c = 'Team' AND Status_of_Sync__c = 'Success' AND Litmos_Team__c IN : teams.keySet()]);
    }
    @isTest static void testTeamsErrors() {
        Map<Id,Litmos_Team__c> teams = new Map<Id,Litmos_Team__c>([SELECT Id FROM Litmos_Team__c]);
        Map<String,String> errors = new Map<String,String>();
        for(Id t : teams.keySet()) {
            errors.put(t,'My Error');
        }
        Test.startTest();
        litmosSyncLogs.logTeamsErrors(teams.values(), errors);
        Test.stopTest();
        System.assertEquals(1,[SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c='Team' AND Status_of_Sync__c = 'Error' AND Litmos_Team__c IN :teams.keySet()]);
    }
    @isTest static void testTeamMemberSync() {
        Map<Id,Litmos_Team_Member__c> members = new Map<Id,Litmos_Team_Member__c>([SELECT Id FROM Litmos_Team_Member__c]);
        Test.startTest();
        litmosSyncLogs.logTeamMemberSuccess(members.values());
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c ='Team Member' AND Status_of_Sync__c ='Success' AND Litmos_Team_Member__c IN :members.keySet()]);
    }
    @isTest static void testTeamMemberErrors() {
        Map<Id,Litmos_Team_Member__c> members = new Map<Id,Litmos_Team_Member__c>([SELECT Id FROM Litmos_Team_Member__c]);
        Litmos_Team__c team = [SELECT Id FROM Litmos_Team__c LIMIT 1];
        Map<String,String> errors = new Map<String,String>();
        for(Id m : members.keySet()) {
            errors.put(m, 'My Error');
        }
        Test.startTest();
        litmosSyncLogs.logTeamMemberErrors(members.values(), errors);
        litmosSyncLogs.logTeamMemberErrors('My Error', team.Id);
        Test.stopTest();
        System.assertEquals(2, [SELECT count() FROM Litmos_Sync_Logs__c WHERE Type__c = 'Team Member' AND Status_of_Sync__c = 'Error']);
    }
        
}