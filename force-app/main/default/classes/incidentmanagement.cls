public with sharing class incidentmanagement {
    public Incident__c incident { get; set; }
    public Incident__c incSearch { get; set; }
    public List<Incident__c> incSearchResult { get; set; }

    public incidentmanagement(ApexPages.StandardController controller) {
        incSearch = new Incident__c();
    }

    public void searchIncidents() {
        incSearchResult = [
            SELECT Incident__c, Status__c, Applies_to__c, Summary__c
            FROM Incident__c
            WHERE
                Status__c = :incSearch.Status__c
                OR Applies_To__c = :incSearch.Applies_To__c
        ];
    }

    public void queryIncident() {
        try {
            Id incId = System.currentPageReference()
                .getParameters()
                .get('incid');
            incident = [
                SELECT
                    Incident__c,
                    Summary__c,
                    Responsible__c,
                    Priority__c,
                    Id,
                    Planned_Start_date__c,
                    Planned_End_date__c,
                    Actual_Start_date__c,
                    Actual_End_date__c,
                    Status__c,
                    Remarks__c
                FROM Incident__c
                WHERE id = :incId
            ];
        } catch (exception e) {
            System.debug(e);
        }
    }

    public void saveinc() {
        try {
            update incident;
        } catch (Exception e) {
            System.debug(e);
        }
    }

    // LWC Methods go here
    @AuraEnabled(cacheable=true)
    public static List<Incident__c> searchIncidentsLWC(
        String status,
        String appliesTo
    ) {
        try {
            return [
                SELECT Incident__c, Status__c, Applies_to__c, Summary__c
                FROM Incident__c
                WHERE Status__c = :status OR Applies_To__c = :appliesTo
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
