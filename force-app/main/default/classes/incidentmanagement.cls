/**
 * @File Name          : incidentmanagement.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 8/21/2019, 4:22:10 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    8/21/2019, 12:48:32 PM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public class incidentmanagement {
    public Incident__c incident; 
    public Incident__c incSearch = new Incident__c();
    public List<Incident__c> incsearchres = new List<Incident__c>();

    public incidentmanagement(ApexPages.StandardSetController controller) {
        controller.setPageSize(10);
    }

    public List<Incident__c> getincsearchresults()
    {
        if(incsearchres != NULL)
        {
            if(incsearchres.size() > 0)
                return incsearchres;
            else
                return null;
        }
        else             
            return null;
    }    

    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> findIncidents(String incNum, String statusValue, String appliesToValue)
    {
        System.debug(incNum + statusValue + appliesToValue);
        String query = 'Select Id, Status__c, Applies_To__c, Summary__c ,Incident__c FROM Incident__c WHERE';
        if(String.isNotBlank(incNum)){
            query = query + ' Incident__c LIKE \'%' + incNum + '%\' AND ';
        }
        if(String.isNotBlank(statusValue)){
            query = query + ' Status__c LIKE \'%' + statusValue + '%\' AND ';
        }
        if(String.isNotBlank(appliesToValue)){
            query = query + ' Applies_To__c LIKE \'%' + appliesToValue + '%\' AND ';
        }
        query = query.removeEnd('AND ');
        System.debug(query);
        wrapperClass wc;
        List<wrapperClass> lstwc = new List<wrapperClass>();
        for(Incident__c incObj: Database.query(query)){
           wc = new wrapperClass(incObj.Incident__c, '/lightning/r/Incident__c/'+incObj.Id+'/view' ,incObj.Status__c, incObj.Applies_To__c, incObj.Summary__c);
            lstwc.add(wc);
        }
        
        return lstwc;
    }
    
    public class wrapperClass{
        @AuraEnabled public string incidentId{get;set;}
        @AuraEnabled public string incidentURL{get;set;}
        @AuraEnabled public string status{get;set;}
        @AuraEnabled public string appliesTo{get;set;}
        @AuraEnabled public string summary{get;set;}
        public wrapperClass(String incidentId, String incidentURL, string status, string appliesTo, string summary){
            this.incidentId = incidentId;
            this.incidentURL = incidentURL;
            this.status = status;
            this.appliesTo = appliesTo;
            this.summary = summary;
        }
        public wrapperClass(){

        }
    }
    public void searchincident()
    {
        incsearchres  = [Select Remarks__c,Unit_Testing_Estimated_hrs__c,
        Unit_Testing_Actual_hrs__c,Rework_Estimated_hrs__c,
        Rework_Actual_hrs__c,Review_Testing_Actual__c,
        Review_Testing_Estimated__c,CUT_Estimated__c,CUT_Actual__c,
        Documentation_Actual__c,Documentation_Estimated__c,
        Deployment_Estimated__c,Deployment_Actual__c,Analysis_Estimate__c,
        Analysis_Actual__c,Status_Date__c,Created_Date__c,
        Severity__c,Priority__c,Status__c,Applies_to__c,
        Actual_Delivery_Date__c,Root_Cause_Analysis_RCA__c,
        Request_for_Change_RFC__c,Business_Requirements_Document_BRD__c,
        Business_Test_Case_BTC__c,Unit_Test_Case_UTC__c,
        Business_Approval_UAT_BA1__c,Business_Approval_Live_Test_BA2__c,
        Estimated_hrs__c,Actual_hrs__c,Owner.LastName,Incident__c,
        Summary__c,Responsible__c,Id,Planned_Start_date__c,
        Planned_End_date__c,Actual_Start_date__c,Actual_End_date__c,
        Delivery_date__c from Incident__c where Status__c=:incSearch.Status__c OR Incident__c like :incSearch.Incident_No_for_Search__c+'%' OR Applies_To__c=:incSearch.Applies_To__c OR Responsible__c = :incSearch.Responsible__c];
        
    }      
    public void queryincident()
    {
      try{
        Id incid=System.currentPageReference().getParameters().get('incid');
        incident = [Select Remarks__c,Unit_Testing_Estimated_hrs__c,
        Unit_Testing_Actual_hrs__c,Rework_Estimated_hrs__c,
        Rework_Actual_hrs__c,Review_Testing_Actual__c,
        Review_Testing_Estimated__c,CUT_Estimated__c,CUT_Actual__c,
        Documentation_Actual__c,Documentation_Estimated__c,
        Deployment_Estimated__c,Deployment_Actual__c,Analysis_Estimate__c,
        Analysis_Actual__c,Status_Date__c,Created_Date__c,
        Severity__c,Priority__c,Status__c,Applies_to__c,
        Actual_Delivery_Date__c,Root_Cause_Analysis_RCA__c,
        Request_for_Change_RFC__c,Business_Requirements_Document_BRD__c,
        Business_Test_Case_BTC__c,Unit_Test_Case_UTC__c,
        Business_Approval_UAT_BA1__c,Business_Approval_Live_Test_BA2__c,
        Estimated_hrs__c,Actual_hrs__c,Owner.LastName,Incident__c,
        Summary__c,Responsible__c,Id,Planned_Start_date__c,
        Planned_End_date__c,Actual_Start_date__c,Actual_End_date__c,
        Delivery_date__c from Incident__c where id=:incid];
       } 
      catch(exception e)
      {}
    }    
    public Incident__c getincdetail()
    {
        if(incident!=NULL)
            return incident;
        else
            return null;
    } 
    public Incident__c getInciSearch(){return incSearch;}
    public void saveinc()
    {
        try{   
        update incident;        
        }
        catch(Exception e)
        {
        }
    }    
       
}