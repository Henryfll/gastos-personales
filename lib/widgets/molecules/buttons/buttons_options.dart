import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/widgets/atoms/texts/body/md_p.dart';

class ButtonsOptions extends StatefulWidget {
  final Color? color;
  final String title;
  final String? selectedOption;
  final List<String> options;
  final Function select;
  const ButtonsOptions({
    super.key,
    required this.title,
    this.selectedOption,
    required this.options,
    required this.select,
    this.color,
  });
  @override
  State<ButtonsOptions> createState() => _ButtonsOptions();
}

class _ButtonsOptions extends State<ButtonsOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.title != '') ...[
          MdP(
              title: widget.title,
              color: Colors.black,
              align: TextAlign.center,
              fontWeight: FontWeight.bold),
          SizedBox(height: 10.sp)
        ],
        Wrap(
          spacing: 10.sp,
          children: widget.options.map((option) {
            return ChoiceChip(
                backgroundColor: widget.color,
                label: Text(option,
                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Arial')),
                selected: widget.selectedOption == option,
                onSelected: (selected) =>
                    widget.select(selected, widget.title, option));
          }).toList(),
        ),
        SizedBox(height: 10.sp),
      ],
    );
  }
}
