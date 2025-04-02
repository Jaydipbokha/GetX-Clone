import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_textfiled.dart';
import '../../../widget/snack_bar.dart';
import '../../../widget/text_widget.dart';
import '../../bill/model/bill_preview_response_model.dart';
import '../controller/report_detail_controller.dart';

class ReportDetailScreen extends StatefulWidget {
  String? stReportType;
  String? stReportValue;

  ReportDetailScreen({super.key, this.stReportType, this.stReportValue});

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  late SalesDataSource salesDataSource;

  late ReportDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ReportDetailController(stType: widget.stReportValue));
    salesDataSource = SalesDataSource(context, controller.salesData);
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: widget.stReportType,
        centerTile: true,
      ),
      body: Column(
        children: [
          // Date Picker Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomTextFiled(
                    controller: controller.fromDateController,
                    stTitle: "From Date",
                    keyboardType: TextInputType.text,
                    hintText: 'DD-MM-YYYY',
                    isReadOnly: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _selectDate(context, controller.fromDateController);
                      },
                      child: const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.calendar_today,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                    child: CustomTextFiled(
                  controller: controller.toDateController,
                  stTitle: "To Date",
                  keyboardType: TextInputType.text,
                  hintText: 'DD-MM-YYYY',
                  isReadOnly: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _selectDate(context, controller.toDateController);
                    },
                    child: const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.calendar_today,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                )),
                // SizedBox(width: 10),

                // Search Button
                Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 5),
                  decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: IconButton(
                    icon: const Icon(Icons.search, size: 30),
                    onPressed: () {
                      if (controller.fromDateController.text.isEmpty) {
                        showSnakBar(1, msg: 'Please Select The From Date');
                      } else if (controller.toDateController.text.isEmpty) {
                        showSnakBar(1, msg: 'Please Select The To Date');
                      } else {
                        controller.getReportData();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // Data Grid
          Expanded(
            child: GetBuilder<ReportDetailController>(
                id: 'stOrderData',
                builder: (controller) {
                  if (controller.isLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: AppColors.themeColor));
                  }
                  else if(controller.salesData.isEmpty){
                    return Center(child: CustomText('No Record Found'),);
                  }

                  salesDataSource = SalesDataSource(context, controller.salesData);

                  return SfDataGrid(
                    source: salesDataSource,
                    columnWidthMode: ColumnWidthMode.fill,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    gridLinesVisibility: GridLinesVisibility.both,
                    columns: [
                      GridColumn(
                          columnName: 'No', label: buildHeaderCell('No.')),
                      GridColumn(
                          columnName: 'Sale Date',
                          label: buildHeaderCell('Sale Date')),
                      GridColumn(
                          columnName: 'Order No',
                          label: buildHeaderCell('Order No.')),
                      GridColumn(
                          columnName: 'Cash', label: buildHeaderCell('Cash')),
                      GridColumn(
                          columnName: 'Online',
                          label: buildHeaderCell('Online')),
                      GridColumn(
                          columnName: 'Total', label: buildHeaderCell('Total')),
                      GridColumn(
                          columnName: 'Action',
                          label: buildHeaderCell('Action')),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.themeColor, // Header Background Color
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class SalesDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];

  ReportDetailController controller = Get.put(ReportDetailController());
  final ScrollController _scrollController =
  ScrollController(); // ScrollController added
  BuildContext context;

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose of the controller to avoid memory leaks
    super.dispose();
  }

  SalesDataSource(this.context, List<SalesData> salesData) {
    dataGridRows = salesData
        .map<DataGridRow>((data) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'No', value: data.invoiceNumber),
              DataGridCell<String>(
                  columnName: 'Sale Date', value: data.saleDate),
              DataGridCell<String>(
                  columnName: 'Order No', value: data.invoiceNumber),
              DataGridCell<double>(columnName: 'Cash', value: data.cashAmount),
              DataGridCell<double>(
                  columnName: 'Online', value: data.onlineAmount),
              DataGridCell<double>(columnName: 'Total', value: data.netAmount),
              DataGridCell<Widget>(
                columnName: 'Action',
                value: IconButton(
                  icon: Icon(Icons.shopping_bag),
                  onPressed: () {
                    controller.getViewBill(stOrderId: data.invoiceNumber.replaceAll('#', ''));
                    controller.showDynamicDialog(
                      context,
                      'Bill Preview',
                      "",
                      LayoutBuilder(builder: (context, constraints) {
                        return Container(
                          color: Colors.white,
                          constraints: BoxConstraints(
                            maxHeight: Get.height * 0.5,
                            minHeight: Get.height * 0.2,
                          ),
                          child: GetBuilder<ReportDetailController>(
                            id: 'isLoadingOrderData',
                            builder: (context) {
                              if(controller.isLoadingViewBill){
                                return Center(child: CircularProgressIndicator(color: AppColors.themeColor,),);
                              }
                              if(controller.stBillPreviewModel?.data == null){
                                return Center(child: CustomText(
                                  'No Item Added In Order',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ));
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment:
                                    Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        'Table: ${controller.stBillPreviewModel?.data!.tablename ?? ''}',
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  /// Order Detail
                                  stBillInfoRow(AppStrings.billOrderNo, '${controller.stBillPreviewModel?.data!.orderNo ?? '-'}'),
                                  stBillInfoRow(AppStrings.billDate, '${controller.stBillPreviewModel?.data!.date ?? '-'}'),
                                  stBillInfoRow(AppStrings.billName, '${controller.stBillPreviewModel?.data!.customerName ?? '-'}'),
                                  stBillInfoRow(AppStrings.billMobile, '${controller.stBillPreviewModel?.data!.mobile ?? '-'}'),
                                  SizedBox(height: 10,),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 15),
                                    decoration: BoxDecoration(
                                      color: AppColors.themeColor,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(5),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            AppStrings.Item,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              CustomText(
                                                AppStrings.Qty,
                                                color: AppColors.whiteColor,
                                              ),
                                              CustomText(
                                                AppStrings.Amount,
                                                color: AppColors.whiteColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Scrollbar(
                                      controller: _scrollController,
                                      // Provide the ScrollController
                                      thickness: 5,
                                      // Scrollbar thickness
                                      radius: const Radius.circular(10),
                                      // Rounded scrollbar
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: AlwaysScrollableScrollPhysics(), // Disable ListView scrolling
                                        itemCount: controller.stBillPreviewModel!.data!.items.length,
                                        itemBuilder: (context, index) {
                                           var data = controller.stBillPreviewModel!.data!.items[index];
                                          return stOrderItemView(data);
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                                    decoration: BoxDecoration(
                                        color: AppColors.themeColor.withOpacity(0.2),
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5))),
                                    child: Row(
                                      children: [
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                          child: GetBuilder<ReportDetailController>(
                                              id: 'stBillItem',
                                              builder: (context) {
                                                return Column(
                                                  children: [
                                                    stRowBillFooter(AppStrings.SubTotal, '₹' +'${controller.stBillPreviewModel?.data!.subtotal ?? ''}'),
                                                    stRowBillFooter(AppStrings.CGST, '₹' +'${controller.stBillPreviewModel?.data!.cgst ?? ''}'),
                                                    stRowBillFooter(AppStrings.SGST,'₹' +'${controller.stBillPreviewModel?.data!.sgst ?? ''}'),
                                                    stRowBillFooter(AppStrings.Discount, '₹' +'${controller.stBillPreviewModel?.data!.discount ?? ''}'),
                                                    stRowBillFooter(
                                                      AppStrings.RoundUp,
                                                      '₹' +'${controller.stBillPreviewModel?.data!.round ?? ''}',
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        CustomText(
                                                          AppStrings.Total,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                        CustomText(
                                                          '₹' +'${controller.stBillPreviewModel?.data!.total ?? ''}',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          ), // If no items, show an empty widget
                        );
                      }),
                      "Cancel",
                      "Print Bill",
                      () {},
                    );
                  },
                ),
              ),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor =
        rowIndex.isEven ? Colors.white : Colors.grey.shade200;
    return DataGridRowAdapter(
      color: backgroundColor,
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'Action') {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: dataCell.value,
          );
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(dataCell.value.toString(),
              style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
    );
  }

  Widget stOrderItemView(Item data) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 7, left: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.name ?? '',
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.quantity.toString() ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    '₹ '+ data.amount.toString(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget stRowBillFooter(String stTitle, String stValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          stTitle,
          // AppStrings.SubTotal,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        CustomText(
          // '227.00',
          stValue,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ],
    );
  }

  Widget stBillInfoRow(String stTitle, String stValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomText(
              stTitle,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 7,
            child: CustomText(
              stValue,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

}
