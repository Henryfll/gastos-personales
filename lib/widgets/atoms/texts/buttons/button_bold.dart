import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ButtonBold extends StatefulWidget {
  final String title;
  final Color color;
  final TextAlign align;
  final FontWeight fontWeight;
  const ButtonBold(
      {super.key,
      required this.title,
      required this.color,
      required this.align,
      required this.fontWeight});
  @override
  State<ButtonBold> createState() => _ButtonBold();
}

class _ButtonBold extends State<ButtonBold> {
  String env = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      textAlign: widget.align,
      style: TextStyle(
          color: widget.color,
          fontWeight: widget.fontWeight,
          fontFamily: 'Arial',
          fontSize: env == 'tablet' ? 16.sp : 14.sp,
          height: 1.5),
    );
  }
}
