public class LeadContactGraphController {
    @AuraEnabled
    public static Map<String,DataWrapper> getDataWrapperMap(String userChoice){  
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
        Map<String,DataWrapper> mp=new Map<String,DataWrapper>();
        mp.put('Jan',new DataWrapper());
        mp.put('Feb',new DataWrapper());
        mp.put('Mar',new DataWrapper());
        mp.put('Apr',new DataWrapper());
        mp.put('May',new DataWrapper());
        mp.put('Jun',new DataWrapper());
        mp.put('Jul',new DataWrapper());
        mp.put('Aug',new DataWrapper());
        mp.put('Sep',new DataWrapper());
        mp.put('Oct',new DataWrapper());
        mp.put('Nov',new DataWrapper());
        mp.put('Dec',new DataWrapper());
        mp.put('Total',new DataWrapper());
        system.debug('mp:'+mp);
        
        for(Lead leadObj:Database.query('select id,createddate from Lead where createddate='+queryParam)){
            mp=getLeadsData(1,'Jan',mp,leadObj,currentdate);
            mp=getLeadsData(2,'Feb',mp,leadObj,currentdate);
            mp=getLeadsData(3,'Mar',mp,leadObj,currentdate);
            mp=getLeadsData(4,'Apr',mp,leadObj,currentdate);
            mp=getLeadsData(5,'May',mp,leadObj,currentdate);
            mp=getLeadsData(6,'Jun',mp,leadObj,currentdate);
            mp=getLeadsData(7,'Jul',mp,leadObj,currentdate);
            mp=getLeadsData(8,'Aug',mp,leadObj,currentdate);
            mp=getLeadsData(9,'Sep',mp,leadObj,currentdate);
            mp=getLeadsData(10,'Oct',mp,leadObj,currentdate);
            mp=getLeadsData(11,'Nov',mp,leadObj,currentdate);
            mp=getLeadsData(12,'Dec',mp,leadObj,currentdate);
        }
        for(Contact contactObj:Database.query('select id,Hubspot_Create_Date__c from Contact where Hubspot_Create_Date__c='+queryParam)){
            mp=getContactsData(1,'Jan',mp,contactObj,currentdate);
            mp=getContactsData(2,'Feb',mp,contactObj,currentdate);
            mp=getContactsData(3,'Mar',mp,contactObj,currentdate);
            mp=getContactsData(4,'Apr',mp,contactObj,currentdate);
            mp=getContactsData(5,'May',mp,contactObj,currentdate);
            mp=getContactsData(6,'Jun',mp,contactObj,currentdate);
            mp=getContactsData(7,'Jul',mp,contactObj,currentdate);
            mp=getContactsData(8,'Aug',mp,contactObj,currentdate);
            mp=getContactsData(9,'Sep',mp,contactObj,currentdate);
            mp=getContactsData(10,'Oct',mp,contactObj,currentdate);
            mp=getContactsData(11,'Nov',mp,contactObj,currentdate);
            mp=getContactsData(12,'Dec',mp,contactObj,currentdate);
        }
        
        return mp;
    }
    
    public static Map<String,DataWrapper> getLeadsData(integer monthnumber,String monthName,Map<String,DataWrapper> mp,Lead leadObj,date presentdate){
        Date currentdate = presentdate;
        //System.today();
        date presentmonth=date.newinstance(currentdate.year(),monthnumber,1);        
        //contacts      	
        if(Date.valueOf(leadObj.Createddate)>=date.newinstance(presentmonth.year(),monthnumber,1) &&
           Date.valueOf(leadObj.Createddate)<=date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month()))
          ){
              mp.get(monthName).Leads++;
              mp.get('Total').Leads++;
          }       
        return mp;
    }
    public static Map<String,DataWrapper> getContactsData(integer monthnumber,String monthName,Map<String,DataWrapper> mp,Contact contactObj,date presentdate){
        Date currentdate = presentdate;
        //System.today();
        date presentmonth=date.newinstance(currentdate.year(),monthnumber,1);        
        //contacts      	
        if(Date.valueOf(contactObj.Hubspot_Create_Date__c)>=date.newinstance(presentmonth.year(),monthnumber,1) &&
           Date.valueOf(contactObj.Hubspot_Create_Date__c)<=date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month()))
          ){
              mp.get(monthName).Contacts++;
              mp.get('Total').Contacts++;
          }       
        return mp;
    }
    
    public class DataWrapper{
        @AuraEnabled
        public String Month;
        @AuraEnabled
        public Decimal Leads=0;
        @AuraEnabled
        public Decimal Contacts=0;
    }
}