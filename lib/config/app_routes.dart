import 'package:flutter/material.dart';
import 'package:moda_store/featured/category/presentation/views/categories_screen.dart';
import 'package:moda_store/featured/auth/presentation/views/login_screen.dart';
import 'package:moda_store/featured/auth/presentation/views/splash_screen.dart';
import 'package:moda_store/featured/products/data/presentation/views/newest_products.dart';
import 'package:moda_store/featured/products/data/presentation/views/popular_products.dart';
import 'package:moda_store/featured/products/data/presentation/views/updateProduct.dart';
import 'package:moda_store/featured/products/data/presentation/views/widgets/recommended_products_list.dart';
import 'package:moda_store/widgets/main_screen.dart';

import '../featured/products/data/models/product_model.dart';
import '../featured/products/data/presentation/views/product_details.dart';
import '../featured/auth/presentation/views/signup.dart';

class AppRoutes{
  static const String  splash ='/';
  static const String  main ='/main';
  static const String categories = '/cats';
  static const String details = '/details';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String update = '/update';
  static const String popular = '/popular';
  static const String recommended = '/recommended';
  static const String newest = '/newest';
  static Route<dynamic> generateRoutes (RouteSettings routeSettings){
    final arg = routeSettings.arguments;
    switch(routeSettings.name){
        case main:
        return MaterialPageRoute(builder: (c_)=>const MainScreen());
        case signup:
        return MaterialPageRoute(builder: (c_)=>const Signup());
        case popular:
        return MaterialPageRoute(builder: (c_)=>const PopularProducts());
        case newest:
        return MaterialPageRoute(builder: (c_)=>const NewestProducts());
        case recommended:
        return MaterialPageRoute(builder: (c_)=>const RecommendedList());
        case splash:
        return MaterialPageRoute(builder: (_)=> const SplashScreen());
        case update:
        if(arg is Product){
          return MaterialPageRoute(builder: (_)=> UpdateProduct(product: arg,));
        }
        return _errorRoute();
      case details:
        if(arg is String){
            return MaterialPageRoute(builder: (_)=>  ProductDetails(productId:arg));
          }
          return _errorRoute();
      case categories:
         if(arg is List){
           return MaterialPageRoute(builder: (_)=>  CategoriesScreen(index:arg[0], categories:arg[1] ,));
         }
         return _errorRoute();
      case login:
        return MaterialPageRoute(builder: (_)=> const LoginScreen());
      default :
        return _errorRoute();
        
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (c_)=>
    const Scaffold(
      body: Center(
        child: Text('Something went wrong'),
      ),
    ));
  }
}