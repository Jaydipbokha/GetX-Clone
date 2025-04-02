import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/constant.dart';
import '../../../utiles/color.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/text_widget.dart';
import '../controller/dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CustomAppBar(
        title: 'Restaurant Pos',
        centerTile: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  "Category",
                  color: AppColors.blackColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 1,
              ),

              /// Category List view
              Container(
                height: 101,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = controller.categories[index];
                    return GetBuilder<DashboardController>(
                        id: 'category',
                        builder: (controller) {
                          return GestureDetector(
                            onTap: () {
                              controller.selectedIndex = index;
                              controller.update(['category']);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              padding: const EdgeInsets.only(
                                  bottom: 8, top: 8, left: 15, right: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.whiteColor,
                                border: Border.all(
                                    color: controller.selectedIndex == index
                                        ? AppColors.themeColor.withOpacity(0.8)
                                        : AppColors.transparentColor,
                                    width: controller.selectedIndex == index
                                        ? 1
                                        : 0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.hintTextColor.withAlpha(50),
                                    offset: const Offset(0, 3.5),
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 40,
                                      width: Get.width * 0.14,
                                      child: Image.asset(data['image']!)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomText(
                                    data['name'].toString(),
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              /// Item Search Bar
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  style: TextStyle(fontFamily: AppConstant.rubik),
                  decoration: InputDecoration(
                      hintText: 'Search Item',
                      hintStyle: TextStyle(
                          color: AppColors.hintTextColor.withOpacity(0.8),
                          fontSize: 16,
                          fontFamily: AppConstant.rubik,
                          fontWeight: FontWeight.w400),
                      fillColor: AppColors.whiteColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.hintTextColor.withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.hintTextColor.withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.hintTextColor.withOpacity(0.8),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      suffixIcon: Container(
                        decoration: BoxDecoration(
                          color: AppColors.themeColor,
                          // Change to your desired background color
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 12, right: 20, left: 10),
                        child: const Icon(
                          Icons.search_rounded,
                          color:
                              Colors.white, // Change the icon color as needed
                        ),
                      ),
                      suffixIconColor: AppColors.whiteColor,
                      suffixIconConstraints: const BoxConstraints(
                        maxWidth: 40,
                      )),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  "Item",
                  color: AppColors.blackColor,
                  fontSize: 18,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              /// Item GirdView
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    itemCount: controller.items.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.82,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = controller.items[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              width: 1, color: AppColors.hintTextColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.hintTextColor.withAlpha(30),
                              offset: const Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: Image.asset(
                                  data['image']!,
                                  fit: BoxFit.cover,
                                  width: double
                                      .infinity, // Ensures it takes the full width
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                children: [
                                  CustomText(
                                    data['name'],
                                    color: AppColors.blackColor,
                                    fontSize: 13,
                                  ),
                                  CustomText(
                                    '₹' + data['price'],
                                    color: AppColors.blackColor,
                                    fontSize: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15,right: 15,bottom: 7,top: 3),
                                    padding : const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: const BorderRadius.all(Radius.circular(4))),
                                    width: Get.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomText("Add Item", color: AppColors.whiteColor, fontSize: 13, textAlign: TextAlign.center,),
                                        Icon(Icons.add, color: AppColors.whiteColor, size: 17,)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
