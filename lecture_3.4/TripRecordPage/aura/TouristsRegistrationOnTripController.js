({
    onInit : function(component, event, helper) {
        helper.showSpinner(component);
        let columns = [
            {
                label: "full name", 
                fieldName: "linkName", 
                type: "url", 
                typeAttributes: {
                    label: { fieldName: "Name" }, 
                    target: "_blank"}
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
            }
        ];
        component.set("v.columns", columns);
        helper.fetchTourists(component, event);
        helper.checkingTrip(component, event);
        helper.hideSpinner(component);
        
    },
    
    clickAdd : function(component, event, helper) {
        helper.showSpinner(component);
        helper.parametersValidation(component, event);
    },
    
    closeModel : function(component, event, helper) {
        component.set("v.isModalOpen", false);
    },
    
    registration : function(component, event, helper) {
        helper.showSpinner(component);
        let selectedTourists = component.find("linesTable").getSelectedRows();
        component.set("v.selectedTourists", selectedTourists);
        let touristsId = [];
        for (let i = 0; i < selectedTourists.length; i++) {
            touristsId.push(selectedTourists[i].Id);
        }
        component.set("v.touristsId", touristsId);
        helper.createFlights(component, event);
    }
})