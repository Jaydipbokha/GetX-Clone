import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utiles/color.dart';
import 'text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Function? function;
  final bool? centerTile;
  final bool isDrawer;
  final bool isBack;
  final PreferredSizeWidget? bottomWidget;
  final Widget? isActionWidget;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.function,
    this.centerTile,
    this.bottomWidget,
    this.isActionWidget,
    this.isBack = false,
    this.isDrawer = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTile ?? false,
      backgroundColor: AppColors.themeColor,
      iconTheme: IconThemeData(color: AppColors.blackColor),
      elevation: 3,
      title: (title!=null)?CustomText(title, color: AppColors.blackColor,):titleWidget,
      actions: isActionWidget != null ? [isActionWidget!] : [],
      actionsIconTheme: IconThemeData(color: AppColors.whiteColor),
      leading: isDrawer
          ? InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: AppColors.blackColor,
              ),
            )
          : isBack
              ? InkWell(
                  onTap: () {
                    if (function != null) {
                      function!();
                    } else {
                      Get.back();
                    }
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.blackColor,
                    size: 20,
                  ),
                )
              : null,
      bottom: bottomWidget != null
          ? PreferredSize(
              preferredSize: bottomWidget!.preferredSize,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: bottomWidget!,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottomWidget?.preferredSize.height ?? 0),
      );
}
