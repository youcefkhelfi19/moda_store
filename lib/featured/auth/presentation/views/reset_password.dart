import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/text_styles.dart';
import 'widgets/custom_global_btn.dart';
import 'widgets/custom_input_field.dart';



class ResetPassword extends StatelessWidget {
  const ResetPassword ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
            Align(
                alignment: Alignment.center,
                child: Text('reset_password',style: TextStyles.style24,)),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10,bottom: 30),
              child: Text('reset_password_sub',textAlign: TextAlign.center,style: TextStyles.style20.copyWith(color: AppColors.mainColor),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),

            CustomInputField(
              validator: (value){
                return value;
              },
              textEditingController: TextEditingController(),
              hintText: 'new_password',
              prefixIcon: Ionicons.lock_closed_outline,
            ),
            const SizedBox(height: 10,),

            CustomInputField(
              validator: (value){
                return value;
              },
              textEditingController: TextEditingController(),
              hintText: 'confirm_password',
              prefixIcon: Ionicons.lock_closed_outline,
            ),

            const SizedBox(height: 30,),
            GlobalBtn(
              onTap: () => {
              },
              title: 'save',
            ),
            const SizedBox(height: 40,),


          ],
        ),
    );
  }
}


