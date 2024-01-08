public class RevenueGraphController {
    @AuraEnabled
    public List<LineChartVar> myLineChartVarList;
    
    public class LineChartVar {
        String label;
        decimal firstValue;
        
        public LineChartVar(String a, decimal b) {
            label = a;
            firstValue = b;
        }
    }
    
   /* @AuraEnabled
    public static Map<String, decimal> getChartMap(String userChoice) {
        decimal sum=0;
        String queryParam='';
        if(userChoice=='Last Year'){
            queryParam='LAST_YEAR';
        }
        else if(userChoice=='Current Year'){
            queryParam='THIS_YEAR';
        }
       
        Map<String, decimal> mp = new Map<String, decimal>();       
        decimal Opportunities_SolarRoof=(decimal)(Database.query('select sum(amount)totaloppamount from opportunity where Service_Requested_c__c IN (\'Solar Roof\') and Residential_or_Commercial__c NOT IN(\'Commercial\') and Service_Requested_c__c!=null and Residential_or_Commercial__c!=null and closedate='+queryParam)[0].get('totaloppamount'));
        if(Opportunities_SolarRoof==null){
            Opportunities_SolarRoof=0;
        }
        sum+=Opportunities_SolarRoof;
        mp.put('Solar Roof', Opportunities_SolarRoof);
        decimal Opportunities_SolarStorage=(decimal)(Database.query('select sum(amount)totaloppamount from opportunity where Service_Requested_c__c NOT IN (\'Solar Roof\') and Residential_or_Commercial__c NOT IN(\'Commercial\') and Service_Requested_c__c!=null and Residential_or_Commercial__c!=null and closedate='+queryParam)[0].get('totaloppamount'));
        if(Opportunities_SolarStorage==null){
            Opportunities_SolarStorage=0;
        }
        sum+=Opportunities_SolarStorage;
        mp.put('Solar Storage', Opportunities_SolarStorage); 
         decimal Opportunities_Commercial =(decimal)(Database.query('select sum(amount)totaloppamount from opportunity where Residential_or_Commercial__c IN (\'Commercial\') and Residential_or_Commercial__c!=null and closedate='+queryParam)[0].get('totaloppamount'));
        if(Opportunities_Commercial==null){
            Opportunities_Commercial=0;
        }
        sum+=Opportunities_Commercial;
        mp.put('Commercial', Opportunities_Commercial);
        decimal Cases_EV_Charging=(decimal)(Database.query('select sum(Total__c)evChargingTotal from case where Billing_Status__c=\'Paid\' and recordtype.name=\'EV Charging\' and ClosedDate='+queryParam)[0].get('evChargingTotal'));
        if(Cases_EV_Charging==null){
            Cases_EV_Charging=0;
        }
        sum+=Cases_EV_Charging;
        mp.put('EV Charging', Cases_EV_Charging);
        decimal CasesServiceTicket=(decimal)(Database.query('select sum(Total_Revenue__c)serviceTicketTotal from case where Billing_Status__c=\'Paid\' and recordtype.name=\'Service Ticket\' and ClosedDate='+queryParam)[0].get('serviceTicketTotal'));
        if(CasesServiceTicket==null){
            CasesServiceTicket=0;
        }
        sum+=CasesServiceTicket;
        mp.put('Service Ticket', CasesServiceTicket);
        decimal CasesDetachandReinstall=(decimal)(Database.query('select sum(Contract_Amount__c)detachAndReinstallTotal from case where Contract_Amount__c!=null and recordtype.name=\'Detach and Reinstall\' and Contract_Signed_Date__c='+queryParam)[0].get('detachAndReinstallTotal'));
        if(CasesDetachandReinstall==null){
            CasesDetachandReinstall=0;
        }
        sum+=CasesDetachandReinstall;
        mp.put('Detach and Reinstall',CasesDetachandReinstall);    
       // mp.put('Total',sum);
        System.debug('mp:'+mp);
        return mp;
    }*/ 
    
    @AuraEnabled
    public static String getLineChartMap(String userChoice) {
        decimal total_sum=0;
        List<LineChartVar> myLineChartVarList = new List<LineChartVar>();
       
        decimal Cases_EV_Charging=Integer.valueOf([select sum(Total__c)evChargingTotal from case where Billing_Status__c='Paid' and recordtype.name='EV Charging' and ClosedDate=THIS_MONTH][0].get('evChargingTotal'));
        if(Cases_EV_Charging==null){
            Cases_EV_Charging=0;
        }
        total_sum+=Cases_EV_Charging;
        decimal CasesServiceTicket=Integer.valueOf([select sum(Total_Revenue__c)serviceTicketTotal from case where Billing_Status__c='Paid' and recordtype.name='Service Ticket' and ClosedDate=THIS_MONTH][0].get('serviceTicketTotal'));
        if(CasesServiceTicket==null){
            CasesServiceTicket=0;
        }
        total_sum+=CasesServiceTicket;
        decimal CasesDetachandReinstall=Integer.valueOf([select sum(Contract_Amount__c)detachAndReinstallTotal from case where Contract_Amount__c!=null and recordtype.name='Detach and Reinstall' and Contract_Signed_Date__c=THIS_MONTH][0].get('detachAndReinstallTotal'));
        if(CasesDetachandReinstall==null){
            CasesDetachandReinstall=0;
        }
        total_sum+=CasesDetachandReinstall;
        decimal Opportunities_SolarRoof=Integer.valueOf([select sum(amount)totaloppamount from opportunity where Service_Requested_c__c IN ('Solar Roof') and Residential_or_Commercial__c NOT IN('Commercial') and Service_Requested_c__c!=null and Residential_or_Commercial__c!=null and closedate=THIS_MONTH][0].get('totaloppamount'));
        if(Opportunities_SolarRoof==null){
            Opportunities_SolarRoof=0;
        }    
        total_sum+=Opportunities_SolarRoof;
        decimal Opportunities_SolarStorage=Integer.valueOf([select sum(amount)totaloppamount from opportunity where Service_Requested_c__c NOT IN ('Solar Roof') and Residential_or_Commercial__c NOT IN('Commercial') and Service_Requested_c__c!=null and Residential_or_Commercial__c!=null and closedate=THIS_MONTH][0].get('totaloppamount'));
        if(Opportunities_SolarStorage==null){
            Opportunities_SolarStorage=0;
        }       
        total_sum+=Opportunities_SolarStorage;
        decimal Opportunities_Commercial =Integer.valueOf([select sum(amount)totaloppamount from opportunity where Residential_or_Commercial__c IN('Commercial') and Residential_or_Commercial__c!=null and closedate=THIS_MONTH][0].get('totaloppamount'));
        if(Opportunities_Commercial==null){
            Opportunities_Commercial=0;
        }
        total_sum+=Opportunities_Commercial;
        //myLineChartVarList.add(new LineChartVar('Opportunities',Opportunities_sum));
        myLineChartVarList.add(new LineChartVar('Solar Roof',Opportunities_SolarRoof));
        myLineChartVarList.add(new LineChartVar('Solar Storage',Opportunities_SolarStorage));
        myLineChartVarList.add(new LineChartVar('Commercial',  Opportunities_Commercial));
        myLineChartVarList.add(new LineChartVar('EV Charging', Cases_EV_Charging));
        myLineChartVarList.add(new LineChartVar('Service Ticket', CasesServiceTicket));
        myLineChartVarList.add(new LineChartVar('Detach and Reinstall',  CasesDetachandReinstall));
       // myLineChartVarList.add(new LineChartVar('Total',  total_sum));
        return JSON.serialize(myLineChartVarList);
    }
    @AuraEnabled
    public static List<Case> getCasesServiceTicket(String userChoice){
        return [select id,total_Revenue__c,casenumber,owner.name,account.name from case where Billing_Status__c='Paid' and recordtype.name='Service Ticket' and ClosedDate=THIS_MONTH];
    }
    @AuraEnabled
    public static List<Case> getCasesEVCharging(String userChoice){
        return [select id,total__c,casenumber,owner.name,account.name from case where Billing_Status__c='Paid' and recordtype.name='EV Charging' and ClosedDate=THIS_MONTH];
    }
    @AuraEnabled
    public static List<Case> getCasesDetachReinstall(String userChoice){
        return [select id,Detach_Amount__c,Contract_Amount__c,casenumber,owner.name,account.name from case where Contract_Amount__c!=null and recordtype.name='Detach and Reinstall' and Contract_Signed_Date__c=THIS_MONTH];
    }
    @AuraEnabled
    public static List<Opportunity> getOpportunities(String userChoice){
        return [select id,amount,name,owner.name,account.name from Opportunity where stagename='Closed Won' and closedate=THIS_MONTH];
    }
    @AuraEnabled
    public static Map<String,CaseWrap> getCaseWrapMap(String userChoice){  
        Date currentdate = System.today();
        integer year=currentdate.year();
        integer month=currentdate.month();
        integer day=currentdate.day();
        String queryParam='';
        if(userChoice=='Last Year'){
            queryParam='LAST_YEAR';
            currentdate=date.newinstance(year-1,month,day);
        }
        else if(userChoice=='Current Year'){
            queryParam='THIS_YEAR';
            currentdate=currentdate;
        }
        Map<String,CaseWrap> mp=new Map<String,CaseWrap>();
        mp.put('Jan',new CaseWrap());
        mp.put('Feb',new CaseWrap());
        mp.put('Mar',new CaseWrap());
        mp.put('Apr',new CaseWrap());
        mp.put('May',new CaseWrap());
        mp.put('Jun',new CaseWrap());
        mp.put('Jul',new CaseWrap());
        mp.put('Aug',new CaseWrap());
        mp.put('Sep',new CaseWrap());
        mp.put('Oct',new CaseWrap());
        mp.put('Nov',new CaseWrap());
        mp.put('Dec',new CaseWrap());
        mp.put('Total',new CaseWrap());
        system.debug('mp:'+mp);
        
        for(Case caseObj:[select id,total__c,GFE_Contract_Signed_Date__c,Total_Revenue__c,Detach_Amount__c,Contract_Amount__c,Contract_Signed_Date__c,closeddate,Billing_Status__c,recordtypeid,recordtype.name,casenumber,owner.name,account.name from case where recordtype.name IN ('Detach and Reinstall','EV Charging','Service Ticket')]){           	
            mp=getCaseWrapMapData(1,'Jan',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(2,'Feb',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(3,'Mar',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(4,'Apr',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(5,'May',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(6,'Jun',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(7,'Jul',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(8,'Aug',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(9,'Sep',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(10,'Oct',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(11,'Nov',mp,caseObj,currentdate);
            mp=getCaseWrapMapData(12,'Dec',mp,caseObj,currentdate);
        }
        for(Opportunity oppObj:Database.query('select id,amount,name,owner.name,Service_Requested_c__c,Residential_or_Commercial__c,account.name,stagename,closedate from Opportunity where stagename=\'Closed Won\' and closedate='+queryParam)){
            mp=getOpportunityData(1,'Jan',mp,oppObj,currentdate);
            mp=getOpportunityData(2,'Feb',mp,oppObj,currentdate);
            mp=getOpportunityData(3,'Mar',mp,oppObj,currentdate);
            mp=getOpportunityData(4,'Apr',mp,oppObj,currentdate);
            mp=getOpportunityData(5,'May',mp,oppObj,currentdate);
            mp=getOpportunityData(6,'Jun',mp,oppObj,currentdate);
            mp=getOpportunityData(7,'Jul',mp,oppObj,currentdate);
            mp=getOpportunityData(8,'Aug',mp,oppObj,currentdate);
            mp=getOpportunityData(9,'Sep',mp,oppObj,currentdate);
            mp=getOpportunityData(10,'Oct',mp,oppObj,currentdate);
            mp=getOpportunityData(11,'Nov',mp,oppObj,currentdate);
            mp=getOpportunityData(12,'Dec',mp,oppObj,currentdate);
        }      
        
        return mp;
    }
    public static Map<String,CaseWrap> getCaseWrapMapData(integer monthnumber,String monthName,Map<String,CaseWrap> mp,Case caseobj,date presentDate){
        Date currentdate = presentDate;
            //System.today();
        date presentmonth=date.newinstance(currentdate.year(),monthnumber,1);
        system.debug('presentmonth:'+presentmonth);
        system.debug(date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month())));
        if(caseObj.ClosedDate>=date.newinstance(presentmonth.year(),monthnumber,1) &&
           caseObj.ClosedDate<=date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month()))){
               //Service Ticket
               if(caseobj.Total_Revenue__c!=null &&
                  caseobj.Billing_Status__c!=null &&
                  caseobj.Billing_Status__c.equals('Paid') && 
                  caseobj.recordtype.name.equals('Service Ticket')){
                      mp.get(monthName).CasesServiceTicket+=caseobj.Total_Revenue__c;
                      mp.get('Total').CasesServiceTicket+=caseobj.Total_Revenue__c;
                  }
               //EV Charging
               if(caseobj.total__c!=null &&
                  caseobj.Billing_Status__c!=null &&
                  caseobj.Billing_Status__c.equals('Paid') &&                
                  caseobj.recordtype.name.equals('EV Charging')){
                      mp.get(monthName).CasesWithEVCharging+=caseobj.Total__c;
                      mp.get('Total').CasesWithEVCharging+=caseobj.Total__c;
                  }                   
           }
        //Detach and Reinstall
        if(caseObj.GFE_Contract_Signed_Date__c>=date.newinstance(presentmonth.year(),monthnumber,1) &&
           caseObj.GFE_Contract_Signed_Date__c<=date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month()))&
           caseobj.Contract_Amount__c!=null &&                                 
           caseobj.recordtype.name.equals('Detach and Reinstall')){
               mp.get(monthName).CasesDetach+=caseobj.Contract_Amount__c;
               mp.get('Total').CasesDetach+=caseobj.Contract_Amount__c;
           }
        
        return mp;
    }
    public static Map<String,CaseWrap> getOpportunityData(integer monthnumber,String monthName,Map<String,CaseWrap> mp,Opportunity oppobj,date presentdate){
        Date currentdate = presentdate;
            //System.today();
        date presentmonth=date.newinstance(currentdate.year(),monthnumber,1);        
        //opportunities solar roof       	
        if(oppObj.closedate>=date.newinstance(presentmonth.year(),monthnumber,1) &&
           oppObj.closedate<=date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month()))&
           oppObj.amount!=null && 
           oppObj.Residential_or_Commercial__c!=null &&
           oppObj.Service_Requested_c__c!=null &&
           oppObj.Service_Requested_c__c.contains('Solar Roof') &&
           !oppObj.Residential_or_Commercial__c.contains('Commercial')){
               mp.get(monthName).OpportunitiesSolarRoof+=oppObj.amount;
               mp.get('Total').OpportunitiesSolarRoof+=oppObj.amount;
           }
        //opportunities solar/storage       	
        if(oppObj.closedate>=date.newinstance(presentmonth.year(),monthnumber,1) &&
           oppObj.closedate<=date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month()))&
           oppObj.amount!=null &&                     
           oppObj.Service_Requested_c__c!=null &&
           oppObj.Residential_or_Commercial__c!=null &&
           !oppObj.Service_Requested_c__c.contains('Solar Roof') &&
          !oppObj.Residential_or_Commercial__c.contains('Commercial')){
               mp.get(monthName).OpportunitiesSolarStorage+=oppObj.amount;
               mp.get('Total').OpportunitiesSolarStorage+=oppObj.amount;
           }
        //opportunities Commercial     	
        if(oppObj.closedate>=date.newinstance(presentmonth.year(),monthnumber,1) &&
           oppObj.closedate<=date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month()))&
           oppObj.amount!=null && 
           oppObj.Residential_or_Commercial__c!=null &&
          oppObj.Residential_or_Commercial__c.contains('Commercial')){
               mp.get(monthName).OpportunitiesCommercial+=oppObj.amount;
               mp.get('Total').OpportunitiesCommercial+=oppObj.amount;              
           }        
        return mp;
    }
    
    public class CaseWrap{
        @AuraEnabled
        public String Month;
        @AuraEnabled
        public Decimal CasesWithEVCharging=0;
        @AuraEnabled
        public Decimal CasesServiceTicket=0;
        @AuraEnabled
        public Decimal CasesDetach=0;
        @AuraEnabled
        public Decimal OpportunitiesSolarRoof=0;
        @AuraEnabled
        public Decimal OpportunitiesSolarStorage=0;        
        @AuraEnabled
        public Decimal OpportunitiesCommercial=0;        
    }
}