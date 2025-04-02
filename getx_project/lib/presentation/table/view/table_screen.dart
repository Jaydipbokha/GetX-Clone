import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';

import '../../../utiles/assets.dart';
import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_drawer.dart';
import '../../../widget/text_widget.dart';
import '../../order/view/order_screen.dart';
import '../controller/table_controller.dart';
import '../model/table_response_model.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  TableController controller = Get.put(TableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(
        title: AppStrings.table,
        centerTile: true,
        isDrawer: true,
      ),
      body: GetBuilder<TableController>(
          id: 'isLoading',
          builder: (controller) {
            return (controller.isLoading)
                ? Center(child: CircularProgressIndicator(color: AppColors.themeColor,),)
                : Container(
                    color: AppColors.themeColor.withOpacity(0.08),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 7,
                          ),
                          /// Table GridView
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GridView.builder(
                                itemCount: controller.tableData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.1,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 22,
                                ),
                                itemBuilder: (context, index) {
                                  Datum data = controller.tableData[index];
                                  return stTableItemView(data, index);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          }),
    );
  }

  Widget stTableItemView(Datum data, int index) {
    return GetBuilder<TableController>(
      id: 'stTable',
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            Get.to(() => OrderScreen(stTableId: data.id, isEmptyValue: data.isEmpty,))?.then((value){
              if(value == true){
                controller.getTableData();
              }
            });
          },
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(5),
            decoration: data.isEmpty == 1
                ? BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.hintTextColor.withAlpha(30),
                        offset: const Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  )
                : BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColors.tableGraditentColor1.withOpacity(0.4),
                      AppColors.tableGraditentColor2.withOpacity(0.4)
                    ]),
                    border: Border.all(
                      color: AppColors.whiteColor,
                      width: 4,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.hintTextColor.withAlpha(30),
                        offset: const Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
            child: Padding(
              padding:  data.isEmpty != 0
                  ? const EdgeInsets.all(8.0)
                  : const EdgeInsets.all(0.0),
              child:  data.isEmpty  != 0
                  ? DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [6, 3],
                      color: AppColors.themeColor.withOpacity(0.5),
                      strokeWidth: 2,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container( height: 65,  child: Image.asset(AppAssets.normalTable)),
                            CustomText(
                              '${data.name}',
                              color: AppColors.themeColor,
                              fontSize: 27,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                child: Image.asset(
                                  AppAssets.reservedTable,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Column(
                                  children: [
                                    Container( height: 65,  child: Image.asset(AppAssets.fillTable)),
                                    CustomText(
                                        '${data.name}',
                                      color: AppColors.blackColor,
                                      fontSize: 27,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
