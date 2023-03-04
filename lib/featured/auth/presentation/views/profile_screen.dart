import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/config/app_colors.dart';
import 'package:moda_store/config/constans.dart';
import 'package:moda_store/config/text_styles.dart';
import 'package:moda_store/featured/auth/presentation/view_models/admin_cubit/admin_cubit.dart';
import 'package:moda_store/featured/auth/presentation/views/widgets/upload_image.dart';
import 'package:moda_store/services/locator.dart';
import 'package:image_picker/image_picker.dart';
import 'widgets/custom_list_tile.dart';
import 'widgets/loading_profile.dart';
import 'widgets/settings_list_tile.dart';
import 'widgets/update_field_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late File _image ;

  @override
  void initState() {
    context.read<AdminCubit>().fetchAdminData(id:getIt.get<GetStorage>().read('id'),showLoading: true );

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
   listener: (context, state){

   },
  builder: (context, state) {
    if(state is AdminLoading){
      return const LoadingProfile  ();

    }else if(state is AdminSuccess){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(

            children: [
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: AppColors.mainColor,
                      child:state.admin.image.isEmpty?const CircleAvatar(
                        radius: 52,
                        backgroundImage: AssetImage('assets/images/user.png'),
                      ): CircleAvatar(
                        backgroundColor: AppColors.secondaryColor,
                        radius: 52,
                        backgroundImage: NetworkImage(state.admin.image),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: InkWell(
                        onTap: (){
                          imageAlertDialog(context:context,
                          openCamera: (){_pickImageFromCamera();},
                            openGallery: (){_pickImageFromGallery();}
                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.mainColor
                            ),
                            child:const Icon(Ionicons.camera_outline,color: AppColors.secondaryColor,size: 15,)),
                      ),

                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(state.admin.username,style: TextStyles.style24.copyWith(color: AppColors.mainColor),)),
              const SizedBox(height: 20,),

              const Text('User Info',style: TextStyles.style24,),

              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                color: const Color(0xFFFAF7F0),
                child:Column(
                  children:  [
                    CustomListTile(
                      title: 'Email',
                      subtitle: Text(state.admin.email),
                      leading: Ionicons.mail_outline,
                    ) ,
                    CustomListTile(
                      title: 'Phone',
                      subtitle: Text(state.admin.phone),
                      leading: Ionicons.call_outline,
                      trailing: Icons.edit_outlined,
                      onTap: (){
                        updateFieldAlert(context: context, title: 'Update Phone number', hint: 'phone number',  fieldName: 'phone');
                      },
                    ),
                     CustomListTile(
                      title: 'Location',
                      subtitle: Text('Setif,raselma,12'),
                      trailing: Icons.edit_location_alt_outlined,
                      onTap: ()async{
                       await context.read<AdminCubit>().getCurrentLocation();

                      },
                      leading: Ionicons.location_outline,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Text('Settings',style: TextStyles.style24,),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children:  [
                    const SettingListTile(
                      title: 'Change Language',
                      trailing:Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('EN'),
                      ),
                    ),
                    SettingListTile(
                      title: 'Edit Info',
                      trailing:IconButton(onPressed: (){

                      }, icon: const Icon(Icons.edit_outlined),
                      ),
                    ),
                    SettingListTile(
                      title: 'logout',
                      trailing:IconButton(onPressed: (){

                      }, icon: const Icon(Ionicons.log_out_outline),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }else if(state is AdminFailed){
      return Scaffold(
        body: Center(
          child: Text(state.toString()),
        ),
      );
    }
    return const Scaffold(

    );
  },
);
  }
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      Navigator.pop(context);
       context.read<AdminCubit>().uploadImage(_image);

    });


  }
  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile!.path);
      Navigator.pop(context);
       context.read<AdminCubit>().uploadImage(_image);

    });


  }
}



