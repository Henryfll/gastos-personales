import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class H1 extends StatefulWidget {
  final String title;
  final Color color;
  final TextAlign align;
  const H1(
      {super.key,
      required this.title,
      required this.color,
      required this.align});
  @override
  State<H1> createState() => _H1();
}

class _H1 extends State<H1> {
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
          fontWeight: FontWeight.bold,
          fontFamily: 'Gotham',
          fontSize: 31.sp,
          height: 1.5),
    );
  }
}
