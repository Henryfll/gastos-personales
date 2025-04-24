import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:phone_text_field/phone_text_field.dart';

class CustomPhoneField extends StatefulWidget {
  final Function onSelect;
  const CustomPhoneField({
    super.key,
    required this.onSelect,
  });
  @override
  State<CustomPhoneField> createState() => _CustomPhoneField();
}

class _CustomPhoneField extends State<CustomPhoneField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneTextField(
      locale: const Locale('es', 'ES'),
      invalidNumberMessage: '',
      enabled: true,
      autofocus: false,
      isRequired: false,
      textStyle: TextStyle(
          fontFamily: 'Arial',
          fontSize:  13.sp,
          color: Colors.black),
      decoration: InputDecoration(
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: const BorderSide(color: Colors.blue, width: 1),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: const BorderSide(color: Colors.blue, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.sp)),
              borderSide: const BorderSide(color: Colors.blue, width: 1)),
          prefixIcon: const Icon(Icons.phone),
          labelText: "",
          hintStyle: TextStyle(
              color: colorsUI.primary40,
              fontSize:  13.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          errorText: ''),
      searchFieldInputDecoration: InputDecoration(
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          borderSide: const BorderSide(color: Colors.blue, width: 1),
        ),
        suffixIcon: const Icon(Icons.search),
        focusColor: Colors.white,
        hintText: "Buscar país o código",
      ),
      initialCountryCode: "ES",
      countryViewOptions: CountryViewOptions.countryCodeWithFlag,
      onChanged: (phone) {
        debugPrint(phone.completeNumber);
        widget.onSelect(phone.completeNumber.toString());
      },
    );
  }
}
