@isTest
public class RevenueGraphControllerTest {
    @isTest
    static void test1(){
        account acc=new account(name='test');
        insert acc;
        date currentdate=system.today();
        opportunity opp=new opportunity(name='opp test',accountId=acc.id,stagename='Closed Won',closedate=date.newinstance(currentdate.year()-1,currentdate.month(),currentdate.day()));
        insert opp;
        List<case> caselist=new List<case>();
        case caseobj1=new case(
            billing_status__c='Paid',
            subject='test',
            total__c=100,
            closeddate=system.today()+7,
            opportunity__c=opp.id,
            recordtypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Service Ticket').getRecordTypeId()
        );
        caselist.add(caseObj1);
        case caseobj2=new case(
            billing_status__c='Paid',
            subject='test',
            total__c=100,
            closeddate=system.today()+7,
            opportunity__c=opp.id,
            recordtypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('EV Charging').getRecordTypeId()
        );
        caselist.add(caseObj2);
        case caseobj3=new case(
            billing_status__c='Paid',
            subject='test',
            total__c=100,
            Module_Quantity__c=2,
            opportunity__c=opp.id,
            recordtypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Detach and Reinstall').getRecordTypeId()
        );
        caselist.add(caseObj3);
        insert caselist;
        String userChoice='Last Year';
        RevenueGraphController.getCasesServiceTicket(userChoice);
        RevenueGraphController.getCasesEVCharging(userChoice);
        RevenueGraphController.getCasesDetachReinstall(userChoice);
        RevenueGraphController.getOpportunities(userChoice);
        RevenueGraphController.getLineChartMap(userChoice);
       // RevenueGraphController.getChartMap(userChoice);
        RevenueGraphController.getCaseWrapMap(userChoice);
    }
}