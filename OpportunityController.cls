public with sharing class OpportunityController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId) {
        return [SELECT Id, Name, Amount, StageName, CloseDate FROM Opportunity WHERE AccountId = :accountId];
    }
}
