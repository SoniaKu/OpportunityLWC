@isTest
public class ContactDuplicatesBatch_Test {

    @testSetup
    static void setup() {
        
        List<Contact> contactsToInsert = new List<Contact>();

        Contact sampleContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'johndoe@example.com'
        );

        for (Integer i = 0; i < 5; i++) {
            contactsToInsert.add(sampleContact.clone());
        }
        insert contactsToInsert;
    }
    @isTest static void shouldDeleteDuplicates() {
        Test.startTest();
        Database.executeBatch(new ContactDuplicatesBatch());
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM contact WHERE Email = 'johndoe@example.com']);
    }
}