({
    clickSearch : function(component, event, helper) 
    {        
        var validSearch = component.find("searchForm").reduce(function(validSoFar, inputCmp)
                                                              {
                                                                  inputCmp.showHelpMessageIfInvalid();
                                                                  return validSoFar && inputCmp.get('v.validity').valid;
                                                              }, true);        
        
        if(validSearch)
        {
            var searchEvent = component.getEvent("cardSearched");
            var searchedCard = component.get("v.searchCard");
            console.log("Searching for: " + JSON.stringify(searchedCard)); 
            searchEvent.setParams({"searchedCard" : searchedCard});
            searchEvent.fire();
        }       
    }
})