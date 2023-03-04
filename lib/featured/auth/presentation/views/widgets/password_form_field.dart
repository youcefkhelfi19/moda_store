import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/config/app_colors.dart';



class PasswordField extends StatefulWidget {
  const PasswordField( {Key? key,  this.controller, required this.hint,
  this.validator
  })
      : super(key: key);

  final TextEditingController? controller;
  final String hint;
  final String Function(String?)? validator;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
          validator: (value){
            return null;
          },
          style: const TextStyle(fontSize: 14),

          obscureText: show,
          controller: widget.controller,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 25,bottom: 22,right: 0,top: 22),

            suffixIconColor: AppColors.mainColor,
            hintText: widget.hint,
            suffixIcon: GestureDetector(
                onTap: (){
                setState(() {
                  show = !show;
                });
                },
                child:  Icon(show? Ionicons.chevron_up_outline:Ionicons.chevron_down_outline,color:AppColors.mainColor ,)),
          )

      ),
    );
  }
}
