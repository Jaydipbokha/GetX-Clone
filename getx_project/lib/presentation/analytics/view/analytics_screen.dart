import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/text_widget.dart';
import '../controller/analytics_controller.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AnalyticsController controller = Get.put(AnalyticsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: AppStrings.analytics,
        isBack: true,
        centerTile: true,
      ),
      body: ListView.builder(
        itemCount: controller.allAnalytics.length,
        itemBuilder: (context, index) {
          var data = controller.allAnalytics[index];
        return Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(
                width: 1,
                color: AppColors.themeColor.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: AppColors.hintTextColor.withOpacity(0.1),
                    blurRadius: 7,
                    offset: const Offset(6, 4),
                    spreadRadius: 4)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        data['Count'],
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomText(
                      data['Name'],
                      fontSize: 17,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(data['Image'],),
                ),
              )
            ],
          ),
        );
      },),
    );
  }
}
