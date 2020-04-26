public with sharing class YGoProDeckCallout
{
    //Main Link for callout to the API.
    public static final String ygoprodecklink = 'https://db.ygoprodeck.com/api/v7/cardinfo.php';
    static List<YuGiOh_Card__c> cardList;
    
    //This method is unabled to be ran due to the amount of all cards in the 
    //API database. 
    @AuraEnabled
    public static List<YuGiOh_Card__c> displayAllCards()
    {        
        calloutResponse(null);
        return cardList;
    }
    @AuraEnabled
    public static List<YuGiOh_Card__c> findCards(YuGiOh_Card__c searchCard)
    {
        String query = '?';
        
        if(searchCard.Name != null || searchCard.Name != '' )
        {
            if(query == '?')
            {
                query += ('fname=' + searchCard.Name);
            }
            else
            {
                query += ('&fname=' + searchCard.Name); 
            }           
        } 
        if(searchCard.Card_Frame__c != null && searchCard.Card_Frame__c != '') 
        {
            if(query == '?') 
            {
                query += ('type=' + searchCard.Card_Frame__c);
            }
            else
            {
                query += ('&type=' + searchCard.Card_Frame__c);
            }
        }
        if(searchCard.Level__c != null && searchCard.Level__c != 0)
        {
            if(query == '?')
            {
                query += ('level=' + searchCard.Level__c);
            }
            else
            {
                query += ('&level=' + searchCard.Level__c);
            }
        }
        
        query = query.replace(' ', '%20');
        System.debug(query);        
        calloutResponse(query);
        
        return cardList;
    }    
    
    public static void calloutResponse(String searchData){
        
        Http http = new Http();        
        HttpRequest req = new HttpRequest();
        
        if(searchData == null)
        {
            req.setEndpoint(ygoprodecklink);
        }
        else
        {
            req.setEndpoint(ygoprodecklink + searchData);
        }
        
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        //Parsing the JSON response as a Map. 
        Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        //Data is the only Map key-value pair returned and data is a list of JSON objects.
        List<Object> data = (List<Object>) jsonResponse.get('data');
        
        if(data == null)
        {
           cardList = new List<YuGiOh_Card__c>();
           return;
        }
        
        Map<String,Object> cardData;
        List<Object> imageList;
        Map<String,Object> imageMap;
        
        cardList = new List<YuGiOh_Card__c>();
        
        for(Object o: data)
        {
            cardData = (Map<String, Object>) o;
            imageList = (List<Object>) cardData.get('card_images');
            imageMap = (Map<String,Object>) imageList[0];            
            
            if(String.valueOf(cardData.get('type')) == 'Spell Card' || String.valueOf(cardData.get('type')) == 'Trap Card')
            {
                cardList.add(new YuGiOh_Card__c(Id__c = (Integer) cardData.get('id'), 
                                                Name = String.valueOf(cardData.get('name')), 
                                                Card_Frame__c = String.valueOf(cardData.get('type')), 
                                                Description__c = String.valueOf(cardData.get('desc')),
                                                Monster_Type__c = String.valueOf(cardData.get('race')),
                                                Primary_Image__c = String.valueOf(imageMap.get('image_url'))
                                               )); 
            }
            else
            {                
                cardList.add(new YuGiOh_Card__c(Id__c = (Integer) cardData.get('id'), 
                                                Name = String.valueOf(cardData.get('name')), 
                                                Card_Frame__c = String.valueOf(cardData.get('type')), 
                                                Description__c = String.valueOf(cardData.get('desc')),
                                                Attack__c = (Integer) cardData.get('atk'),
                                                Defense__c = (Integer) cardData.get('def'),
                                                Level__c  = (Integer) cardData.get('level'),
                                                Monster_Type__c = String.valueOf(cardData.get('race')),
                                                Attribute__c = String.valueOf(cardData.get('attribute')), 
                                                Primary_Image__c = String.valueOf(imageMap.get('image_url_small'))                                           
                                               ));               
            }  
        } 
    }    
}