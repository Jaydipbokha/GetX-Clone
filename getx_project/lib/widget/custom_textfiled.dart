import 'package:flutter/material.dart';

import '../utiles/color.dart';
import 'text_widget.dart';

class CustomTextFiled extends StatelessWidget {
  String? stTitle;
  TextEditingController? controller;
  String? hintText;
  Widget? suffixIcon;
  bool? isObSecure;
  TextInputType? keyboardType;
  bool? isRequired;
  final String? Function(String?)? validator;
  bool? isReadOnly;

  CustomTextFiled(
      {super.key,
      this.stTitle,
        this.suffixIcon,
      this.controller,
        this.isObSecure,
      this.hintText,
        this.validator,
      this.keyboardType,
      this.isRequired, this.isReadOnly = false });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        stTitle != ''
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomText(
                  stTitle,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ))
            : const SizedBox(),
        TextFormField(
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          validator: validator,
          obscureText: isObSecure ?? false,
          readOnly: isReadOnly ?? false,
          decoration: InputDecoration(
            suffixIcon:suffixIcon!=null ?Container(child: suffixIcon):null,
            suffixIconConstraints: const BoxConstraints(
                minWidth: 0, maxWidth: 40, minHeight: 20, maxHeight: 40),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            counter: const SizedBox(
              height: 0,
              width: 0,
            ),

            counterStyle: const TextStyle(fontSize: 0),
            hintText: "${hintText!}${(isRequired ?? false) ? "*" : ""}",
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.hintTextColor),
            border:  OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                  color: AppColors.hintTextColor
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: AppColors.hintTextColor
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            errorStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.redColor),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.redColor, ),
              borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
          ),
        ),
      ],
    );
  }
}


class CustomDropdownField extends StatelessWidget {
  final String? stTitle;
  final List<String>? dropdownItems;
  final String? selectedValue;
  final Function(String?)? onChanged;
  final bool? isRequired;
  final String? Function(String?)? validator;

  CustomDropdownField({
    super.key,
    this.stTitle,
    this.dropdownItems,
    this.selectedValue,
    this.onChanged,
    this.isRequired,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stTitle != null && stTitle!.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CustomText(
              stTitle,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        DropdownButtonFormField<String>(
          value: selectedValue,
          items: dropdownItems?.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.hintTextColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.hintTextColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            errorStyle: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 13, color: AppColors.redColor),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.redColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }
}
