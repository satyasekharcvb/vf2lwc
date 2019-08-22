import { LightningElement, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import STATUS_FIELD from '@salesforce/schema/Incident__c.Status__c';
import APPLIES_TO_FIELD from '@salesforce/schema/Incident__c.Applies_To__c';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';
import incident from '@salesforce/resourceUrl/incident';


export default class IncidentSearch extends LightningElement {
    incNum="";
    incidentURL = incident;


    @wire(CurrentPageReference) pageRef;

    @wire(getPicklistValues, {recordTypeId: '012000000000000AAA',fieldApiName: STATUS_FIELD })
    statusValues;
    statusValue="";

    @wire(getPicklistValues, {recordTypeId: '012000000000000AAA',fieldApiName: APPLIES_TO_FIELD })
    appliesToValues;
    appliesToValue="";

    

    handleIncNum(event){
        this.incNum = event.target.value;
    }

    handleChange(event){
        console.log(event.target);
        if(event.target.name==='status'){
            this.statusValue = event.target.value;
        }
        if(event.target.name==='appliesTo'){
            this.appliesToValue = event.target.value;
        }
        
    }

    handleSearch(event){
        let eventData = {'incNo' : this.incNum , 
                    'statusVal' : this.statusValue , 
                    'appliesToVal' : this.appliesToValue};
        console.log(eventData);
        fireEvent(this.pageRef, 'searchKeyChange', eventData);
    }


}