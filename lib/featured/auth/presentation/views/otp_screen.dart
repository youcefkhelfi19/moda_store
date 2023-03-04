import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:ionicons/ionicons.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/text_styles.dart';



class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.08,),
          Align(
              alignment: Alignment.center,
              child: Text('otp_verification',style: TextStyles.style24,)),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10,bottom: 30),
            child: Text('otp_verification_sub',textAlign: TextAlign.center,style: TextStyles.style20.copyWith(color: AppColors.mainColor),),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.08,),

          OtpTextField(
            numberOfFields: 5,
            borderRadius: BorderRadius.circular(10),
            focusedBorderColor: AppColors.mainColor,
            enabledBorderColor: AppColors.secondaryColor,
            showFieldAsBox: true,
            onCodeChanged: (String code) {


            },
            onSubmit: (String verificationCode){

            }, // end onSubmit
          ),

        ],
      )
    );
  }
}
