import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MdP extends StatefulWidget {
  final String title;
  final Color color;
  final TextAlign align;
  final FontWeight fontWeight;
  const MdP(
      {Key? key,
      required this.title,
      required this.color,
      required this.align,
      required this.fontWeight})
      : super(key: key);
  @override
  State<MdP> createState() => _MdP();
}

class _MdP extends State<MdP> {
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
          fontFamily: 'Arial',
          fontWeight: widget.fontWeight,
          fontSize:  13.sp,
          height: 1.5),
    );
  }
}
