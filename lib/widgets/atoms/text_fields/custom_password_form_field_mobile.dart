import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomPasswordFormFieldMobile extends StatefulWidget {
  final Color textColor;
  final Color fillColor;
  final TextEditingController? controller;
  final dynamic text;
  final Function? onChangeData;
  final Function? onChangeData2;
  final dynamic colorBorder;
  final dynamic colorUnderlineBorder;
  const CustomPasswordFormFieldMobile(
      {super.key,
      required this.controller,
      required this.text,
      this.onChangeData,
      this.onChangeData2,
      this.colorBorder,
      this.colorUnderlineBorder,
      required this.textColor,
      required this.fillColor});
  @override
  State<CustomPasswordFormFieldMobile> createState() =>
      _CustomPasswordFormFieldMobile();
}

class _CustomPasswordFormFieldMobile
    extends State<CustomPasswordFormFieldMobile> {
  @override
  void initState() {
    super.initState();
  }

  bool isObscured = true;
  visiblePassword() {
    if (isObscured.toString() == 'false') {
      setState(() {
        isObscured = true;
      });
    } else if (isObscured.toString() == 'true') {
      setState(() {
        isObscured = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        hintStyle: TextStyle(
            color: colorsUI.primary40,
            fontSize: 15.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w500),
        hintText: widget.text,
        fillColor: widget.fillColor,
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.sp),
        suffixIcon: GestureDetector(
            onTap: () => visiblePassword(),
            child: Icon(
              isObscured ? PhosphorIcons.eyeClosed() : PhosphorIcons.eye(),
              size: 25.sp,
            )),
        suffixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? Colors.blue
                : colorsUI.primary40),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.colorBorder ?? Colors.blue, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8.sp))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.colorUnderlineBorder ?? colorsUI.primary40,
              width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
        ),
      ),
      onChanged: widget.onChangeData == null
          ? (x) => widget.onChangeData2!(x)
          : (x) => widget.onChangeData!(),
      cursorColor: widget.textColor,
      obscureText: isObscured,
      style: TextStyle(
        fontFamily: 'Arial',
        color: widget.textColor,
        fontSize:  15.sp,
      ),
    );
  }
}
