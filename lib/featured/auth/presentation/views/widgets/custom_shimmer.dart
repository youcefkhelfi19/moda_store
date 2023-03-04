import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../config/app_colors.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,  required this.width, required this.height,
  });
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: AppColors.secondaryColor,
        highlightColor: Colors.grey.shade300,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,

          ),
          height: height,width: width,),
      ),
    );
  }
}
