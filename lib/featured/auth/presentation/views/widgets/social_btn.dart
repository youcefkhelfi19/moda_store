import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';


class CustomSocialBtn extends StatelessWidget {
  const CustomSocialBtn({
    Key? key, required this.logo, required this.onTap,
  }) : super(key: key);
  final IconData logo ;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      height: 50,
      minWidth: 50,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      color: AppColors.secondaryColor,
      onPressed: (){
        onTap();
      },
      child: Icon(logo,color: AppColors.mainColor,size: 35
        ,),
    );
  }
}
