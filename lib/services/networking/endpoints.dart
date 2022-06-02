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
  static String kClientCases =
      '/services/data/v53.0/query/?q=SELECT CaseNumber,Case_Subtype__c,Case_Type__c,DAX_Order_Number__c,Id,Priority,Reason,Status,Account.Name,Owner.Name,CreatedDate,LastModifiedDate FROM Case where AccountId =';
  static String kClientPromos =
      '/services/data/v53.0/query/?q=SELECT CreatedBy.Name,CreatedDate,Subject FROM EmailMessage where RelatedToId = ';
  static String kClientNoteByID =
      '/services/data/v53.0/query/?q=SELECT Id,ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = ';
  static String kClientNotes =
      '/services/data/v53.0/query/?q=SELECT Id, Title, FileType, TextPreview, Content FROM ContentNote WHERE Id IN ';
  static String kClientActivity =
      '/services/data/v53.0/query/?q=SELECT Id, ActivityDate, Priority, WhatId,What.Name,Owner.Name, Status, Subject, TaskSubtype, Type,CompletedDateTime FROM Task WHERE WhatId = ';
  static String kClientOpenOrders =
      '/services/data/v53.0/query/?q=select Id,Name, CreatedDate,Total__c,(select Image_URL1__c  from GC_Order_Line_Items__r) from GC_Order__c where Customer__c = ';

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

  static String getClientCases(String accountId) {
    return '$kBaseURL$kClientCases${'\'$accountId\''}';
  }

  static String getClientPromos(String relatedToId) {
    return '$kBaseURL$kClientPromos${'\'$relatedToId\''}';
  }

  static String getClientNotesById(String relatedToId) {
    return '$kBaseURL$kClientNoteByID${'\'$relatedToId\''}';
  }

  static String getClientNotes(String relatedToId) {
    return '$kBaseURL$kClientNotes${'\'$relatedToId\''}';
  }

  static String getClientActivity(String clientId) {
    return '$kBaseURL$kClientActivity${'\'$clientId\''}';
  }

  static String getClientOpenOrders(String clientId){
    return '$kBaseURL$kClientOpenOrders${'\'$clientId\' and Order_Status__c = \'Draft\' ORDER BY createddate desc limit 2 OFFSET 0'}';
  }

}
