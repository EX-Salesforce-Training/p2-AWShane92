public with sharing class CustomCardHandler 
{
    @InvocableMethod(label='Link Image to record')
    public static void linkImage(List<ID> recordId)
    {
        List<YuGiOh_Card__c> cardList = [SELECT Id FROM YuGiOh_Card__c WHERE Id =: recordId];
        
        for(YuGiOh_Card__c yc: cardList)
        {
        	    yc.Primary_Image__c = [SELECT ContentDocumentId, LinkedEntityId 
                                       FROM ContentDocumentLink 
                                       WHERE LinkedEntityId =: yc.Id LIMIT 1].ContentDocumentId;
        }
        
        update cardList;
    }
}
/*[SELECT Id, LinkedEntityId, ContentDocumentId, Visibility, IsDeleted, ShareType,
ContentDocument.Title, ContentDocument.createdDate, ContentDocument.FileType
FROM ContentDocumentLink 
WHERE LinkedEntityId = '<recordID>'];*/