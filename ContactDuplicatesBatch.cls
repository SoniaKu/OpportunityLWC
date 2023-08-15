public class ContactDuplicatesBatch implements
    Database.Batchable<sObject>, Database.Stateful {
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Email FROM Contact'
        );
    }
    public void execute(Database.BatchableContext bc, List<Contact> scope){
        Set<String> existingEmails = new Set<String>();
        List<Contact> duplicatedContactsToDelete = new List<Contact>();
        for (Contact contact : scope) {
            if (!existingEmails.contains(contact.Email)) {
                existingEmails.add(contact.Email);
            } else {
                duplicatedContactsToDelete.add(contact);
                recordsProcessed = recordsProcessed + 1;            
                }
        }
        delete duplicatedContactsToDelete;
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed.');
    }
}