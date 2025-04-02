import 'package:get/get.dart';

import '../../../utiles/assets.dart';

class AnalyticsController extends GetxController {
  List<dynamic> allAnalytics = [
    {"Name": 'Total Order', "Count" : "123", "Image": AppAssets.totalOrder},
    {"Name": 'Total Sale',"Count" : "250", "Image": AppAssets.totalSales},
    {"Name": 'Total Expense',"Count" : "5620","Image" : AppAssets.totalExpence},
    {"Name": 'Total Discount',"Count" : "100", "Image" : AppAssets.totalDiscount},
    {"Name": 'Average Sale',"Count" : "956.54", "Image" : AppAssets.totalAvarageSales},
    {"Name": 'Cancel Order',"Count" : "5", "Image" : AppAssets.totalCancleOrder},
    {"Name": 'Taxes',"Count" : "47.55", "Image" : AppAssets.totalTax},
  ];
}
