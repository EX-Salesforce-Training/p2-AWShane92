public with sharing class CardBuilderController 
{
    @AuraEnabled
	public static List<YuGiOh_Card__c> getCards()
    {
        return [SELECT Name, Card_Frame__c, Description__c , Primary_Image__c FROM YuGiOh_Card__c];
    }
}