({
    submit : function(component, event, helper) {
        helper.showSpinner(component);
        alert(component.get("v.selectedTripId"));
        alert(component.get("v.touristId"));
        helper.createFlight(component, event);
    },
    
    selectedTourist : function(component, event, helper) {
        helper.getDataForMap(component, event);
        let tourist = event.getParam("value");
        component.set("v.touristId", tourist.Id);
        helper.сearchTrip(component, event);
        component.set("v.activeCardsTrip", true);
    },
    
    getTripDetail : function(component, event, helper) {
        let selectedItem = event.currentTarget; // Get the target object
        let index = selectedItem.dataset.record; // Get its value i.e. the index
        let selectedTrip = component.get("v.trips")[index];
        component.set("v.selectedTrip", selectedTrip);
        component.set("v.selectedTripId", selectedTrip.Id);
        helper.getFreeSeat(component, event);
        component.set("v.activeInformationTrip", true);
        helper.getCity(component, event);
        helper.getWeather(component, event);
        helper.zoomMap(component, event);
    },
    
    handleMarkerSelect: function (cmp, event, helper) {
        var marker = event.getParam("selectedMarkerValue");
    }
})