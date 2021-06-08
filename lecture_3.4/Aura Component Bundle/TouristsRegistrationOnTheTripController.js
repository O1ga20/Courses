({
    onInit: function(component, event, helper) {
        let columns = [
            {
                label : "full name",
                fieldName : "Name",
                type : "text"
            },
            {
                label : "email",
                fieldName : "Email__c",
                type : "email"
            },
            {
                label : "gender",
                fieldName : "Gender__c",
                type : "picklist"
            },
            {
                label : "Action",
                type : "button",
                typeAttributes : {
                    label : "View details",
                    name : "view_details"
                }
            }
        ];
        component.set("v.columns", columns);
        helper.fetchData(component, event);
        
    },
    
    onRowAction: function(component, event, helper) {
        let action = event.getParam("action");
        let row = event.getParam("row");
        if (action.name == "view_details") {
            var navigation = component.find("navigation");
            navigation.navigate({
                "type" : "standard__recordPage",
                "attributes" : {
                    "objectApiName" : "Tourist__c",
                    "recordId" : row.Id,
                    "actionName" : "view"
                }
            });
        }
    },
    
    handleClick : function(component, event, helper) {
        let numberSelectedRows = component.find("linesTable").getSelectedRows().length;
        component.set("v.numberSelectedRows", numberSelectedRows);
        if (numberSelectedRows == 0) {
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title" : "Error ",
                "type" : "error",
                "message" :"Select tourists."
            });
            toastEvent.fire();
        } else {
            let action = component.get("c.getCheckingSeats");
            action.setParams({
                tripId: component.get("v.recordId"),
                numberSelectedRows : numberSelectedRows
            });
            action.setCallback(this, function(response) {
                let state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.checkingSeats", response.getReturnValue());
                    if (component.get("v.checkingSeats")) {
                        component.set("v.isModalOpen", true);
                    } else {
                        let toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title" : "Error ",
                            "type" : "error",
                            "message" :"There are not enough free seats on the trip."
                        });
                        toastEvent.fire();
                    }
                }
            });
            $A.enqueueAction(action); 
        }
    },
    
    closeModel: function(component, event, helper) {
        component.set("v.isModalOpen", false);
    },
    
    addOnTrip: function(component, event, helper) {
        
        
        component.set("v.isModalOpen", false);
        let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title" :"Success!",
                "type" : "success",
                "message" : " Selected tourists are assigned for the trip."
            });
            toastEvent.fire();
    }
})