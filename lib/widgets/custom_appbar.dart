import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('SACA'),
      elevation: 0.0,
      backgroundColor: AppColors.mainColor,
    );
  }
}
