@isTest
public class ReplacePrimaryQuoteTest {
    @isTest static void PrimaryQuoteTest() {
        Account accMRE = new Account();
        accMRE.Name = 'Red Ribbon Army';
        insert accMRE;
        
        Opportunity oppMRE = new Opportunity();
        oppMRE.Name = 'Replace Primary Quote Test';
        oppMRE.AccountId = accMRE.Id;
        oppMRE.RecordTypeId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Staffing').getRecordTypeId();
        oppMRE.StageName = 'Awareness';
        oppMRE.Competitive_Adj__c = 1.0;
        oppMRE.CloseDate = system.today();
        insert oppMRE;

        Quote existingQuote = new Quote();
        existingQuote.OpportunityId = oppMRE.Id;
        existingQuote.Status = 'Under Review';
        existingQuote.Project_Start_Date__c = system.today();
        existingQuote.Project_End_Date__c = system.today();
        existingQuote.Quoted_Amount__c = 200;
        existingQuote.Cost__c = 100;
        existingQuote.Primary_Quote__c = true;
        insert existingQuote;

        Quote newQuote = new Quote();
        newQuote.OpportunityId = oppMRE.Id;
        newQuote.Status = 'Under Review';
        newQuote.Project_Start_Date__c = system.today();
        newQuote.Project_End_Date__c = system.today();
        newQuote.Quoted_Amount__c = 200;
        newQuote.Cost__c = 100;
        insert newQuote;

        String quoteID = String.valueOf(newQuote.Id);

        ReplacePrimaryQuote.createQuoteFlowInput flowInput = new ReplacePrimaryQuote.createQuoteFlowInput();
        flowInput.quoteID = newQuote.Id;

        ReplacePrimaryQuote.ReplacePrimaryQuote(new List<ReplacePrimaryQuote.createQuoteFlowInput>{flowInput});

    }
}
