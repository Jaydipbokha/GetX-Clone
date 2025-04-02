import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'constant/constant.dart';
import 'constant/package_info_constant.dart';
import 'presentation/bill/view/bill_screen.dart';
import 'presentation/dashboard/view/dashboard_screen.dart';
import 'presentation/splash/view/splash_screen.dart';
import 'presentation/table/view/table_screen.dart';
import 'utiles/assets.dart';
import 'utiles/color.dart';

final localData = GetStorage();
final rememberMeData = GetStorage('rememberMeData');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PackageInformation.getBuildInfo();
  await GetStorage.init();
  await GetStorage.init('rememberMeData');
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
  // runApp(const MyApp());
}
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const DashboardScreen(),
       BillScreen(),
      const TableScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(AppAssets.order),
        title: "Order",
        textStyle: TextStyle(fontFamily: AppConstant.rubik),
        activeColorPrimary: AppColors.themeColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(AppAssets.bill),
        title: "Bill",
        textStyle: TextStyle(fontFamily: AppConstant.rubik),
        activeColorPrimary: AppColors.themeColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(AppAssets.table),
        title: "Table",
        textStyle: TextStyle(fontFamily: AppConstant.rubik),
        activeColorPrimary: AppColors.themeColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style9, // Choose the nav bar style
    );
  }
}

