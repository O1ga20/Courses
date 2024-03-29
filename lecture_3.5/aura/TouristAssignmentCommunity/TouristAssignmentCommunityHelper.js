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
    
    сearchTrips : function(component, event) {
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
    
    getTrip : function(component, event) {
        let action = component.get("c.getTrip");
        action.setParams({
            tripId : component.get("v.selectedTripId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.trip", response.getReturnValue());
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
                component.set("v.spacePoint", response.getReturnValue());
                component.set("v.city", response.getReturnValue().City__c);
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
                this.hideSpinner(component);
                const title =  $A.get("$Label.c.Success");
                const type = $A.get("$Label.c.Success");
                const message = $A.get("$Label.c.SuccessRegistTourists");
                this.showToast(title, type, message);
                $A.get('e.force:refreshView').fire();
                this.getDataForMap(component);
                this.сearchTrips(component, event);
            } 
            this.hideSpinner(component);
        });
        $A.enqueueAction(action);
    },
    
    getWeather : function(component, event) {
        let action = component.get("c.fetchWeather");
        action.setParams({
            spacePoint : component.get("v.spacePoint").Id
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.temperature", response.getReturnValue().Average_Temperature__c);
            } 
            this.hideSpinner(component);
        });
        $A.enqueueAction(action);
    },
    
    zoomMap : function(component, event) {
        component.set("v.mapMarkers", [
            {
                location: {
                    City: component.get("v.city")
                },
            }
        ]);
        component.set("v.zoomLevel", 7);
    },
    
    showSpinner : function(component) {
        component.set("v.showSpinner", true);
    },
    
    hideSpinner : function(component) {
        component.set("v.showSpinner", false);
    },
    
    showToast : function(title, type, message) {
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(
            {
                title : title,
                type : type, 
                message : message
            }
        );
        toastEvent.fire();
    }
})