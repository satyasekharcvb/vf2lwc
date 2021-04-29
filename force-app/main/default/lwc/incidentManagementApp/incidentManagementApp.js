import { LightningElement } from "lwc";

export default class IncidentManagementApp extends LightningElement {
    fromEvent_selectedStatus;
    fromEvent_selectedAppliesTo;

    handleSearchClicked(event) {
        this.fromEvent_selectedStatus = event.detail.selectedStatus;
        this.fromEvent_selectedAppliesTo = event.detail.selectedAppliesTo;
    }
}
