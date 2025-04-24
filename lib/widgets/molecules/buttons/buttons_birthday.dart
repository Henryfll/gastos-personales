import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/widgets/atoms/texts/body/md_p.dart';

class ButtonsBirthDay extends StatefulWidget {
  final String title;
  final DateTime? birthDate;
  final Function selectDate;
  const ButtonsBirthDay({
    super.key,
    required this.title,
    required this.selectDate,
    this.birthDate,
  });
  @override
  State<ButtonsBirthDay> createState() => _ButtonsBirthDay();
}

class _ButtonsBirthDay extends State<ButtonsBirthDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MdP(
            title: widget.title,
            color: Colors.black,
            align: TextAlign.center,
            fontWeight: FontWeight.bold),
        TextButton(
          onPressed: () => widget.selectDate(),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.birthDate == null
                          ? Colors.deepPurple
                          : Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(8.sp))),
              child: MdP(
                  title: widget.birthDate?.toString().split(' ')[0] ??
                      'Selecciona Fecha',
                  color: widget.birthDate == null
                      ? Colors.deepPurple
                      : Colors.black,
                  align: TextAlign.center,
                  fontWeight: FontWeight.normal)),
        ),
        SizedBox(height: 10.sp),
      ],
    );
  }
}
