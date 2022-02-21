public class ReplacePrimaryQuote {

    public class createQuoteFlowInput{
        @InvocableVariable public String quoteID;
    }

    @InvocableMethod(label = 'Replace Primary Quote')
    public static void ReplacePrimaryQuote(List<createQuoteFlowInput> quoteList) {

        String quoteID = quoteList[0].quoteID;

        List<Quote> newPrimaryQuote = new List<Quote>([SELECT Id, Name, OpportunityId, Primary_Quote__c FROM Quote WHERE Id = :quoteID]);

        String oppID = newPrimaryQuote[0].OpportunityId;
    
        List<Quote> allOppQuotes = new List<Quote>();
    
        for (Quote q1 : [SELECT Id, OpportunityId, Primary_Quote__c FROM Quote WHERE OpportunityId = :oppId]) {
            q1.Primary_Quote__c = false;
            allOppQuotes.add(q1);
        }
    
        update allOppQuotes;
    
        List<Quote> updatePrimaryQuote = new List<Quote>();
    
        for (Quote q2 : newPrimaryQuote){
            q2.Primary_Quote__c = true;
            updatePrimaryQuote.add(q2);
        }
    
        update updatePrimaryQuote;

    }
}