import { LightningElement } from "lwc";
import INCIDENT from "@salesforce/schema/Incident__c";
import INCIDENT_STATUS from "@salesforce/schema/Incident__c.Status__c";
import INCIDENT_APPLIES from "@salesforce/schema/Incident__c.Applies_To__c";

export default class IncidentSearchFilters extends LightningElement {
    incObj = INCIDENT;
    incStatField = INCIDENT_STATUS;
    incApplies = INCIDENT_APPLIES;

    selectedStatus;
    selectedAppliesTo;

    handleStatusChange(event) {
        this.selectedStatus = event.detail.value;
    }

    handleAppliesToChange(event) {
        this.selectedAppliesTo = event.detail.value;
    }

    doSearch() {
        const event = new CustomEvent("searchclicked", {
            detail: {
                selectedStatus: this.selectedStatus,
                selectedAppliesTo: this.selectedAppliesTo
            }
        });
        this.dispatchEvent(event);
    }
}
