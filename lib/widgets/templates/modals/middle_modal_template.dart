import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiddleModalTemplate {
  middleModal(
    context,
    Widget child,
    Color? color,
    double? width,
  ) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      barrierColor: Colors.black.withOpacity(0.25),
      builder: (BuildContext context) {
        return Center(
            child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                type: MaterialType.transparency,
                child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 5.sp),
                    child: Container(
                      width: width ?? double.infinity,
                      decoration: BoxDecoration(
                        color: color ?? Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                      ),
                      child: child,
                    ))));
      },
    );
  }
}

MiddleModalTemplate middleModals = MiddleModalTemplate();
