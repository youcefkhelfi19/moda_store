
import 'package:flutter/material.dart';


class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key, required this.hintText,  this.prefixIcon, required this.textEditingController, required this.validator,  this.isNumber = false,
  }) : super(key: key);
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController textEditingController ;
  final bool isNumber;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: isNumber?TextInputType.number:TextInputType.text,
        validator: validator,
        controller:  textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
         prefixIcon: Icon(prefixIcon)

        ),

      ),
    );
  }
}
