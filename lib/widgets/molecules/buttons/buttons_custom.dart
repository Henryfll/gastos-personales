import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../atoms/texts/buttons/button_bold.dart';

class ButtonsCustom extends StatelessWidget {
  final dynamic color;
  final dynamic border;
  final dynamic text;
  final dynamic colorText;
  final double radius;
  final double? height;
  const ButtonsCustom(
      {super.key,
      required this.color,
      required this.border,
      required this.colorText,
      required this.text,
      required this.radius,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            top: height != null ? height! : 5.sp,
            bottom: height != null ? height! : 5.sp,
            left: 10.sp,
            right: 10.sp),
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: border),
            borderRadius: BorderRadius.all(Radius.circular(radius.sp))),
        child: ButtonBold(
          title: text,
          color: colorText,
          align: TextAlign.center,
          fontWeight: FontWeight.w500,
        ));
  }
}
