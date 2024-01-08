@isTest
public class LeadContactGraphControllerTest {
	@isTest
    static void test1(){
        Lead leadObj=new Lead(firstname='test',lastname='abc',company='test company');
        insert leadObj;
        Contact contactObj=new Contact(lastname='test',Hubspot_Create_Date__c=datetime.now());
        insert contactObj;
        LeadContactGraphController.getDataWrapperMap('Current Year');
    }
}