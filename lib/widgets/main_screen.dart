import 'package:flutter/material.dart';
import 'package:moda_store/config/app_colors.dart';
import 'package:moda_store/config/constans.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/featured/category/presentation/views/add_category.dart';

import '../featured/products/data/presentation/views/add_product.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  void _onItemTapped(int index) {
    setState(() {
      _index= index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(screensTitle[_index]),
          elevation: 0.0,
          backgroundColor: AppColors.mainColor,
          actions: [IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddProduct()));
          }, icon: const Icon(Icons.add))],
        ),
        body: navBarList[_index],
         bottomNavigationBar: BottomNavigationBar(
           selectedItemColor: AppColors.mainColor,
           unselectedItemColor: AppColors.secondaryColor,
           backgroundColor: Colors.transparent,
           elevation: 0,
           items: const <BottomNavigationBarItem>[
             BottomNavigationBarItem(
               icon: Icon(Ionicons.storefront_outline),
               label: '',
             ),
             BottomNavigationBarItem(
               icon: Icon(Ionicons.cart_outline),
               label: '',
             ),
             BottomNavigationBarItem(
               icon: Icon(Ionicons.person_outline),
               label: '',
             ),
           ],
           currentIndex: _index,
           onTap: _onItemTapped,
         ),
    );

  }
}
