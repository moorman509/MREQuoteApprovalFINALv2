trigger CreateNewQuoteTrigger on Quote (before insert) {

    List<Quote> quoteList = new List<Quote>();
    for (Quote q1 : Trigger.New){
        quoteList.add(q1);
    }

    String oppId = quoteList[0].OpportunityId;

    List<Quote> existingQuoteList = [SELECT Id, Name, Status, Primary_Quote__c FROM Quote WHERE OpportunityId = :oppId];

    List<Quote> quoteToUpdateList = new List<Quote>();

    String approvingQuoteID;
    String approvingQuoteName;

    if(quoteList[0].Primary_Quote__c == true){

        for(Quote q2 : existingQuoteList){
            q2.Primary_Quote__c = FALSE;
            
            //added to handle the event where someone creates a new quote when one is waiting for approval
            if(q2.Status == 'Submitted for Approval') {
                approvingQuoteID = q2.Id;
                approvingQuoteName = q2.Name;
            /////
            }
            quoteToUpdateList.add(q2);
        }
        
        try{
        update quoteToUpdateList;
        }
        catch(System.Exception e) {
            for(Quote q : Trigger.New){
                q.addError('ERROR: ' + approvingQuoteName +' ('+ approvingQuoteID + ') is currenting pending approval. A new primary quote cannot be created while an existing quote is pending approval.');
            }
        }
    }
}