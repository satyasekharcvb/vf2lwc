# VF to LWC Conversion

This is a sample app that show how a Visualforce page can be converted to Lightning Web Components.

## Steps to use the code

1. Clone the repository:

    ```
    git clone https://github.com/satyasekharcvb/vf2lwc
    cd vf2lwc
    ```

1. Create a scratch org and provide it with an alias (**vf2lwc** in the command below):

    ```
    sfdx force:org:create -s -f config/project-scratch-def.json -a vf2lwc
    ```

1. Push the app to your scratch org:

    ```
    sfdx force:source:push
    ```

1. Assign the **Incident_Management** permission set to the default user:

    ```
    sfdx force:user:permset:assign -n Incident_Management
    ```

1. Open the scratch org:

    ```
    sfdx force:org:open
    ```

1. Navigate to the Incident Management App

1. Create a few Incidents from the Incidents Tab

1. Checkout the Visualforce page on the **Incident Management VF** tab

1. Checkout the LWC implmentation on the **Incident Mgmt LWC** tab.
