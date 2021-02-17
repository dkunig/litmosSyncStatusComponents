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

   public static void logCourseSuccess(Set<Id> programs) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Id program : programs) {
            logs.add(new Litmos_Sync_Logs__c(Course__c = program,Type__c = 'Course Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Success'));
        }
        insert logs;
   }
   public static void logCourseErrors(Set<Id> programs, Map<Id,String> errors) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Id program : programs) {
            logs.add(new Litmos_Sync_Logs__c(Course__c = program,Type__c = 'Course Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Error',Sync_Issues__c = errors.get(program)));
        }
        insert logs;
   }

   public static void logPathSucccess(Set<Id> paths) {
    List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
    for(Id path : paths) {
        logs.add(new Litmos_Sync_Logs__c(Learning_Path__c = path,Type__c = 'Learning Path Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Success'));
    }
    insert logs;
}
public static void logPathErrors(Set<Id> paths, Map<Id,String> errors) {
    List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
    for(Id path : paths) {
        logs.add(new Litmos_Sync_Logs__c(Learning_Path__c = path,Type__c = 'Learning Path Sync', Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Error', Sync_Issues__c = errors.get(path)));
    }
        insert logs;
   }
    public static void logPathCourseSuccess(List<Litmos__LearningPathProgram__c> pathPrograms) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(Litmos__LearningPathProgram__c pathProg : pathPrograms) {
            logs.add(new Litmos_Sync_Logs__c(Learning_Path__c = pathProg.Litmos__LearningPathId__c,Course__c = pathProg.Litmos__ProgramID__c, Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c ='Success',Type__c='Learning Path Program'));
        }
        insert logs;
    }
    public static void logPathCourseError(List<String> errors) {
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(String e : errors) {
            logs.add(new Litmos_Sync_Logs__c(Date_Time_of_Sync__c = Date.today(), Status_of_Sync__c='Error',Type__c='Learning Path Program',Sync_Issues__c = e));
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
        System.debug('inside success log');
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        if(members.size() > 50) {
            logs.add(new Litmos_Sync_Logs__c(Type__c = 'Bulk Team Member', Date_Time_of_Sync__c = DateTime.now(), Status_of_Sync__c = 'Success',Sync_Information__c=members.size() + ' team members inserted'));
        } else {
            for(Litmos_Team_Member__c member : members) {
            logs.add(new Litmos_Sync_Logs__c(Litmos_Team_Member__c = member.Id, Type__c = 'Team Member', Date_Time_of_Sync__c = Datetime.now(), Status_of_Sync__c = 'Success'));
        	}
        }
        insert logs;
    }
    public static void logTeamMemberErrors(List<String> errors) {
        //no known team or member; generic error
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(String e : errors) {
            System.debug('sync error: ' + e);
            logs.add(new Litmos_Sync_Logs__c(Type__c = 'Team Member',Date_Time_of_Sync__c = Datetime.now(), Status_of_Sync__c = 'Error', Sync_Issues__c = e));
        }
        insert logs;
    }
    public static void logTeamMemberErrors(Map<String,String> errors) {
        //errors:
            // keySet: Litmos_Team__c Ids
            // values: error message
        List<Litmos_Sync_Logs__c> logs = new List<Litmos_Sync_Logs__c>();
        for(String team : errors.keySet()) {
            logs.add(new Litmos_Sync_Logs__c(
            	Type__c='Team Member',
                Date_Time_of_Sync__c = Datetime.now(),
                Status_of_Sync__c = 'Error',
                Sync_Issues__c = errors.get(team),
                Litmos_Team__c = team
            ));
        }
        insert logs;
        
    }
    public static void logTeamMemberDeletions(Integer numDeletions, Id teamId) {
        Litmos_Sync_Logs__c log = new Litmos_Sync_Logs__c(
        	Litmos_Team__c = teamId,
            Type__c = 'Team Member',
            Date_Time_of_Sync__c = Datetime.now(),
            Status_of_Sync__c = 'Success',
            Sync_Information__c = numDeletions + ' team members deleted from team: ' + [SELECT Name From Litmos_Team__c WHERE Id = :teamId].Name
        );
        insert log;
    }
}