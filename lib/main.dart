import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moda_store/featured/auth/presentation/view_models/admin_cubit/admin_cubit.dart';
import 'package:moda_store/featured/category/presentation/view_model/category_cubit.dart';
import 'package:moda_store/featured/products/data/presentation/view_model/product/add_product/add_product_cubit.dart';
import 'package:moda_store/services/locator.dart';

import 'config/app_routes.dart';
import 'config/app_theme.dart';
import 'featured/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'featured/products/data/presentation/view_model/product/product/product_cubit.dart';
import 'featured/products/data/presentation/view_model/product/products/products_list_cubit.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage().initStorage;
  await Firebase.initializeApp(  options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();

  runApp(const ModaStore());
}

class ModaStore extends StatelessWidget {
  const ModaStore({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => AuthCubit()),
        BlocProvider(create:(context) => AdminCubit()),
        BlocProvider(create:(context) => CategoryCubit()),
        BlocProvider(create:(context) => AddProductCubit()),
        BlocProvider(create:(context) => ProductsListCubit()),
        BlocProvider(create:(context) => ProductCubit()),

      ],
      child: MaterialApp(
        onGenerateRoute: AppRoutes.generateRoutes,
        initialRoute: '/',
        theme: englishTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

