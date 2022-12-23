@isTest
private  with sharing class CommunityUserTestClass
 {
    // common method
    public static Integer testUserCreated(Id contactId)
    {
        Test.startTest();
        try
        {
            handleEventClass.createUser(contactId);
        }catch(Exception e){  
        }
        Test.stopTest();
        
        List<User> userList = [SELECT Id FROM User WHERE ContactId = :contactId];
        return userList.size();
    }

    //Testing when user created
    @isTest
    static void  createUsers()
    {
        Account accountFirst = new Account(Name = 'Muskan Jain');
        INSERT accountFirst;
        
        Contact contactFirst = new Contact(FirstName = 'Navya', 
                                           LastName = 'Jain', 
                                           Email = 'navya@gmail.com', 
                                           AccountId = accountFirst.Id);
        INSERT contactFirst;
        //asserting user created or not by checking the size of the user list
        System.assertEquals(1, testUserCreated(contactFirst.Id));
       
    }
    
    //Testing when Email is not provided to Contact
    @isTest
    static void  createUsersWithoutEmailInContact()
    {
        Account accountFirst = new Account(Name = 'Muskan Jain');
        INSERT accountFirst;
        
        Contact contactFirst = new Contact(FirstName = 'Navya', LastName = 'Jain', AccountId = accountFirst.Id);
        INSERT contactFirst;
        
        //asserting user created or not by checking the size of the user list
        System.assertEquals(0, testUserCreated(contactFirst.Id));
    }
    
    //Testing when Account is not provided to Contact
    @isTest
    static void  createUsersWithoutAccountInContact()
    {
        Contact contactFirst = new Contact(FirstName = 'Navya', LastName = 'Jain');
        INSERT contactFirst;
        
        //asserting user created or not by checking the size of the user list
        System.assertEquals(0, testUserCreated(contactFirst.Id));
    }
    
    //Testing when First Name is not provided to Contact
    @isTest
    static void  createUsersWithoutFirstNametInContact()
    {
        Account accountFirst = new Account(Name = 'Muskan Jain');
        INSERT accountFirst;
        
        Contact contactFirst = new Contact(LastName = 'Jain', 
                                           Email = 'navya@gmail.com', 
                                           AccountId = accountFirst.Id);
        INSERT contactFirst;
        
        //asserting user created or not by checking the size of the user list
        System.assertEquals(1, testUserCreated(contactFirst.Id));
    }
    
    //Testing when we try to make a single contact to multiple user
    @isTest
    static void  createUsersdoubleInContact()
    {
        Account accountFirst = new Account(Name = 'Muskan Jain');
        INSERT accountFirst;
        
        Contact contactFirst = new Contact(FirstName = 'Navya',
                                           LastName = 'Jain',
                                           Email = 'navya@gmail.com', 
                                           AccountId = accountFirst.Id);
        INSERT contactFirst;
        
        try
        {
            handleEventClass.createUser(contactFirst.Id);
        }catch(Exception e){  
        }
        List<User> userList = [SELECT Id FROM User WHERE ContactId = :contactFirst.Id];
        //asserting user created or not by checking the size of the user list
        System.assertEquals(1, userList.size());
        
        //asserting user created or not by checking the size of the user list
        System.assertEquals(1, testUserCreated(contactFirst.Id));
    }
}