import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moda_store/featured/auth/data/models/admin.dart';
import 'package:moda_store/featured/auth/presentation/views/widgets/password_form_field.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/text_styles.dart';
import '../../../../widgets/alerts.dart';
import 'widgets/custom_global_btn.dart';
import 'widgets/custom_input_field.dart';
import 'widgets/screen_switch.dart';
import '../view_models/auth_cubit/auth_cubit.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController emailTextController ;
  late TextEditingController usernameTextController;
  late TextEditingController phoneTextController ;
  late TextEditingController passwordTextController ;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
     emailTextController = TextEditingController();
     usernameTextController = TextEditingController();
     phoneTextController = TextEditingController();
     passwordTextController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
      emailTextController.dispose();
      usernameTextController.dispose();
      phoneTextController.dispose();
      passwordTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (ctx, state) {
      if(state is AuthLoading){
      }else if(state is AuthSuccess){
        Navigator.pushReplacementNamed(context, AppRoutes.main);
        customToast(msg: 'Success', color: AppColors.mainColor);

      }else if(state is AuthFailed){
        customToast(msg: state.errMsg, color: Colors.red);

      }
  },
      builder: (ctx,state){
    return Stack(
      children: [
        Scaffold(
            body:Form(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.08,),
                  const Align(
                      alignment: Alignment.center,
                      child: Text('welcome',style: TextStyles.style24,)),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10,bottom: 30),
                    child: Text('welcome_sub',textAlign: TextAlign.center,style: TextStyles.style20.copyWith(color: AppColors.mainColor),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                  CustomInputField(
                    validator: (value){
                      if(value!.isEmpty||value.length<3){
                        return 'Please use a valid username';
                      }
                      return null;
                    },
                    textEditingController: usernameTextController,
                    hintText: 'username',
                    prefixIcon: Ionicons.person_outline,
                  ),

                  CustomInputField(
                    validator: (value){
                      if(!value!.contains('@')||value.isEmpty||value.length<4){
                        return 'Please use a valid email';
                      }
                      return null;
                    },
                    textEditingController:  emailTextController,
                    hintText: 'email',
                    prefixIcon: Ionicons.mail_outline,
                  ),
                  CustomInputField(
                    validator: (value){
                      if(value!.length<10){
                        return 'Try to use a valid phone number';
                      }
                      return null;
                    },

                    textEditingController:  phoneTextController,
                    hintText: 'phone',
                    prefixIcon: Ionicons.call_outline,
                    isNumber: true,
                  ),

                  PasswordField(
                    validator: (value){
                      if(value!.length<4){
                        return 'password must be more than 4 chr';
                      }else if(value.contains(RegExp(r'[A-Z]'))&&value.contains(RegExp(r'[0-9]'))){
                        return 'password should contains at least one uppercase and number';

                      }
                      return null;
                    },
                    textEditingController: passwordTextController,
                    hintText: 'password',
                    prefixIcon: Ionicons.lock_closed_outline,
                  ),
                  const SizedBox(height: 10,),
                  GlobalBtn(
                    title: 'sign_up',
                    onTap: ()  async{
                      Admin admin = Admin(username: usernameTextController.text,
                          email: emailTextController.text.trim(),
                          phone: phoneTextController.text.trim(),
                          address: '',
                          image: ''
                      );
                      await BlocProvider.of<AuthCubit>(context).
                      signup(admin: admin, password: passwordTextController.text.trim());
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.15,),

                  const ScreenSwitch(
                    description: "already_have_account",
                    btnTitle: 'login', routeName: AppRoutes.login,

                  ),
                ],
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
            child:Image.asset(
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
