import 'package:flutter/material.dart';

class ColorCard extends StatelessWidget {
  const ColorCard({Key? key,required this.colorCode}) : super(key: key);
  final int colorCode;
  @override
  Widget build(BuildContext context) {
    return  Container(
       margin:const EdgeInsets.all(1),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(3),
       color: Color(colorCode),
     ),
    );
  }
}
