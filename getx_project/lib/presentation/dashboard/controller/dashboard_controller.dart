import 'package:get/get.dart';

import '../../../utiles/assets.dart';

class DashboardController extends GetxController {

  int selectedIndex = 0;

  final List<Map<String, String>> categories = [
    {"name": "All", "image": AppAssets.all},
    {"name": "Coffee", "image": AppAssets.coffee},
    {"name": "Desserts", "image": AppAssets.desserts},
    {"name": "Rice", "image": AppAssets.rice},
  ];

  final List<Map<String, String>> items = [
    {"name": "Dhosa", "price": "250", "image": AppAssets.dosa},
    {"name": "Gulab Jambu","price": "50", "image": AppAssets.gulabJambu},
    {"name": "Ladu","price": "20", "image": AppAssets.ladu},
    {"name": "Piza","price": "750", "image": AppAssets.piza},
  ];


}