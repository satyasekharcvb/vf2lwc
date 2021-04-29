import { LightningElement, wire } from "lwc";
import INCIDENT_OBJ from "@salesforce/schema/Incident__c";

// Import message service features required for subscribing and the message channel
import {
    subscribe,
    unsubscribe,
    MessageContext
} from "lightning/messageService";
import recordSelected from "@salesforce/messageChannel/Record_Selected__c";

export default class IncidentDetail extends LightningElement {
    recordId;
    subscription = null;

    @wire(MessageContext)
    messageContext;

    incidentObj = INCIDENT_OBJ;

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                recordSelected,
                (message) => this.handleMessage(message)
            );
        }
    }

    // Handler for message received by component
    handleMessage(message) {
        this.recordId = message.recordId;
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }
}
