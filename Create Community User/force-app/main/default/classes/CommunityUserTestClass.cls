@isTest
private  with sharing class CommunityUserTestClass {
    
    @isTest
    static void  createUsers()
    {
        Account accountFirst = new Account(Name = 'Muskan Jain');
        INSERT accountFirst;
        
        Contact contactFirst = new Contact(FirstName = 'Navya', LastName = 'Jain', Email = 'navya@gmail.com', AccountId = accountFirst.Id);
        INSERT contactFirst;
        
        Test.startTest();
        try
        {
            handleEventClass.createUser(contactFirst.Id);
        }
        catch(Exception e)
        {  
        }
        Test.stopTest();
        
        List<User> userList = [SELECT id FROM User WHERE contactId =: contactFirst.Id];
        System.assertEquals(1, userList.size() );
    }
    
    @isTest
    static void  createUsersWithoutEmailInContact()
    {
        Account accountFirst = new Account(Name = 'Muskan Jain');
        INSERT accountFirst;
        
        Contact contactFirst = new Contact(FirstName = 'Navya', LastName = 'Jain', AccountId = accountFirst.Id);
        INSERT contactFirst;
        
        Test.startTest();
        try
        {
            handleEventClass.createUser(contactFirst.Id);
        }
        catch(Exception e)
        {  
        }
        Test.stopTest();
        
        List<User> userList = [SELECT Id FROM User WHERE ContactId =: contactFirst.Id];
        System.assertEquals(0, userList.size() );
    }
    
    @isTest
    static void  createUsersWithoutAccountInContact()
    {
        Contact contactFirst = new Contact(FirstName = 'Navya', LastName = 'Jain');
        INSERT contactFirst;
        
        Test.startTest();
        try
        {
            handleEventClass.createUser(contactFirst.Id);
        }
        catch(Exception e)
        {  
        }
        Test.stopTest();
        
        List<User> userList = [SELECT id FROM User WHERE contactId =: contactFirst.Id];
        System.assertEquals(0, userList.size() );
    }
    
    @isTest
    static void  createUsersWithoutFirstNametInContact()
    {
        Account accountFirst = new Account(Name = 'Muskan Jain');
        INSERT accountFirst;
        
        Contact contactFirst = new Contact(LastName = 'Jain', Email = 'navya@gmail.com', AccountId = accountFirst.Id);
        INSERT contactFirst;
        
        Test.startTest();
        try
        {
            User u = handleEventClass.createUser(contactFirst.Id);
        }
        catch(Exception e)
        {  
        }
        Test.stopTest();
        
        List<User> userList = [SELECT id FROM User WHERE contactId =: contactFirst.Id];
        System.assertEquals(1, userList.size() );
    }
    
    @isTest
    static void  createUsersdoubleInContact()
    {
        Account accountFirst = new Account(Name = 'Muskan Jain');
        INSERT accountFirst;
        
        Contact contactFirst = new Contact(FirstName = 'Navya', LastName = 'Jain', Email = 'navya@gmail.com', AccountId = accountFirst.Id);
        INSERT contactFirst;
        
        try
        {
            handleEventClass.createUser(contactFirst.Id);
        }
        catch(Exception e)
        {  
        }
        List<User> userList = [SELECT id FROM User WHERE contactId =: contactFirst.Id];
        System.assertEquals(1, userList.size() );
        
        Test.startTest();
        try
        {
            handleEventClass.createUser(contactFirst.Id);
        }
        catch(Exception e)
        {  
        }
        Test.stopTest();
        
        List<User> userList1 = [SELECT id FROM User WHERE contactId =: contactFirst.Id];
        System.assertEquals(1, userList1.size() );
    }
}