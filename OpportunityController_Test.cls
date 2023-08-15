@IsTest
private class OpportunityController_Test {
    @isTest
    private static void shouldGetOpportunities() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Opportunity opp1 = new Opportunity(
            Name = 'Opportunity 1',
            StageName = 'Closed - Won',
            Amount = 1000,
            AccountId = testAccount.Id,
            CloseDate = Date.TODAY()
        );
        Opportunity opp2 = new Opportunity(
            Name = 'Opportunity 2',
            StageName = 'Closed - Won',
            Amount = 2000,
            AccountId = testAccount.Id,
            CloseDate = Date.TODAY()
        );
        insert new List<Opportunity>{ opp1, opp2 };

        Test.startTest();
        List<Opportunity> opportunities = OpportunityController.getOpportunities(testAccount.Id);
        Test.stopTest();

        System.assertEquals(2, opportunities.size(), 'Expected 2 opportunities related to the account');
        System.assertEquals('Opportunity 1', opportunities[0].Name);
        System.assertEquals(1000, opportunities[0].Amount);
        System.assertEquals('Opportunity 2', opportunities[1].Name);
        System.assertEquals(2000, opportunities[1].Amount);
    
}
}