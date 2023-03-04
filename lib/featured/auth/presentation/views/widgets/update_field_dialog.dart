import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/text_styles.dart';
import '../../view_models/admin_cubit/admin_cubit.dart';
import 'custom_input_field.dart';

updateFieldAlert(
    {required BuildContext context, required String title, required String hint,required String fieldName}){
 TextEditingController fieldController = TextEditingController();
  return showDialog(context: context, builder:(context){
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(10)
      ),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      title: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
              )
          ),
          child:  Text(title,style: TextStyles.style20.copyWith(color: AppColors.secondaryColor),)),
      content: SizedBox(
        height: 140,
        width: MediaQuery.of(context).size.width*0.8,
        child: Column(
          children: [
            CustomInputField(
              isNumber: true,
              validator: (value){

                return null;
              },

              textEditingController: fieldController,
              hintText: hint,
            ),
           SizedBox(height: 10,),
           Align(
             alignment: Alignment.bottomRight,
             child: MaterialButton(
               height: 40,
               minWidth: 50,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10)
               ),
               color: AppColors.mainColor,
               onPressed: () async{
                 print(fieldController.text);
                 if(fieldController.text.isNotEmpty){
                    context.read<AdminCubit>().updateField(fieldValue: fieldController.text, field: fieldName);
                    Navigator.pop(context);

                 }

                 fieldController.clear();

               },
               child: Text('Update',style: TextStyles.style20.copyWith(color: AppColors.secondaryColor,
                   fontWeight: FontWeight.normal,fontSize: 16),),
             ),
           )
          ],
        ),
      ),
    );
  });
}
