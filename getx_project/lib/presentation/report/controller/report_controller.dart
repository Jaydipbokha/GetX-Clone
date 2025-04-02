import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utiles/assets.dart';
import '../../../widget/custom_model.dart';

class ReportController extends GetxController {
  List<Map<String, dynamic>> allReportType = [
    {
      'title': 'Order Wise',
      // 'colors': [Color(0xFFDBB5B5), Color(0xFFF1E5D1),],
      // 'colors': [Color(0xFFADB2D4), Color(0xFFC8CAEA)  ],
      'colors': [ Color(0xFFD1D3E6) ,Color(0xFFD1D3E6), ],
      'value' : 'report_order_tab',
      'image' :  AppAssets.orderWise,
    },
    {
      'title': 'Counter Wise',
      // 'colors': [Color(0xB8ADB2D4), Color(0xFFD8EBEC)  ],
      'colors': [ Color(0xFFD1D3E6) ,Color(0xFFD1D3E6), ],
      'value' : 'counter_wise_tab',
      'image' :  AppAssets.counterWise,
    },
    {
      'title': 'Date Wise',
      // 'colors': [Color(0xFF80CBC4), Color(0xFFB4EBE6)  ],
      'colors': [ Color(0xFFD1D3E6) ,Color(0xFFD1D3E6), ],
      'value' : 'date_wise_tab',
      'image' :  AppAssets.dateWise,
    },
    {
      'title': 'Date - Counter Wise',
      // 'colors': [Color(0xFFE69DB8), Color(0xFFFFD0C7)  ],
      // 'colors': [Color(0xFFD1D3E6), Color(0xFFD1D3E6)  ],
      'colors': [ Color(0xFFD1D3E6) ,Color(0xFFD1D3E6), ],
      'value' : 'date_counter_wise_tab',
      'image' :  AppAssets.dateCounterWise,
    },
  ];



  void showDynamicDialog(BuildContext context, String title, String description, Widget stBody) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomModel(title: title, description: description, body: stBody,);
      },
    );
  }

}
