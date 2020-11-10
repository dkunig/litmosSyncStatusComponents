public class litmosSyncLogs {
	//record sync logs
	//successful sync
    public static void logUserSuccess(List<User> users) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(User u : users) {
            logs.add(new Litmos_Sync_Logs__c(User__c = u.Id,Type__c = 'User Create', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Success'));
        }
        insert logs;
    }
    //sync failure
    //potentially send email or alert of some kind
    public static void logUserErrors(List<User> users, Map<String,String> errors) {
        List<Litmos_Sync_Logs__c> errorLogs = new List<Litmos_Sync_Logs__c>();
        for(User u : users) {
            errorLogs.add(new Litmos_Sync_Logs__c(User__c = u.Id, Type__c = 'User Create', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c = 'Error',Sync_Issues__c = errors.get(u.Id)));
        }
		insert errorLogs;
    }
   public static void logModuleSuccess(List<Litmos__ModuleNew__c> modules) {
       List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
       for(Litmos__ModuleNew__c module : modules) {
            logs.add(new Litmos_Sync_Logs__c(Module__c = module.Id,Type__c = 'Module Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Success'));
       }
       insert logs;
   }
   public static void logModuleErrors(List<Litmos__ModuleNew__c> modules, Map<String,String> errors) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos__ModuleNew__c module : modules) {
                logs.add(new Litmos_Sync_Logs__c(Module__c = module.Id,Type__c = 'Module Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Error',Sync_Issues__c = errors.get(module.Id)));
        }
        insert logs;   
   }

   public static void logCourseSuccess(List<Litmos__Program__c> programs) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos__Program__c program : programs) {
            logs.add(new Litmos_Sync_Logs__c(Course__c = program.Id,Type__c = 'Course Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Success'));
        }
        insert logs;
   }
   public static void logCourseErrors(List<Litmos__Program__c> programs, Map<String,String> errors) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos__Program__c program : programs) {
            logs.add(new Litmos_Sync_Logs__c(Course__c = program.Id,Type__c = 'Course Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Error',Sync_Issues__c = errors.get(program.Id)));
        }
        insert logs;
   }

   public static void logPathSucccess(List<Litmos__LearningPath__c> paths) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos__LearningPath__c path : paths) {
            logs.add(new Litmos_Sync_Logs__c(Learning_Path__c = path.Id,Type__c = 'Learning Path Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Success'));
        }
        insert logs;
   }
   public static void logPathErrors(List<Litmos__LearningPath__c> paths, Map<String,String> errors) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos__LearningPath__c path : paths) {
            logs.add(new Litmos_Sync_Logs__c(Learning_Path__c = path.Id,Type__c = 'Learning Path Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Error', Sync_Issues__c = errors.get(path.Id)));
        }
        insert logs;
   }
    public static void logTeamsSuccess(List<Litmos_Team__c> teams) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos_Team__c team : teams) {
            logs.add(new Litmos_Sync_Logs__c(Litmos_Team__c = team.Id, Type__c = 'Team', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c = 'Success'));
        }
        insert logs;
    }
    public static void logTeamsErrors(List<Litmos_Team__c> teams, Map<String,String> errors) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos_Team__c team : teams) {
            logs.add(new Litmos_Sync_Logs__c(Litmos_Team__c = team.Id, Type__c = 'Team', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c = 'Error', Sync_Issues__c = errors.get(team.Id)));
        }
        insert logs;
    }
    public static void logTeamMemberSuccess(List<Litmos_Team_Member__c> members) {
       	List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos_Team_Member__c member : members) {
            logs.add(new Litmos_Sync_Logs__c(Litmos_Team_Member__c = member.Id, Type__c = 'Team Member', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c = 'Success'));
        }
        insert logs;
    }
    public static void logTeamMemberErrors(List<Litmos_Team_Member__c> members, Map<String,String>errors) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos_Team_Member__c member : members) {
            logs.add(new Litmos_Sync_Logs__c(Litmos_Team_Member__c = member.Id, Type__c = 'Team Member', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c = 'Error', Sync_Issues__c = errors.get(member.Id)));
        }
        insert logs;
    }
    public static void logTeamMemberErrors(String error, String TeamId) {
        Litmos_Sync_Logs__c log = new Litmos_Sync_Logs__c();
        log.Type__c = 'Team Member';
        log.Date_Time_of_Sync__c = Date.today();
        log.Status_of_Sync__c = 'Error';
        log.Sync_Issues__c = error;
        log.Litmos_Team__c = TeamId;
        insert log;
        
    }
}