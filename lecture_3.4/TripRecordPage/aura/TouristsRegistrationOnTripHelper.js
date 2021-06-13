({
    fetchTourists : function(component, event) {
        let action = component.get("c.getTourists");
        action.setParams({
            tripId : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                records.forEach(function(record) {
                    record.linkName = '/' + record.Id;
                });
                component.set("v.rows", response.getReturnValue());  
            }
        });
        $A.enqueueAction(action); 
 },
    
    checkingTrip : function(component, event) {
        let action = component.get("c.getValidTrip");
        action.setParams({
            tripId : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.validTrip", response.getReturnValue());
                if (component.get("v.validTrip")) {
                    component.set("v.buttonVisible", true);
                } else {
                    component.set("v.buttonVisible", false);
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    parametersValidation : function(component, event) {
        let numberSelectedRows = component.find("linesTable").getSelectedRows().length;
        component.set("v.numberSelectedRows", numberSelectedRows);
        if (numberSelectedRows == 0) {
            component.set("v.spinner", false);
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title" : "Error ",
                "type" : "error",
                "message" : $A.get("$Label.c.TripErrorNull")
            });
            toastEvent.fire();
        } else {
            let action = component.get("c.getCheckingFreeSeatsForTourists");
            action.setParams({
                tripId: component.get("v.recordId"),
                numberSelectedRows : component.get("v.numberSelectedRows")
            });
            action.setCallback(this, function(response) {
                let state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.spinner", false);
                    component.set("v.checkSeatsWithSelected", response.getReturnValue());
                    if (component.get("v.checkSeatsWithSelected")) {
                        component.set("v.isModalOpen", true);
                    } else {
                        component.set("v.spinner", false);
                        let toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title" : "Error ",
                            "type" : "error",
                            "message" : $A.get("$Label.c.TripErrorNotFreeSeats")
                        });
                        toastEvent.fire();
                    }
                }
                component.set("v.spinner", false);
            });
            $A.enqueueAction(action); 
        }
    },
    
    createFlights: function(component, event) {
        let action = component.get("c.createFlights");
        action.setParams({
            tripId : component.get("v.recordId"),
            touristsId : component.get("v.touristsId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.isModalOpen", false);
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