import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/text_styles.dart';

imageAlertDialog(
    {required BuildContext context, required Function() openCamera, required Function() openGallery}){
  return showDialog(context: context, builder:(context){
    return AlertDialog(
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
          child:  Text('Upload Picture',style: TextStyles.style20.copyWith(color: AppColors.secondaryColor),)),
      content: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Column(
              children: [
                IconButton(onPressed: (){
                  openCamera();
                }, icon:  const Icon(Ionicons.albums_outline,size: 40,color: AppColors.mainColor,)),
                Text('From Camera',style: TextStyles.style20.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.normal
                ),)
              ],
            ),
            Column(
              children: [
                IconButton(onPressed: (){
                  openGallery();
                }, icon: const Icon(Ionicons.camera_outline,size: 40,)),
                Text('From Gallery',style: TextStyles.style20.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.normal

                ),)
              ],
            )
          ],),
      ),
    );
  });
}
