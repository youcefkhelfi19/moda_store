import 'package:flutter/material.dart';
import 'package:moda_store/config/text_styles.dart';

import '../../../../../config/app_colors.dart';




class GlobalBtn extends StatelessWidget{
  const GlobalBtn( {
    Key? key, required this.title,required this.onTap,
  }) : super(key: key);
  final String title ;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          height: 50,
          color: AppColors.mainColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text(title,style: TextStyles.style24.copyWith(color: Colors.white),),
          onPressed: (){
            onTap();
          }),
    );
  }
}
