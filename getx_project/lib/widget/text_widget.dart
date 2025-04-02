import 'package:flutter/cupertino.dart';

import '../constant/constant.dart';

class CustomText extends StatelessWidget {
  String? text;
  Color? color;
  double? fontSize;
  String? fontFamily;
  TextAlign? textAlign;
  FontWeight ? fontWeight;

  CustomText(this.text,
      {super.key, this.color, this.fontSize, this.fontFamily, this.textAlign, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: fontSize ?? 18,
        fontFamily: fontFamily ?? AppConstant.rubik, fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
