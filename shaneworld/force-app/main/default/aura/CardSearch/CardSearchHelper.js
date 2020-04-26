({
	searchCards : function(component, searchedCard) 
	{
		var action = component.get("c.findCards");
        action.setParams({
            "searchCard": searchedCard
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
	}
})