({
    hangeIt : function(cmp, event, helper) {
        let newVal = cmp.get("v.changeTo");
        cmp.set("v.changeTo", newVal);
        cmp.find("lookupId").fireChanging();
    },
    
    submit : function(component, event, helper) {
        helper.showSpinner(component);
        helper.createFlight(component, event);
    },
    
    selectedTourist : function(component, event, helper) {
        helper.getDataForMap(component, event);
        helper.сearchTrip(component, event);
        component.set("v.activeCardsTrip", true);
    },
    
    getTripDetail : function(component, event, helper) {
        let selectedItem = event.currentTarget; 
        let index = selectedItem.dataset.record; 
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
        let marker = event.getParam("selectedMarkerValue");
    }
})