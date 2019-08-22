import { LightningElement,wire,track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import findIncidents from '@salesforce/apex/incidentmanagement.findIncidents';
import { registerListener, unregisterAllListeners } from 'c/pubsub';


const columns = [
    {label: 'Incident #', fieldName: 'incidentURL', type: 'url', 
    typeAttributes: {label: { fieldName: 'incidentId' }, target: '_blank'}},
    { label: 'Applies To', fieldName: 'appliesTo', type: 'string' },
    { label: 'Status', fieldName: 'status', type: 'string' },
    { label: 'Summary', fieldName: 'summary', type: 'string' },
];

export default class SearchResult extends LightningElement {
    @track columns = columns;
    @track incidents;
    @track error;
    incNoVal;
    statusValue;
    appliesToValue;

    @wire(CurrentPageReference) pageRef;
    
    @wire(findIncidents, { incNum: '$incNoVal', statusValue: '$statusValue', appliesToValue: '$appliesToValue' })
    incidents;
   
    connectedCallback() {
        // subscribe to searchKeyChange event
        registerListener('searchKeyChange', this.handleSearchKeyChange, this);
    }

    disconnectedCallback() {
        // unsubscribe from searchKeyChange event
        unregisterAllListeners(this);
    }

    handleSearchKeyChange(searchKey) {
        console.log(searchKey);
        this.incNoVal = searchKey.incNo;
        this.statusValue = searchKey.statusVal;
        this.appliesToValue = searchKey.appliesToVal;
        console.log(this.incNoVal);
        console.log(this.statusValue);
        console.log(this.appliesToValue);
    }
}