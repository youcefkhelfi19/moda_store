import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moda_store/config/app_colors.dart';

import '../../../../../../config/app_routes.dart';
import '../../../../../../config/text_styles.dart';
import '../../view_model/product/products/products_list_cubit.dart';
import 'product_card.dart';
import '../../../models/product_model.dart';
import 'shimmer_horizontal_list.dart';

class RecommendedList extends StatelessWidget {
  const RecommendedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              const Text('Recommended',style: TextStyles.style24,),
              const Spacer(),
              TextButton(onPressed: (){
                Navigator.popAndPushNamed(context, AppRoutes.popular);

              }, child: const Text('See All',style: TextStyle(
                fontSize: 18,
                color: AppColors.mainColor
              ),))
            ],
          ),

        ),
        SizedBox(
            height: 210,
            child: StreamBuilder<QuerySnapshot>(
              stream: context.read<ProductsListCubit>().getRecommendedProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerList();
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {

                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                        itemCount:snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          Map<String, dynamic>? data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>? ;
                          Product product = Product.fromMap(data!);
                          return  ProductCard(
                            product: product,
                          );
                        });


                  } else {
                    return const Center(child: Text('No data'),);
                  }
                }
                return const Center(
                    child:  Text(
                      'something_went_wrong',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ));
              },
            )
        ),
      ],
    );
  }
}
