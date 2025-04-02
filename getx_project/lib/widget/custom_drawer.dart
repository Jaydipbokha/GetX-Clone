import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation/analytics/view/analytics_screen.dart';
import '../presentation/bill/view/bill_screen.dart';
import '../presentation/order/view/order_screen.dart';
import '../presentation/report/view/report_screen.dart';
import '../presentation/table/controller/table_controller.dart';
import '../presentation/table/view/table_screen.dart';
import '../utiles/assets.dart';
import '../utiles/color.dart';
import '../utiles/string.dart';
import 'text_widget.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  TableController controller = Get.put(TableController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Container(
              height: 180,
              width: Get.width,
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  CustomText('Axone POS')
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      drawerMenu(
                          title: AppStrings.drawerTable,
                          icon: AppAssets.drawerTable,
                          function: () {
                            Get.back();
                            Get.to(() => TableScreen());
                          }),
                      drawerDivider(),
                      drawerMenu(
                          title: AppStrings.drawerBill, icon: AppAssets.drawerBill, function: () {
                        Get.back();
                        Get.to(() => BillScreen());
                      }),
                      drawerDivider(),
                      drawerMenu(
                          title: AppStrings.drawerOrder, icon: AppAssets.drawerOrder , function: () {
                        Get.back();
                        Get.to(() => OrderScreen(stTableId: 1,));
                      }),
                      drawerDivider(),
                      drawerMenu(
                          title: AppStrings.drawerReport, icon: AppAssets.drawerReport, function: () {
                        Get.back();
                        Get.to(() => ReportScreen());
                      }),
                      drawerDivider(),
                      drawerMenu(
                          title: AppStrings.drawerAnalytics, icon: AppAssets.drawerAnalitics , function: () {
                        Get.back();
                        Get.to(() => AnalyticsScreen());
                      }),
                      drawerDivider(),
                      drawerMenu(
                          title: AppStrings.drawerLogout, icon: AppAssets.drawerLogout , function: () {
                        Get.back();
                        controller.logoutUser();
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: Get.width,
              color: AppColors.themeColor.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText('Restaurant POS', fontSize: 14,),
                  CustomText('1.0.1', fontSize: 14,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerMenu({String? icon, String? title, Function? function}) {
    return GestureDetector(
      onTap: () {
        function!();
      },
      child: Container(
        height: 40,
        child: Row(
          children: [
            Image.asset(
              icon!,
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: CustomText(title, color: AppColors.blackColor, fontSize: 16,),
            )
          ],
        ),
      ),
    );
  }

  Widget drawerDivider() {
    return Divider(
      thickness: 0.5,
      indent: 2,
      endIndent: 2,
      color: AppColors.hintTextColor,
    );
  }
}
