import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';

import '../../atoms/texts/header/h2.dart';

class BackIconHeader extends StatelessWidget implements PreferredSizeWidget {
  final Function? redirect;
  final String title;
  final bool? isPop;
  const BackIconHeader(
      {super.key, this.redirect, required this.title, this.isPop});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: H2(title: title, color: Colors.black, align: TextAlign.center),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.white,
        shadowColor: colorsUI.primary20,
        leading: GestureDetector(
          onTap:
              isPop == true ? () => Navigator.pop(context) : () => redirect!(),
          child: Icon(
            Icons.keyboard_arrow_left,
            color: colorsUI.primary100,
            size: 35.sp,
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
