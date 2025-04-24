import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/paths/images/images.dart';
import 'package:gastos/widgets/atoms/texts/body/md_p.dart';
import 'package:gastos/widgets/molecules/buttons/buttons_custom.dart';
import '../../atoms/texts/header/h2.dart';

class SuccessModalTemplate extends StatefulWidget {
  final String title;
  final String message;
  final Function redirect;
  const SuccessModalTemplate(
      {super.key,
      required this.message,
      required this.title,
      required this.redirect});
  @override
  State<SuccessModalTemplate> createState() => _SuccessModalTemplate();
}

class _SuccessModalTemplate extends State<SuccessModalTemplate> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagesUI.check,
            height: 150.sp,
          ),
          SizedBox(
            height: 10.sp,
          ),
          H2(title: widget.title, color: Colors.green, align: TextAlign.center),
          SizedBox(
            height: 20.sp,
          ),
          MdP(
              title: widget.message,
              color: Colors.black,
              align: TextAlign.center,
              fontWeight: FontWeight.w500),
          SizedBox(
            height: 20.sp,
          ),
          Container(
              color: Colors.transparent,
              width: 250.sp,
              child: GestureDetector(
                onTap: () => widget.redirect(),
                child: const ButtonsCustom(
                    color: Colors.black,
                    border: Colors.black,
                    colorText: Colors.white,
                    text: 'Aceptar',
                    radius: 50),
              ))
        ],
      ),
    );
  }
}
