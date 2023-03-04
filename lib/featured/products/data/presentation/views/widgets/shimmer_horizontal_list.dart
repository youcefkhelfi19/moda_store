import 'package:flutter/material.dart';
import 'package:moda_store/featured/products/data/presentation/views/widgets/product_card_shimmer.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
          itemCount:10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return const ProductCardShimmer();
          })
    );
  }
}
