({
    displayImage : function(component, event, helper) {
        var card = component.get("v.cardData");
        var cardFrame = card["Card_Frame__c"];
        var url = "/sfsites/c/resource/" + cardFrame;
        console.log(url);
        component.find("cardFrameImg").set("v.src",url);
    }
})