public with sharing class handleEventClass 
{
       public static void setPermission(String name)
    {
        try
        {
            User user = [SELECT ID FROM USER WHERE Name =: name];
            Id permessionSetId = [select id, name, profileid from permissionSet where name = 'My_Community_Permission_Set1'].Id ;
     
            //Assign Permission Set to newly created user
            PermissionSetAssignment  permissionSetToUser = new PermissionSetAssignment(PermissionSetId = permessionSetId, AssigneeId = user.Id);
            INSERT permissionSetToUser;
        }
        catch(DmlException e)
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
     
    @AuraEnabled
    public static  User createUser(Id recordId)
    {
        //to fetch profile id
        Profile profile= [Select Id from Profile where name = 'User Community'];
           
        //To fetch contact detail from contact Id  
        Contact contact=[SELECT ID,FirstName,LastName,Email FROM contact where Id =: recordId];
     
        //to create user for contact
        User userCreate =new User(
            UserName = contact.Email+ System.now().millisecond(),
            FirstName = contact.FirstName,
            LastName = contact.LastName,
            Alias = 'test123',
            email = contact.Email,
            ContactId = contact.Id,
            ProfileId = profile.Id,
            EmailEncodingKey = 'UTF-8',
            CommunityNickname = 'test123'+System.now().millisecond(),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US'
        );
        try
        {
            INSERT userCreate;
            setPermission(userCreate.FirstName + ' ' +userCreate.LastName);
            return userCreate;
        }
     
        catch (Exception e)
        {
            throw new AuraHandledException(e.getMessage());
        }
     
        }

}