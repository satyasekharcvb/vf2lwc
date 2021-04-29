import { LightningElement, api, wire } from "lwc";
import APEXSEARCH from "@salesforce/apex/incidentmanagement.searchIncidentsLWC";
import noresults from "@salesforce/label/c.No_Results_Found";

export default class IncidentSearchResults extends LightningElement {
    @api selectedStatus;
    @api selectedAppliesTo;

    nores = noresults;
    columns = [
        { label: "Incident #", fieldName: "Incident__c" },
        { label: "Applies To", fieldName: "Applies_to__c" },
        { label: "Status", fieldName: "Status__c" },
        { label: "Summary", fieldName: "Summary__c" }
    ];

    @wire(APEXSEARCH, {
        status: "$selectedStatus",
        appliesTo: "$selectedAppliesTo"
    })
    searchResults;

    connectedCallback() {}

    renderedCallback() {}
}
