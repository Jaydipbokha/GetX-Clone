import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/text_widget.dart';
import '../../report_detail/view/report_detail_screen.dart';
import '../controller/report_controller.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: AppStrings.report,
        isBack: true,
        centerTile: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15,right: 8, left: 8),
          child: Container(
            child: ListView.builder(
              itemCount: controller.allReportType.length,
              itemBuilder: (context, index) {
                var data = controller.allReportType[index];
                return stAllReportItem(data);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget stAllReportItem(Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, right: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: List<Color>.from(data['colors']),
            // Retrieve colors from the map
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              offset: const Offset(2, 5),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          data['title'],
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors
                              .black.withOpacity(0.7), // Ensure visibility on colored backgrounds
                        ),
                        SizedBox(height: 12,),
                        GestureDetector(
                          onTap: (){
                            Get.to(ReportDetailScreen(stReportType: data['title'], stReportValue: data['value'],));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors
                                    .black.withOpacity(0.7)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: CustomText(
                              'View',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors
                                  .black.withOpacity(0.7), // Ensure visibility on colored backgrounds
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 80, minHeight: 70, maxWidth: 100),
                      child: Image.asset(
                        data['image'],
                        color: Colors.black.withOpacity(0.7),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* CustomButton(
              stTitle: AppStrings.view,
              stTitleColor: AppColors.whiteColor,
              stBackColor: AppColors.themeColor,
              stFunction: () {
                controller.showDynamicDialog(
                    context, data['title'].toString(), '', Container());
              },
            ),*/
          ],
        ),
      ),
    );
  }
}
