import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../config/app_colors.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Shimmer.fromColors(
          baseColor: AppColors.secondaryColor,
          highlightColor: Colors.grey.shade300,
          child:  Container(
            height: 170,
            width: 170,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,

            ),
          ),
        ),
      ),
    );
  }
}
