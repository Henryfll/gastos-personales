import 'package:flutter/material.dart';
import 'package:gastos/widgets/atoms/texts/body/md_p.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String title;
  final Function validator;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.title,
      required this.inputType,
      required this.validator});
  @override
  State<CustomTextField> createState() => _CustomTextField();
}

class _CustomTextField extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MdP(
            title: widget.title,
            color: Colors.black,
            align: TextAlign.center,
            fontWeight: FontWeight.bold),
        Container(
            color: Colors.transparent,
            child: Theme(
                data: ThemeData(
                  disabledColor: Colors.black,
                ),
                child: TextFormField(
                    controller: widget.controller,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    ),
                    onChanged: (value) => setState(() {}),
                    validator: (value) => widget.validator(value)))),
      ],
    );
  }
}
