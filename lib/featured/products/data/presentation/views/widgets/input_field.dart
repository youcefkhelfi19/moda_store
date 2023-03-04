import 'package:flutter/material.dart';

import '../../../../../../config/app_colors.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key, required this.hintText,this.label,  required this.textEditingController, required this.validator,  this.isNumber = false, this.showSuffix=false, this.suffix,
  }) : super(key: key);
  final String hintText;
  final TextEditingController textEditingController ;
  final bool isNumber;
  final String? Function(String?) validator;
  final bool showSuffix;
  final String? suffix;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isNumber?TextInputType.number:TextInputType.text,
      validator: validator,
      controller:  textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          label: Text(label!),
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          suffixText: showSuffix ?suffix:null
      ),
    );
  }
}
