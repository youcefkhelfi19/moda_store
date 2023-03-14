import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/config/app_colors.dart';



class PasswordField extends StatefulWidget {
  const PasswordField( {Key? key,  this.textEditingController, required this.hintText,
  required this.validator, this.prefixIcon
  })
      : super(key: key);

  final TextEditingController? textEditingController;
  final String hintText;
  final IconData? prefixIcon;
  final String? Function(String?) validator;
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
          controller: widget.textEditingController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              prefixIcon: Icon(widget.prefixIcon),

              contentPadding: const EdgeInsets.only(left: 25,bottom: 22,right: 0,top: 22),

            suffixIconColor: AppColors.mainColor,
            hintText: widget.hintText,
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
