import 'package:flutter/material.dart';
import 'package:moda_store/config/constans.dart';
import 'package:moda_store/config/text_styles.dart';

import '../featured/category/presentation/views/widgets/categories_list.dart';
import '../featured/products/data/presentation/views/widgets/newest_products_list.dart';
import '../featured/products/data/presentation/views/widgets/popular_products_list.dart';
import '../featured/products/data/presentation/views/widgets/recommended_products_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children:  const [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('Categories',style: TextStyles.style24,),
          ),
          CategoriesList(),

          RecommendedList(),
          PopularProducts(),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('Newest',style: TextStyles.style24,),
          ),
          NewestProducts()
        ],
      ),
    );
  }
}



