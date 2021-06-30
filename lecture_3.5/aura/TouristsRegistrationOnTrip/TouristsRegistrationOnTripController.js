({
    onInit : function(component, event, helper) {
        helper.showSpinner(component);
        helper.createСolumns(component);
        helper.getTotalNumTourists(component);
        helper.fetchTourists(component, event);
        helper.checkingTrip(component, event);
        helper.hideSpinner(component);
    },
    
    validTrip : function(component, event, helper) {
        helper.checkingTrip(component, event);
    },
    
    clickAdd : function(component, event, helper) {
        helper.showSpinner(component);
        helper.parametersValidation(component, event);
    },
    
    closeModal : function(component, event, helper) {
        let isModalOpen = event.getSource();
        component.set("v.isModalOpen", false);
    },
    
    registration : function(component, event, helper) {
        helper.showSpinner(component);
        let selectedTourists = component.find("linesTable").getSelectedRows();
        component.set("v.selectedTourists", selectedTourists);
        let touristIds = selectedTourists.map(tourist => tourist.Id);
        component.set("v.touristIds", touristIds);
        helper.createFlights(component, event);
    },
    
    handleLoadMore : function(component,event,helper){
        event.getSource().set("v.isLoading", true);
        component.set("v.loadMoreStatus", $A.get("$Label.c.Loading"));
        helper.getMoreTourists(component, component.get("v.rowsToLoad")).then($A.getCallback(function (data) {
            if (component.get("v.rows").length == component.get("v.totalNumberOfRows")) {
                component.set("v.enableInfiniteLoading", false);
                component.set("v.loadMoreStatus", $A.get("$Label.c.LoadStatusNoMoreData"));
            } else {
                let currentData = component.get("v.rows");
                let newData = currentData.concat(data);
                component.set("v.rows", newData);
                component.set("v.loadMoreStatus", $A.get("$Label.c.LoadStatusScrollDown"));
            }
            event.getSource().set("v.isLoading", false);
        }));
    },
    
    handleSelectedRow: function(component, event, helper){
        let selectedRows = component.find("linesTable").getSelectedRows();
        component.set("v.selectedTourists", selectedRows);
        component.set("v.selectedRowsCount", selectedRows.length);
    }
})