import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moda_store/config/app_routes.dart';
import 'package:moda_store/services/locator.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    nextRoute();
    super.initState();
  }

  nextRoute() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      getIt.get<GetStorage>().read('token')==null ?Navigator.pushReplacementNamed(context, AppRoutes.login):Navigator.pushReplacementNamed(context, AppRoutes.main);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png', height: 100, width: 100,),
      ),
    );
  }
}
