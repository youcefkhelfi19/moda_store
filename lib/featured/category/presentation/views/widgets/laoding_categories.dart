import 'package:flutter/material.dart';

import 'category_card.dart';
import 'custom_card_shimmer.dart';

class LoadingCategories extends StatelessWidget {
  const LoadingCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CustomCardShimmer(
          );
        });
  }
}
