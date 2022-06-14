abstract class Endpoints {
  static String kBaseURL = 'https://gcinc--tracuat.my.salesforce.com';
  static String kCustomerSearchByPhone =
      '/services/data/v53.0/query/?q=SELECT id,name,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Sales_Transactions__c,Primary_Instrument_Category__c,Max_ltv_net_dlrs_Formula__c,Median_ltv_net_dlrs_Formula__c, Avg_ltv_net_dlrs_Formula__c from account where accountPhone__c=';
  static String kCustomerSearchByEmail =
      '/services/data/v53.0/query/?q=SELECT id,name,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Sales_Transactions__c,Primary_Instrument_Category__c,Max_ltv_net_dlrs_Formula__c,Median_ltv_net_dlrs_Formula__c, Avg_ltv_net_dlrs_Formula__c from account where accountEmail__c=';
  static String kCustomerSearchByName =
      '/services/data/v53.0/query/?q=SELECT id,name,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Sales_Transactions__c,Primary_Instrument_Category__c,Max_ltv_net_dlrs_Formula__c,Median_ltv_net_dlrs_Formula__c, Avg_ltv_net_dlrs_Formula__c from account where name like ';
  static String kCustomerAllOrders =
      '/services/data/v53.0/query/?q=SELECT Id,OwnerId,First_Name__c,Last_Name__c,Order_Number__c,Total_Amount__c,Commission_JSON__c, Rollup_Count_Order_Line_Items__c,Order_Status__c,CreatedDate,LastModifiedDate FROM GC_Order__c where OwnerId IN (SELECT Id FROM User WHERE Email = ';
  static String kCustomerOpenOrders =
      '/services/data/v53.0/query/?q=SELECT Id, OwnerId, First_Name__c, Last_Name__c, Order_Number__c, LastModifiedDate, CreatedDate, Total_Amount__c, Commission_JSON__c, Rollup_Count_Order_Line_Items__c, Order_Status__c FROM GC_Order__c where OwnerId IN (SELECT Id FROM User WHERE Email = ';
  static String kAgentTotalSales =
      '/services/data/v53.0/query/?q=SELECT name,email,sum(Gross_Sales_MTD__c) Sales FROM User WHERE Gross_Sales_MTD__c != null and email =';
  static String kAgentTotalCommission =
      '/services/data/v53.0/query/?q=SELECT name,email,sum(Comm_Amount_MTD__c) commission FROM User WHERE Comm_Amount_MTD__c != null and email =';
  static String kAgentTodaysSales =
      '/services/data/v53.0/query/?q=SELECT email,Gross_Sales_MTD__c,Gross_Sales_Yesterday__c, CreatedDate, LastModifiedDate FROM User where email =';
  static String kAgentTodaysCommission =
      '/services/data/v53.0/query/?q=SELECT email,Comm_Amount_MTD__c,Comm_Amount_Yesterday__c, CreatedDate, LastModifiedDate FROM User where email =';
  static String kSmartTriggers = '/services/apexrest/GC_SmartTriggerAPI';

  static String getCustomerSearchByPhone(String phone) {
    return '$kBaseURL$kCustomerSearchByPhone\'$phone\'';
  }

  static String getCustomerSearchByEmail(String email) {
    return '$kBaseURL$kCustomerSearchByEmail\'$email\'';
  }

  static String getCustomerSearchByName(String name, int offset) {
    return '$kBaseURL$kCustomerSearchByName%27$name%25%27 LIMIT 10 OFFSET $offset';
  }

  static String getCustomerAllOrders(String email, int offset) {
    return '$kBaseURL$kCustomerAllOrders${'\'$email\') ORDER BY CreatedDate DESC, LastModifiedDate DESC NULLS LAST LIMIT 20 OFFSET $offset'}';
  }

  static String getCustomerOpenOrders(String email, int offset) {
    return '$kBaseURL$kCustomerOpenOrders${'\'$email\') and Order_Status__c = \'Draft\' ORDER BY CreatedDate DESC, LastModifiedDate DESC NULLS LAST LIMIT 20 OFFSET $offset'}';
  }

  static String getTotalSales(String agentMail) {
    return '$kBaseURL$kAgentTotalSales${'\'$agentMail\' group by name, email'}';
  }

  static String getTodaysSales(String agentMail) {
    return '$kBaseURL$kAgentTodaysSales${'\'$agentMail\''}';
  }

  static String getTotalCommission(String agentMail) {
    return '$kBaseURL$kAgentTotalCommission${'\'$agentMail\' group by name, email'}';
  }

  static String getTodaysCommission(String agentMail) {
    return '$kBaseURL$kAgentTodaysCommission${'\'$agentMail\''}';
  }

  static String getSmartTriggers(){
    return '$kBaseURL$kSmartTriggers';
  }
}
