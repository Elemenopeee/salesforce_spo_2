abstract class Endpoints {
  static String kBaseURL =
      'https://gcinc--ap.my.salesforce.com/services/data/v53.0/query/?';
  static String kCustomerSearchByPhone =
      'q=SELECT id,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Units__c,Preferred_Instrument__c, Max_ltv_net_dlrs_Formula__c, Median_ltv_net_dlrs_Formula__c, Avg_ltv_net_dlrs_Formula__c from account where accountPhone__c=';
  static String kCustomerSearchByEmail =
      'q=SELECT id,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Units__c,Preferred_Instrument__c, Max_ltv_net_dlrs_Formula__c, Median_ltv_net_dlrs_Formula__c, Avg_ltv_net_dlrs_Formula__c from account where accountEmail__c=';
  static String kCustomerSearchByName =
      'q=SELECT id,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Units__c,Preferred_Instrument__c, Max_ltv_net_dlrs_Formula__c, Median_ltv_net_dlrs_Formula__c, Avg_ltv_net_dlrs_Formula__c from account where name like ';
  static String kCustomerAllOrders =
      'q=SELECT Id,First_Name__c,Last_Name__c,OrderNumber__c,Total_Amount__c,Commission_JSON__c, Rollup_Count_Order_Line_Items__c,CreatedDate,LastModifiedDate FROM GC_Order__c';
  static String kCustomerOpenOrders = 'q=SELECT Id,Order_Number__c, First_Name__c,Last_Name__c,LastModifiedDate,CreatedDate,Total_Amount__c,Commission_JSON__c, Rollup_Count_Order_Line_Items__c,Order_Status__c FROM GC_Order__c where Order_Status__c = \'draft\'';
  static String kAgentTotalSales = 'q=SELECT SUM(Gross_Sales_MTD__c) FROM User';
  static String kAgentTotalCommission = 'q=SELECT SUM(Comm_Amount_MTD__c) FROM User';
  static String kAgentTodaysSales = 'q=SELECT Gross_Sales_MTD__c, CreatedDate, LastModifiedDate FROM User where createddate =last_n_days : 1';
  static String kAgentTodaysCommission = 'q=SELECT Comm_Amount_MTD__c,CreatedDate, LastModifiedDate FROM User where createddate =last_n_days : 1';

  static String getCustomerSearchByPhone(String phone) {
    return '$kBaseURL$kCustomerSearchByPhone\'$phone\'';
  }

  static String getCustomerSearchByEmail(String email) {
    return '$kBaseURL$kCustomerSearchByEmail\'$email\'';
  }

  static String getCustomerSearchByName(String name) {
    return '$kBaseURL$kCustomerSearchByName%27%25$name%25%27';
  }

  static String getCustomerAllOrders() {
    return '$kBaseURL$kCustomerAllOrders';
  }

  static String getCustomerOpenOrders(){
    return '$kBaseURL$kCustomerOpenOrders';
  }

  static String getTotalSales(){
    return '$kBaseURL$kAgentTotalSales';
  }

  static String getTodaysSales(){
    return '$kBaseURL$kAgentTodaysSales';
  }

  static String getTotalCommission(){
    return '$kBaseURL$kAgentTotalCommission';
  }

  static String getTodaysCommission(){
    return '$kBaseURL$kAgentTodaysCommission';
  }

}
