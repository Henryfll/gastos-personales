import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/widgets/molecules/buttons/buttons_custom.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../atoms/texts/header/h4.dart';

class CloseAccountModalCard extends StatefulWidget {
  final Function onTap;
  final Function onReject;
  const CloseAccountModalCard(
      {super.key,
      required this.onTap,
      required this.onReject,});
  @override
  State<CloseAccountModalCard> createState() => _CloseAccountModalCard();
}

class _CloseAccountModalCard extends State<CloseAccountModalCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 5.sp),
            child: Container(
                height:  280.sp,
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15.sp,
                    ),
                    Icon(
                      PhosphorIcons.sealWarning(),
                      color: Colors.red,
                      size: 25.sp,
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Container(
                      width: 280.sp,
                      alignment: Alignment.center,
                      child: const H4(
                          title: '¿Desea cerrar sesión?',
                          color: Colors.black,
                          align: TextAlign.center),
                    ),
                    SizedBox(
                      height: 25.sp,
                    ),
                    Container(
                      width: 280.sp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: colorsUI.primary100, width: 1))),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    GestureDetector(
                        onTap: () => widget.onTap(),
                        child: SizedBox(
                            width: 280.sp,
                            child: const ButtonsCustom(
                              color: Colors.black,
                              border: Colors.black,
                              colorText: Colors.white,
                              text: 'Aceptar',
                              radius: 50,
                            ))),
                    SizedBox(
                      height: 15.sp,
                    ),
                    GestureDetector(
                        onTap: () => widget.onReject(),
                        child: SizedBox(
                            width: 280.sp,
                            child: const ButtonsCustom(
                              color: Colors.white,
                              border: Colors.black,
                              colorText: Colors.black,
                              text: 'Cancelar',
                              radius: 50,
                            ))),
                    SizedBox(
                      height: 20.sp,
                    ),
                  ],
                ))));
  }
}
