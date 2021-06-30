({
    doInit : function(component, event, helper) {
        var url = $A.get("$Resource.PicturesForTrip");
        component.set("v.backgroundImageURL", url);
    },
    
    getTripDetail : function(component, event, helper) {
        let selectedItem = event.currentTarget; 
        let index = selectedItem.dataset.record; 
        let selectTrip = component.get("v.trips")[index];
        component.set("v.selectTripId", selectTrip.Id);
        let compEvent = component.getEvent("selectedTripId");
        compEvent.setParams({
            "selectedTripId" : component.get("v.selectTripId")
        });
        compEvent.fire();
    }
})