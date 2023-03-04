import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/config/app_colors.dart';
import 'package:moda_store/featured/category/data/models/category_model.dart';

import '../../../products/data/presentation/view_model/product/products/products_list_cubit.dart';
import '../../../products/data/presentation/views/widgets/product_card.dart';
import '../../../products/data/models/product_model.dart';

class CategoriesScreen extends StatefulWidget {
   const CategoriesScreen({Key? key, required this.index,required this.categories}) : super(key: key);
  final int index ;
  final List<CategoryModel> categories ;
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with TickerProviderStateMixin {
  late TabController tabController ;

  void initState() {
    tabController = TabController(length: widget.categories.length,vsync:this,initialIndex: widget.index );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length, child:
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
        elevation: 0.0,
        backgroundColor: AppColors.mainColor,
        actions: [IconButton(onPressed: (){

        }, icon: const Icon(Ionicons.heart))],
      ),
      body: Column(
        children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.topCenter,
            child: ButtonsTabBar(
            controller: tabController,
            backgroundColor: AppColors.mainColor,
            unselectedBackgroundColor: Colors.grey[300],
            unselectedLabelStyle:  const TextStyle(color: AppColors.mainColor),

            labelStyle:
             const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            tabs: widget.categories.map<Tab>((CategoryModel category) {
              return Tab(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(category.imageLink)),
                ),
                text: category.title,
              );
            }).toList(),
            ),
          ),
        ),
          Expanded(
              flex: 7,
              child: TabBarView(
                controller: tabController,
                children: widget.categories.map((CategoryModel category) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: context.read<ProductsListCubit>().getProducts(category.title),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.active) {

                        if (snapshot.data!.docs.isNotEmpty) {
                          return GridView.builder(
                              itemCount:snapshot.data!.docs.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.82),
                              itemBuilder: (context,index){
                            Map<String, dynamic>? data = snapshot.data!.docs[index].data() as Map<String, dynamic>? ;
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
                  );
                }).toList(),))
        ],
      ),
    ),

    );
  }
}
