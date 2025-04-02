import 'package:flutter/material.dart';

import 'text_widget.dart';

class CustomButton extends StatelessWidget {
  final String? stTitle;
  final Color? stTitleColor;
  final Color? stBackColor;
  final Color? stBorderColor;
  final double? stFontSize;
  final FontWeight? stFontWeight;
  final Function? stFunction;

  const CustomButton({
    super.key,
    this.stTitle,
    this.stTitleColor,
    this.stBackColor,
    this.stFunction,
    this.stFontWeight,
    this.stFontSize,
    this.stBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        stFunction?.call();
      },
      child: Container(
        margin:  const EdgeInsets.symmetric(horizontal: 5),
        padding:  const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: stBackColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1, color: stBorderColor ?? Colors.transparent)
        ),
        child: Center(
          child: CustomText(
            stTitle,
            color: stTitleColor,
            fontSize: stFontSize ?? 16,
            fontWeight: stFontWeight ?? FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
