import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';


class CustomIconField extends StatefulWidget {
  final TextEditingController controller;
  final dynamic inputType;
  final bool enable;
  final dynamic hintText;
  final IconData icon;
  final Color borderColor;
  const CustomIconField({
    super.key,
    required this.inputType,
    required this.enable,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.borderColor,
  });
  @override
  State<CustomIconField> createState() => _CustomIconField();
}

class _CustomIconField extends State<CustomIconField> {
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.sp, horizontal: 10.sp),
                      suffixIconColor: colorsUI.primary40,
                      suffixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            widget.icon,
                            size: 20.sp,
                          )),
                      filled: true,
                      hintStyle: TextStyle(
                          color: colorsUI.primary40,
                          fontSize:  13.sp,
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
                          BorderSide(color: widget.borderColor, width: 1),
                          borderRadius:
                          BorderRadius.all(Radius.circular(8.sp))),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: widget.borderColor, width: 1),
                          borderRadius:
                          BorderRadius.all(Radius.circular(8.sp))),
                    ),
                    keyboardType: widget.inputType,
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.black,
                    enabled: widget.enable,
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize:  13.sp,
                        color: Colors.black),
                  ),
                ))),
      ],
    );
  }
}
