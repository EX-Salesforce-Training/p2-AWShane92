public with sharing class CardBuilderController 
{
    @AuraEnabled
	public static List<YuGiOh_Card__c> getCards()
    {
        return [SELECT Name, Primary_Image__c FROM YuGiOh_Card__c];
    }
}