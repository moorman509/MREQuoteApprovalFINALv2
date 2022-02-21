//DELETE THIS
trigger UpdateQuoteDocumentUploadTrigger on ContentDocumentLink (after insert) {

    System.debug('here is new the data: '+Trigger.New);

        Set<Id> documentList = new Set<Id>();
        for (ContentDocumentLink cdl : Trigger.New){
            documentList.add(cdl.LinkedEntityId);
        }

        List<Quote> quoteList = [SELECT Id FROM Quote WHERE Id IN :documentList];

        System.debug('adding check to: '+quoteList);
    
        if(quoteList.size() > 0){
            quoteList[0].Documents_Uploaded__c = true;
            update quoteList;
        }
        System.debug('insert: '+quoteList);
}