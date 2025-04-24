import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../atoms/texts/buttons/button_bold.dart';

class CustomIconTextButtonMobile extends StatelessWidget {
  final dynamic color;
  final dynamic border;
  final dynamic text;
  final dynamic colorText;
  final double radius;
  final double? height;
  final String icon;
  const CustomIconTextButtonMobile(
      {super.key,
      required this.color,
      required this.border,
      required this.colorText,
      required this.text,
      required this.radius,
      required this.icon,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: height != null ? height! : 5.sp,
            bottom: height != null ? height! : 5.sp,
            left: 10.sp,
            right: 10.sp),
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: border),
            borderRadius: BorderRadius.all(Radius.circular(radius.sp))),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
                alignment: Alignment.center,
                child: ButtonBold(
                  title: text,
                  color: colorText,
                  align: TextAlign.center,
                  fontWeight: FontWeight.w500,
                )),
            Positioned(
                child: Container(
              width: 20.sp,
              alignment: Alignment.centerLeft,
              height: 20.sp,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(icon))),
            )),
          ],
        ));
  }
}
