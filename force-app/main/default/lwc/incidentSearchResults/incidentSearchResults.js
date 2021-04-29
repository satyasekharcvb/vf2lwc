import { LightningElement, api, wire } from "lwc";
import APEXSEARCH from "@salesforce/apex/incidentmanagement.searchIncidentsLWC";
import noresults from "@salesforce/label/c.No_Results_Found";

import { publish, MessageContext } from "lightning/messageService";
import recordSelected from "@salesforce/messageChannel/Record_Selected__c";

export default class IncidentSearchResults extends LightningElement {
    @api selectedStatus;
    @api selectedAppliesTo;

    nores = noresults;

    columns = [
        {
            label: "Incident #",
            type: "button",
            typeAttributes: {
                label: { fieldName: "Name" },
                name: "View",
                variant: "base"
            }
        },
        { label: "Applies To", fieldName: "Applies_to__c" },
        { label: "Status", fieldName: "Status__c" },
        { label: "Summary", fieldName: "Summary__c" }
    ];

    @wire(APEXSEARCH, {
        status: "$selectedStatus",
        appliesTo: "$selectedAppliesTo"
    })
    searchResults;

    @wire(MessageContext)
    messageContext;

    // Respond to UI event by publishing message
    handleIncidentSelect(event) {
        const payload = { recordId: event.detail.row.Id };
        publish(this.messageContext, recordSelected, payload);
    }
}
