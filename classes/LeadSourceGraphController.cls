public class LeadSourceGraphController {
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
        else if(userChoice=='Current month'){
            queryParam='THIS_MONTH';
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
        
        for(Lead leadObj:Database.query('select id,createddate,leadsource from Lead where createddate='+queryParam)){
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
        for(Contact contactObj:Database.query('select id,Hubspot_Create_Date__c,LeadSource from Contact where Hubspot_Create_Date__c='+queryParam)){
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
        system.debug('mp:'+mp);
        return mp;
    }
    
    public static Map<String,DataWrapper> getLeadsData(integer monthnumber,String monthName,Map<String,DataWrapper> mp,Lead leadObj,date presentdate){
        Date currentdate = presentdate;
        //System.today();
        date presentmonth=date.newinstance(currentdate.year(),monthnumber,1);        
        //contacts      	
        if(leadObj.leadsource!=null &&
           Date.valueOf(leadObj.Createddate)>=date.newinstance(presentmonth.year(),monthnumber,1) &&
           Date.valueOf(leadObj.Createddate)<=date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month()))
          ){
             if(!mp.get(monthName).leadsourcemap.containsKey(leadObj.leadsource)){
                  (mp.get(monthName).leadsourcemap).put(leadObj.leadsource,0);
              }
              integer newvalue=mp.get(monthName).leadsourcemap.get(leadObj.leadsource);
              newvalue++;
              (mp.get(monthName).leadsourcemap).put(leadObj.leadsource, newvalue); 
              
               if(!mp.get('Total').leadsourcemap.containsKey(leadObj.leadsource)){
                  mp.get('Total').leadsourcemap.put(leadObj.leadsource,0);
              }
               integer total_newvalue=mp.get('Total').leadsourcemap.get(leadObj.leadsource);
              total_newvalue++;
              (mp.get('Total').leadsourcemap).put(leadObj.leadsource, total_newvalue); 
          }       
        return mp;
    }
    public static Map<String,DataWrapper> getContactsData(integer monthnumber,String monthName,Map<String,DataWrapper> mp,Contact contactObj,date presentdate){
        Date currentdate = presentdate;
        //System.today();
        date presentmonth=date.newinstance(currentdate.year(),monthnumber,1);   
        
        //contacts      	
        if(contactObj.leadsource!=null && 
           Date.valueOf(contactObj.Hubspot_Create_Date__c)>=date.newinstance(presentmonth.year(),monthnumber,1) &&
           Date.valueOf(contactObj.Hubspot_Create_Date__c)<=date.newinstance(presentmonth.year(),monthnumber,Date.daysInMonth(presentmonth.Year(), presentmonth.Month()))
          ){
              if(!mp.get(monthName).leadsourcemap.containsKey(contactObj.leadsource)){
                  mp.get(monthName).leadsourcemap.put(contactObj.leadsource,0);
              }
              integer newvalue=mp.get(monthName).leadsourcemap.get(contactObj.leadsource);
              newvalue++;
              mp.get(monthName).leadsourcemap.put(contactObj.leadsource, newvalue);
              
              if(!mp.get('Total').leadsourcemap.containsKey(contactObj.leadsource)){
                  mp.get('Total').leadsourcemap.put(contactObj.leadsource,0);
              }
              integer total_newvalue=mp.get('Total').leadsourcemap.get(contactObj.leadsource);
              total_newvalue++;
              (mp.get('Total').leadsourcemap).put(contactObj.leadsource, total_newvalue); 
          }       
        return mp;
    }
    
    public class DataWrapper{        
        @AuraEnabled
        public Map<String,Integer> leadsourcemap=new Map<String,Integer>();
    }
}