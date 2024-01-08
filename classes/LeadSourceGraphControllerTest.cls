@isTest
public class LeadSourceGraphControllerTest {
	@isTest
    static void test1(){
        Lead leadObj=new Lead(firstname='test',lastname='abc',company='test company',leadsource='test');
        insert leadObj;
        Contact contactObj=new Contact(lastname='test',leadsource='abcd',Hubspot_Create_Date__c=datetime.now());
        insert contactObj;
        LeadSourceGraphController.getDataWrapperMap('Current Year');
    }
}