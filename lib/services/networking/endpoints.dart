abstract class Endpoints {
  static String kBaseURL = 'https://gcinc--tracuat.my.salesforce.com';
  static String kCustomerSearchByPhone =
      '/services/data/v53.0/query/?q=SELECT id,name,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Sales_Transactions__c,Primary_Instrument_Category__c,epsilon_customer_brand_key__c from account where accountPhone__c=';
  static String kCustomerSearchByEmail =
      '/services/data/v53.0/query/?q=SELECT id,name,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Sales_Transactions__c,Primary_Instrument_Category__c,epsilon_customer_brand_key__c from account where accountEmail__c=';
  static String kCustomerSearchByName =
      '/services/data/v53.0/query/?q=SELECT id,name,firstname,lastname,accountEmail__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Sales_Transactions__c,Primary_Instrument_Category__c from account where name like ';
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
  static String kClientPromos =
      '/services/data/v53.0/query/?q=SELECT CreatedBy.Name,CreatedDate,Subject FROM EmailMessage where RelatedToId = ';
  static String kClientNoteByID =
      '/services/data/v53.0/query/?q=SELECT Id,ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = ';
  static String kClientNotes =
      '/services/data/v53.0/query/?q=SELECT Id, Title, FileType, TextPreview, Content, LastModifiedBy.Name,CreatedDate,LastModifiedDate FROM ContentNote WHERE Id IN  ';
  static String kClientActivity =
      '/services/data/v53.0/query/?q=SELECT Id, ActivityDate, Priority, WhatId,What.Name,Owner.Name, Status, Subject, TaskSubtype, Type,CompletedDateTime FROM Task WHERE WhatId = ';
  static String kClientOpenOrders =
      '/services/data/v53.0/query/?q=select Id,Name, CreatedDate,Total__c,Order_Number__c,(select Image_URL1__c  from GC_Order_Line_Items__r) from GC_Order__c where Customer__c = ';
  static String kClientOrderHistory =
      '/services/data/v53.0/query/?q=select Id,Name, CreatedDate,Total__c,Order_Number__c,Order_Status__c,(select Image_URL__c  from GC_Order_Line_Items__r) from GC_Order__c where Customer__c = ';
  static String kClientBasicDetails =
      '/services/data/v53.0/query/?q=SELECT id,name,firstname,lastname,accountEmail__c,Brand_Code__c,accountPhone__c,Last_Transaction_Date__c,Lifetime_Net_Sales_Amount__c,Lifetime_Net_Sales_Transactions__c,Primary_Instrument_Category__c, (select Total_Amount__c from GC_Orders__r  where Order_Status__c = \'Completed\' Order by lastmodifieddate desc limit 1)epsilon_customer_brand_key__c,Lessons_Customer__c,Open_Box_Purchaser__c,Loyalty_Customer__c,Used_Purchaser__c,Synchrony_Customer__c,Vintage_Purchaser__c  from account where Id=';
  static String kClientBuyAgain =
      '/services/data/v53.0/query/?q=SELECT id,lastmodifieddate,Order_Status__c,Customer__c,(select id, GC_Order__r.Site_Id__c,GC_Order__r.Name, GC_Order__c, GC_Order__r.Customer__r.PersonEmail,Description__c, Item_Id_formula__c, PIM_Sku__c , Item_Id__c, Condtion__c, Image_URL__c, Item_Price__c, Quantity__c, Warranty_Id__c, Warranty_Name__c,Warranty_price__c, Item_SKU__c,Warranty_style__c, Warranty_Enterprise_SkuId__c from GC_Order_Line_Items__r where Status__c != \'Deleted\') FROM GC_Order__c where Customer__c = ';
  static String kClientCartByID =
      '/services/data/v53.0/query/?q=SELECT Id, Customer__c,Cart_Sku_1__c, Cart_Sku_2__c, Cart_Sku_3__c, Cart_Sku_4__c, Cart_Sku_5__c, Cart_Sku_6__c, Cart_Sku_7__c, Cart_Sku_8__c, Cart_Sku_9__c FROM Lead where epsilon_customer_brand_key__c = ';
  static String kClientCartProduct =
      '/services/data/v53.0/query/?q=SELECT id,Brand__c,Name,Vender_Name__c,Standard_Unit_Cost__c,ProductImage__c FROM Product2 WHERE Item_ID__c in ';
  static String kClientPurchaseChannelAndCategory =
      'https://guitarcenter-prod.apigee.net/cc/v1/customer/';
  static String kClientBrowsingHistoryRecentlyViewedIds =
      '/services/data/v53.0/query/?q=SELECT Id,Name,Type,LastReferencedDate,LastViewedDate FROM RecentlyViewed WHERE Type = \'Product2\'';
  static String kClientBrowsingHistoryProducts =
      '/services/data/v53.0/query/?q=select id,Brand__c,Name,Vender_Name__c,Standard_Unit_Cost__c,ProductImage__c FROM Product2 WHERE Id in ';
  static String kClientOpenCases =
      '/services/data/v53.0/query/?q=SELECT CaseNumber,Case_Subtype__c,Case_Type__c,DAX_Order_Number__c,Id,Priority,Reason,Subject,Status,Account.Name,Owner.Name,CreatedDate,LastModifiedDate FROM Case where AccountId = ';
  static String kClientClosedCases =
      '/services/data/v53.0/query/?q=SELECT CaseNumber,Case_Subtype__c,Case_Type__c,DAX_Order_Number__c,Id,Priority,Reason,Subject,Status,Account.Name,Owner.Name,CreatedDate,LastModifiedDate FROM Case where AccountId = ';

  static String getCustomerSearchByPhone(String phone) {
    return '$kBaseURL$kCustomerSearchByPhone\'$phone\'';
  }

  static String getCustomerSearchByEmail(String email) {
    return '$kBaseURL$kCustomerSearchByEmail\'$email\'';
  }

  static String getCustomerSearchByName(String name, int offset) {
    return '$kBaseURL$kCustomerSearchByName%27$name%25%27 LIMIT 20 OFFSET $offset';
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

  static String getClientOpenCases(String accountId) {
    return '$kBaseURL$kClientOpenCases\'$accountId\'  and status not in (\'Closed\',\'Auto-Closed\',\'Resolved\') limit 2 offset 0';
  }

  static String getClientPromos(String relatedToId) {
    return '$kBaseURL$kClientPromos${'\'$relatedToId\''}';
  }

  static String getClientNotesById(String linkedEntityId) {
    return '$kBaseURL$kClientNoteByID${'\'$linkedEntityId\''}';
  }

  static String getClientNotes(List<String> noteIds) {
    var noteIdsString = '';

    for (var id in noteIds) {
      var insertIds = '\'$id\'';
      noteIdsString = noteIdsString + insertIds + ',';
    }

    if (noteIdsString.isNotEmpty) {
      noteIdsString = noteIdsString.substring(0, noteIdsString.length - 1);
    }

    return '$kBaseURL$kClientNotes${'($noteIdsString)'}';
  }

  static String getClientBuyAgain(String customerId) {
    return '$kBaseURL$kClientBuyAgain\'$customerId\' and Order_Status__c = \'Completed\' Order by lastmodifieddate desc limit 1';
  }

  static String getClientCartById(String customerId) {
    return '$kBaseURL$kClientCartByID${'\'$customerId\''}';
  }

  static String getClientCart(String cartsId) {
    return '$kBaseURL$kClientCartProduct${'($cartsId)'}';
  }

  static String getClientActivity(String clientId) {
    return '$kBaseURL$kClientActivity${'\'$clientId\''}';
  }

  static String getClientOpenOrders(String clientId) {
    return '$kBaseURL$kClientOpenOrders${'\'$clientId\' and Order_Status__c = \'Draft\' ORDER BY createddate desc limit 2 OFFSET 0'}';
  }

  static String getClientOrderHistory(String clientId) {
    return '$kBaseURL$kClientOrderHistory${'\'$clientId\' and Order_Status__c!= \'Draft\' ORDER BY createddate desc limit 2 OFFSET 0'}';
  }

  static String getClientBasicDetails(String clientId) {
    return '$kBaseURL$kClientBasicDetails${'\'$clientId\''}';
  }

  static String getClientPurchaseChannelAndCategory(String epsilonCustomerKey) {

    var editedKey = epsilonCustomerKey.replaceAll('GC_', '');

    return '$kClientPurchaseChannelAndCategory' '$epsilonCustomerKey/txn/hist';
  }

  static String getClientBrowsingHistoryProductIDs() {
    return '$kBaseURL$kClientBrowsingHistoryRecentlyViewedIds';
  }

  static String getClientRecentlyViewedProducts(List<String> productIDs) {
    var productIdsString = '';

    for (var id in productIDs) {
      var insertIds = '\'$id\'';
      productIdsString = productIdsString + insertIds + ',';
    }

    if (productIdsString.isNotEmpty) {
      productIdsString =
          productIdsString.substring(0, productIdsString.length - 1);
    }

    return '$kBaseURL$kClientBrowsingHistoryProducts($productIdsString)';
  }

  static String getClientClosedCases(String accountId) {
    return '$kBaseURL$kClientClosedCases\'$accountId\'  and status in (\'Closed\',\'Resolved\') and Case_Type__c!=null limit 20 offset 0';
  }
}
