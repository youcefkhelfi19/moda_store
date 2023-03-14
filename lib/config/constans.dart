import 'package:moda_store/featured/category/data/models/category_model.dart';
import 'package:moda_store/screens/cart_screen.dart';
import 'package:moda_store/screens/home_screen.dart';
import 'package:moda_store/featured/auth/presentation/views/profile_screen.dart';

import '../featured/products/data/models/product_model.dart';


const List<String> sizes = [
  'S','M','L','XL','XXL'
];
const List<String> screensTitle = [
  'STORE','ORDERS','PROFILE'
];

const List<String> shoesSizes = [
  '38','39','40','41','42','43','44','45','46'
];

List navBarList = [
  const HomeScreen(),
  const CartScreen(),
  const ProfileScreen(),
];
const String me = 'https://avatars.githubusercontent.com/u/76778467?s=400&u=c003ba31cde90a84a0be5e07f3c6157e799bd3e9&v=4';
