
const String kBaseURL = 'https://gcinc--ap.my.salesforce.com/services/data/v53.0/query/?';

const String kCustomerSearchByPhone = 'q=SELECT id,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Preferred_Instrument__c  from account where accountPhone__c=';

const String kCustomerSearchByEmail = 'q=SELECT id,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Preferred_Instrument__c from account where accountEmail__c=';