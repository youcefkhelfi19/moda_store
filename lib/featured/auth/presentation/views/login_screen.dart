import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/config/app_routes.dart';
import 'package:moda_store/config/text_styles.dart';
import 'package:moda_store/featured/auth/presentation/view_models/auth_cubit/auth_cubit.dart';

import '../../../../config/app_colors.dart';
import '../../../../widgets/alerts.dart';
import 'widgets/custom_global_btn.dart';
import 'widgets/custom_input_field.dart';
import 'widgets/password_form_field.dart';
import 'widgets/screen_switch.dart';
import 'widgets/social_btn.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen ({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (ctx, state) {
    if(state is AuthLoading){
    }else if(state is AuthSuccess){
      Navigator.pushReplacementNamed(context, AppRoutes.main);
      customToast(msg: 'Welcome back', color: AppColors.mainColor);

    }else if(state is AuthFailed){
        customToast(msg: state.errMsg, color: Colors.red);
    }
  },
      builder: (ctx,state){
       return Stack(
         children: [
           Scaffold(
               resizeToAvoidBottomInset: false,
               body:WillPopScope(
                 onWillPop: alertExitApp,
                 child: Form(
                   child: ListView(
                     padding: const EdgeInsets.all(20),
                     children: [
                       SizedBox(height: MediaQuery.of(context).size.height*0.08,),
                       const Align(
                           alignment: Alignment.center,
                           child: Text('welcome_back',style: TextStyles.style24,)),
                       Container(
                         alignment: Alignment.center,
                         padding: const EdgeInsets.only(top: 10,bottom: 30),
                         child: Text('login_sub',textAlign: TextAlign.center,style: TextStyles.style20.copyWith(color: AppColors.mainColor),),
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*0.08,),

                       CustomInputField(
                         validator: (value){
                           if(!value!.contains('@')||value.isEmpty||value.length<4){
                             return 'Please use a valid email';
                           }
                           return null;
                         },
                         hintText: 'email',
                         prefixIcon: Ionicons.mail_outline,
                         textEditingController: emailTextController,
                       ),
                       const SizedBox(height: 10,),

                       PasswordField(
                         validator: (value){
                           if(value!.length<4){
                             return 'password must be more than 4 chr';
                           }else if(!value.contains(RegExp(r'[A-Z]'))&&!value.contains(RegExp(r'[0-9]'))){
                             return 'password should contains at least one uppercase and number';

                           }
                           return null;
                         },
                         textEditingController: passwordTextController,
                         hintText: 'password',
                         prefixIcon: Ionicons.lock_closed_outline,
                       ),
                       const SizedBox(height: 10,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           InkWell(
                             onTap: () {
                             },
                             child: const Text('reset_password',),
                           ),
                         ],
                       ),
                       const SizedBox(height: 30,),
                       GlobalBtn(
                         title: 'login',
                         onTap: () async{
                           await BlocProvider.of<AuthCubit>(context).
                           login(email: emailTextController.text, password: passwordTextController.text.trim());
                         },
                       ),
                       const SizedBox(height: 40,),

                       Align(
                           alignment: Alignment.center,
                           child: Text('continue_with',style: TextStyles.style20.copyWith(color: AppColors.mainColor),)),
                       const SizedBox(height: 20,),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children:  [
                           CustomSocialBtn(
                             logo: Ionicons.logo_facebook,
                             onTap: ()async {
                               await BlocProvider.of<AuthCubit>(context).
                               facebookSingIn();
                             },

                           ),
                           CustomSocialBtn(
                             logo: Ionicons.logo_google,
                             onTap: () async{
                               await BlocProvider.of<AuthCubit>(context).
                               googleSingIn();
                             },

                           )
                         ],
                       ),
                       const SizedBox(height: 30,),
                       const ScreenSwitch(
                         description: "don't_have_account",
                         btnTitle: 'sign_up', routeName: AppRoutes.signup,
                       ),
                     ],
                   ),
                 ),
               )
           ),
           state.isLoading? Container(
             height: double.infinity,
             width: double.infinity,
             color: Colors.black12,
             alignment: Alignment.center,
             child: SizedBox(
               height: 100,
               width: 100,
               child: Image.asset(
                 'assets/images/loading.gif',

               ),
             ),
           ):const SizedBox(),
         ],
       );
      },
);
  }
}


