import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../config/app_colors.dart';

class CustomCardShimmer extends StatelessWidget {
  const CustomCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
              ),
              child:Shimmer.fromColors(
                baseColor: AppColors.secondaryColor.withOpacity(0.5),
                highlightColor: Colors.grey.shade300,
                child:  Container(
                   height: 80,
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)
                    ),
                    color: Colors.grey,

                  ),
                ),
              )),
          Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              child: Shimmer.fromColors(
                  baseColor: AppColors.secondaryColor.withOpacity(0.5),
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    height: 20,width: 100,)))
        ],
      ),
    );
  }
}
