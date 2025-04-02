import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/get_storage_constant.dart';
import '../../../main.dart';
import '../../../utiles/assets.dart';
import '../../../utiles/color.dart';
import '../../login/view/login_screen.dart';
import '../../table/view/table_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (localData.read(GetStorageConstant.token) != null) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Get.offAll(() => const TableScreen());
        },
      );
    }else{
      Future.delayed(
        const Duration(seconds: 1),
            () {
          Get.offAll(() => const LoginScreen());
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Center(
          child: Image.asset(AppAssets.appName, width: Get.width * 0.7),
        ),
      ),
    );
  }
}
