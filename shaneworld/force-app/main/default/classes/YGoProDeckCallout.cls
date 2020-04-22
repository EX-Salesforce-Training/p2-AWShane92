public with sharing class YGoProDeckCallout{
    //Main Link for callout to the API.
    public static final String ygoprodecklink = 'https://db.ygoprodeck.com/api/v7/cardinfo.php';
       
    public static void getCards(){
        Http http = new Http();        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ygoprodecklink + '?archetype=Blue-Eyes');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        //Parsing the JSON response as a Map. 
		Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        //Data is the only Map key-value pair returned and data is a list of JSON objects.
        List<Object> data = (List<Object>) jsonResponse.get('data');
        //Each JSON object returned is the individual card information which can be put into a Map.
        Map<String,Object> cardData;
        for(Object o: data){
            cardData = (Map<String, Object>) o;
            System.debug(cardData.get('name'));
        }
    }
    public static void getCards(String query){
        Http http = new Http();        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ygoprodecklink + '?archetype=Blue-Eyes');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        //Parsing the JSON response as a Map. 
		Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        //Data is the only Map key-value pair returned and data is a list of JSON objects.
        List<Object> data = (List<Object>) jsonResponse.get('data');
        //Each JSON object returned is the individual card information which can be put into a Map.
        Map<String,Object> cardData;
        for(Object o: data){
            cardData = (Map<String, Object>) o;
            System.debug(cardData.get('name'));
        }
    }
}
//Example JSON response. 
/* {
  "data": [
    {
      "id": 6983839,
      "name": "Tornado Dragon",
      "type": "XYZ Monster",
      "desc": "2 Level 4 monsters\nOnce per turn (Quick Effect): You can detach 1 material from this card, then target 1 Spell/Trap on the field; destroy it.",
      "atk": 2100,
      "def": 2000,
      "level": 4,
      "race": "Wyrm",
      "attribute": "WIND",
      "card_sets": [
        {
          "set_name": "Battles of Legend: Relentless Revenge",
          "set_code": "BLRR-EN084",
          "set_rarity": "Secret Rare",
          "set_rarity_code": "(ScR)",
          "set_price": "4.08"
        },
        {
          "set_name": "Duel Devastator",
          "set_code": "DUDE-EN019",
          "set_rarity": "Ultra Rare",
          "set_rarity_code": "(UR)",
          "set_price": "1.4"
        },
        {
          "set_name": "Maximum Crisis",
          "set_code": "MACR-EN081",
          "set_rarity": "Secret Rare",
          "set_rarity_code": "(ScR)",
          "set_price": "4.32"
        }
      ],
      "card_images": [
        {
          "id": 6983839,
          "image_url": "https://storage.googleapis.com/ygoprodeck.com/pics/6983839.jpg",
          "image_url_small": "https://storage.googleapis.com/ygoprodeck.com/pics_small/6983839.jpg"
        }
      ],
      "card_prices": [
        {
          "cardmarket_price": "0.42",
          "tcgplayer_price": "0.48",
          "ebay_price": "2.99",
          "amazon_price": "0.77",
          "coolstuffinc_price": "0.99"
        }
      ]
    }
  ]
}*/