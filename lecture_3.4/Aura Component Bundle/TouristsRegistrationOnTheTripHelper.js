({
    fetchData : function(component, event) {
	let action = component.get("c.getTourists");
        action.setParams({
            tripId : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.rows", response.getReturnValue());  
            }
        });
        $A.enqueueAction(action); 
    }
})