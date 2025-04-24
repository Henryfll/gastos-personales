import 'package:flutter/material.dart';
import 'package:gastos/app/utils/size/size_config.dart';

import '../body/sm_p.dart';

class ColorLabel extends StatelessWidget {
  final Color bgColor;
  final String text;
  final Color textColor;
  const ColorLabel(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 0.8 * SizeConfig.heightMultiplier,
          bottom: 0.8 * SizeConfig.heightMultiplier,
          left: 5 * SizeConfig.widthMultiplier,
          right: 5 * SizeConfig.widthMultiplier),
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: bgColor),
          borderRadius: BorderRadius.all(
              Radius.circular(2 * SizeConfig.widthMultiplier))),
      child: SmP(
          title: text,
          color: textColor,
          align: TextAlign.center,
          fontWeight: FontWeight.bold),
    );
  }
}
