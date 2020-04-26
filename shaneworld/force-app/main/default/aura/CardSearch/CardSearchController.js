({
    onInit : function(component, event, helper){
        var action = component.get("c.findCards");
        var baseCard = component.get("v.baseCard");
        action.setParams({
            "searchCard": baseCard
        });        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.cardList", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },    
    onSearch : function(component, event, helper) {
        var searchedCard = event.getParam("searchedCard");
        helper.searchCards(component, searchedCard);  
    }
})