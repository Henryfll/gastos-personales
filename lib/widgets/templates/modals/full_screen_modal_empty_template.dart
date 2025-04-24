import 'package:flutter/material.dart';
import 'package:gastos/app/utils/size/size_config.dart';


class FullScreenModalEmptyTemplate extends StatefulWidget {
  final Widget child;

  const FullScreenModalEmptyTemplate({
    super.key,
    required this.child,
  });

  @override
  State<FullScreenModalEmptyTemplate> createState() =>
      _FullScreenModalEmptyTemplateState();
}

class _FullScreenModalEmptyTemplateState
    extends State<FullScreenModalEmptyTemplate> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(bottom: true, top: true, child: widget.child),
    ));
  }
}
