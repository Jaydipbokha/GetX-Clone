
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../utiles/color.dart';

class CustomAppbarTextfield extends StatelessWidget {
  TextEditingController? controller;
  final Function(String)? onSearch;
   CustomAppbarTextfield({super.key, this.controller, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      style: TextStyle(fontFamily: AppConstant.rubik),
      decoration: InputDecoration(
          filled: true,
          hintText: "Search Item, Category..",
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: AppColors.hintTextColor, fontFamily: AppConstant.rubik  ),
          border: InputBorder.none,
          fillColor: AppColors.whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          suffixIcon: Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: AppColors.transparentColor),
          ),
          focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: AppColors.transparentColor),)
      ),
      onFieldSubmitted: (value){
        if (onSearch != null) {
          onSearch!(value); // Call the API function
        }
      },
      onChanged: (value) {
        print("Searching for: $value");
      },
    );
  }
}
