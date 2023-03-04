
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moda_store/config/app_colors.dart';

Future<bool> alertExitApp(){
 return Future.value(true);
}
customAlert({required BuildContext context, required String title, required String meg}){
 return showDialog(context: context, builder: (context){
    return AlertDialog(
     content: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       CircularProgressIndicator(
        color: AppColors.mainColor,
        value: 4,
       ),
       const Text('Loading')
      ],
     ),
    );
 });
}
customToast({required String msg, required Color color}){
 return Fluttertoast.showToast(
     msg: msg,
     toastLength: Toast.LENGTH_SHORT,
     gravity: ToastGravity.BOTTOM,
     timeInSecForIosWeb: 1,
     backgroundColor: color,
     textColor: Colors.white,
     fontSize: 16.0
 );
}