({
    getDataForMap : function(component, event){
        component.set('v.mapMarkers', [
            {
                location: {
                    City: 'Grodno',
                    Country: 'Belarus'
                },
                title: 'Belarus',
                value: 'Grodno',
                icon: 'custom:custom26'
                
            },
            {
                location: {
                    City: 'Dubai',
                    Country: 'United-Arab-Emirates'
                },
                value: 'Dubai',
                icon: 'custom:custom96',
                title: 'United-Arab-Emirates'
            },
            {
                location: {
                    City: 'Sydney',
                    Country: 'Australia'
                },
                value: 'Sydney',
                icon: 'custom:custom92',
                title: 'Australia'
            }
        ]);
        component.set('v.markersTitle', 'Choose');
    },
    
    сearchTrip : function(component, event) {
        let action = component.get("c.getTrips");
        action.setParams({
            touristId : component.get("v.touristId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.trips", response.getReturnValue());
            }
        });
        $A.enqueueAction(action); 
    },
    
    getFreeSeat : function(component, event) {
        let action = component.get("c.getFreeSeatsOnTrip");
        action.setParams({
            tripId : component.get("v.selectedTripId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.freeSeats", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    getCity : function(component, event) {
        let action = component.get("c.getNameCity");
        action.setParams({
            tripId : component.get("v.selectedTripId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.city", response.getReturnValue());
            }
        });
        $A.enqueueAction(action); 
    },
    
    createFlight: function(component, event) {
        let action = component.get("c.createFlight");
        action.setParams({
            tripId : component.get("v.selectedTripId"),
            touristId : component.get("v.touristId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title" :"Success!",
                    "type" : "success",
                    "message" : $A.get("$Label.c.SuccessRegistTourists")
                });
                toastEvent.fire();
            } 
            component.set("v.spinner", false);
        });
        $A.enqueueAction(action);
    },
    
    showSpinner : function(component) {
        component.set("v.spinner", true);
    },
    
    hideSpinner : function(component) {
        component.set("v.spinner", false);
    } 
})