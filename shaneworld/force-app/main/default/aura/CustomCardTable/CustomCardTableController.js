({
	onInit : function(component, event, helper) {
		var action = component.get("c.getCards");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var cardList = response.getReturnValue();                
                if(cardList.length === 0){                    
                    component.set("v.error", true);
                }
                component.set("v.cardList", cardList);
            }
            else{
                console.log("Error Processing Record Request.");
            }
        });
        
        $A.enqueueAction(action);
	}
})