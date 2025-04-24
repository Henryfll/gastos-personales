import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final dynamic inputType;
  final bool enable;
  final dynamic hintText;
  const CustomSearchField({
    super.key,
    required this.inputType,
    required this.enable,
    required this.hintText,
    required this.controller,
  });
  @override
  State<CustomSearchField> createState() => _CustomSearchField();
}

class _CustomSearchField extends State<CustomSearchField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Colors.transparent,
            child: Theme(
                data: ThemeData(
                  disabledColor: Colors.black,
                ),
                child: GestureDetector(
                  child: TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(PhosphorIcons.magnifyingGlass())),
                      filled: true,
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize:  15.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400),
                      hintText: widget.hintText,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.sp))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: colorsUI.primary40, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.sp))),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: colorsUI.primary40, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.sp))),
                    ),
                    keyboardType: widget.inputType,
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.black,
                    enabled: widget.enable,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'Arial',
                        color: Colors.black),
                  ),
                ))),
      ],
    );
  }
}
