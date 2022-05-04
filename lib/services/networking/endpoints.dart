
const String kBaseURL = 'https://gcinc--ap.my.salesforce.com/services/data/v53.0/query/?';

const String kCustomerSearchByPhone = 'q=SELECT id,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c, Lifetime_Net_Sales_Amount__c,Lifetime_Net_Units__c, Preferred_Instrument__c, Max_ltv_net_dlrs__c, Median_ltv_net_dlrs__c, Avg_ltv_net_dlrs__c from account where accountPhone__c=';

const String kCustomerSearchByEmail = 'q=SELECT id,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c, Lifetime_Net_Sales_Amount__c,Lifetime_Net_Units__c, Preferred_Instrument__c, Max_ltv_net_dlrs__c, Median_ltv_net_dlrs__c, Avg_ltv_net_dlrs__c from account where accountEmail__c=';

const String kCustomerSearchByName = 'q=SELECT id,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c, Lifetime_Net_Sales_Amount__c,Lifetime_Net_Units__c, Preferred_Instrument__c, Max_ltv_net_dlrs__c, Median_ltv_net_dlrs__c, Avg_ltv_net_dlrs__c from account where accountEmail__c=';
