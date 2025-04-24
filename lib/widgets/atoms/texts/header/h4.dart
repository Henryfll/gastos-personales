import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class H4 extends StatefulWidget {
  final String title;
  final Color color;
  final TextAlign align;
  const H4(
      {super.key,
      required this.title,
      required this.color,
      required this.align});
  @override
  State<H4> createState() => _H4();
}

class _H4 extends State<H4> {
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
          fontFamily: 'Gotham',
          fontWeight: FontWeight.bold,
          fontSize: 21.sp,
          height: 1.5),
    );
  }
}
