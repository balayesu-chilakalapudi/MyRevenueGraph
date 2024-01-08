({
	ctr : function(cmp, event, helper) {       
        let userChoice=cmp.get("v.userChoice");
        helper.dogetCaseWrapMap(cmp,event,helper,userChoice); 
    },
    toggleSection : function(component, event, helper) {
        var sectionAuraId = event.target.getAttribute("data-auraId");
        // get section Div element using aura:id
        var sectionDiv = component.find(sectionAuraId).getElement();
         
        var sectionState = sectionDiv.getAttribute('class').search('slds-is-open'); 
         
        // -1 open/close section
        if(sectionState == -1){
            sectionDiv.setAttribute('class' , 'slds-section slds-is-open');
        }else{
            sectionDiv.setAttribute('class' , 'slds-section slds-is-close');
        }
    },
     onChange: function (cmp, evt, helper) {
       // cmp.set("v.loading",true);
        //alert(cmp.find('select').get('v.value') + ' pie is good.');
        let userChoice=cmp.find('select').get('v.value');
        console.log('userChoice:'+userChoice);
        cmp.set("v.userChoice",userChoice);
        helper.dogetCaseWrapMap(cmp,event,helper,userChoice); 
     }
})