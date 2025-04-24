import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import '../texts/body/xsm_p.dart';

class CustomTextFormFieldMobile extends StatefulWidget {
  final Color textColor;
  final Color fillColor;
  final Color borderColor;
  final TextEditingController controller;
  final dynamic inputType;
  final bool? isDocument;
  final bool enable;
  final dynamic hintText;
  final bool isFocused;
  final bool? isCed;
  final bool? prefixIcon;
  final bool? error;
  final Function? onChangeData;
  final TextAlign? align;
  final String? type;
  final String? icon;
  final String? messageError;
  const CustomTextFormFieldMobile(
      {super.key,
      required this.controller,
      required this.inputType,
      required this.enable,
      required this.hintText,
      this.align,
      this.isDocument,
      this.type,
      this.error,
      required this.isFocused,
      this.isCed,
      this.onChangeData,
      this.icon,
      this.prefixIcon,
      this.messageError,
      required this.textColor,
      required this.fillColor,
      required this.borderColor});
  @override
  State<CustomTextFormFieldMobile> createState() =>
      _CustomTextFormFieldMobile();
}

class _CustomTextFormFieldMobile extends State<CustomTextFormFieldMobile> {
  bool? showError;
  @override
  void initState() {
    super.initState();


    if (widget.inputType == TextInputType.phone) {
      widget.controller.addListener(() {
        if (widget.controller.text == '') {
          widget.controller.text = '+34';
          widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Colors.transparent,
            child: Theme(
                data: ThemeData(
                  disabledColor: Colors.black,
                ),
                child: TextFormField(
                  textAlign:
                      (widget.align != null) ? widget.align! : TextAlign.start,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.sp, horizontal: 10.sp),
                    filled: true,
                    isDense: true,
                    hintStyle: TextStyle(
                        color: colorsUI.primary40,
                        fontSize:  13.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400),
                    hintText: widget.hintText,
                    fillColor: widget.fillColor,
                    prefixIcon: widget.prefixIcon == true
                        ? Icon(
                            Icons.attach_money,
                            color: colorsUI.primary40,
                          )
                        : null,
                    suffixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? colorsUI.primary40
                            : widget.textColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.error == true
                                ? Colors.red
                                : showError == true
                                    ? Colors.red
                                    : Colors.blue,
                            width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(8.sp))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.error ?? showError == true
                                ? Colors.red
                                : widget.borderColor,
                            width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(8.sp))),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.error ?? showError == true
                                ? Colors.red
                                : widget.isFocused
                                    ? Colors.blue
                                    : colorsUI.primary40,
                            width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(8.sp))),
                  ),
                  keyboardType: widget.inputType,
                  textInputAction: TextInputAction.done,
                  cursorColor: widget.textColor,
                  enabled: widget.enable,
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 13.sp,
                      color: widget.textColor),
                  onChanged: (x) {
                    widget.onChangeData!(x);
                  },
                  inputFormatters: [
                    if (widget.isDocument == true) ...[
                      LengthLimitingTextInputFormatter(
                          widget.isCed == true ? 10 : 15),
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-Z0-9]+$'))
                    ],
                    if (widget.inputType == TextInputType.number) ...[
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    if (widget.hintText ==
                        "Teléfono del contacto de emergencia") ...[
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+'))
                    ],
                    if (widget.hintText ==
                        "Ingresa el celular del titular") ...[
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    if (widget.inputType == TextInputType.name ||
                        widget.inputType == TextInputType.text &&
                            widget.isDocument != true) ...[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]')),
                      LengthLimitingTextInputFormatter(70),
                    ],
                    if (widget.inputType == TextInputType.phone) ...[
                      LengthLimitingTextInputFormatter(12),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))
                    ],
                  ],
                ))),
        if (widget.error == true) ...[
          Container(
              alignment: Alignment.centerLeft,
              child: XsmP(
                  title: widget.messageError.toString(),
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  align: TextAlign.left))
        ]
      ],
    );
  }
}
