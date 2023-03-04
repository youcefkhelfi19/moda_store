import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/text_styles.dart';
import 'custom_list_tile.dart';
import 'custom_shimmer.dart';
import 'settings_list_tile.dart';

class LoadingProfile extends StatelessWidget {
  const LoadingProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: const CircleAvatar(
                      radius: 52,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mainColor
                        ),
                        child:Icon(Ionicons.camera_outline,color: AppColors.secondaryColor,size: 15,)),

                  )
                ],
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child:CustomShimmer(width: 200, height:30 ) ,
            ),
            const SizedBox(height: 20,),

            const Text('User Info',style: TextStyles.style24,),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              color: const Color(0xFFFAF7F0),
              child:Column(
                children:  const [
                  CustomListTile(
                    title: 'Email',
                    subtitle: CustomShimmer(width: 200, height:20 ),
                    leading: Ionicons.mail_outline,
                  ) ,
                  CustomListTile(
                    title: 'Phone',
                    subtitle: CustomShimmer(width: 200, height:20 ),
                    leading: Ionicons.call_outline,
                    trailing: Icons.edit_outlined,
                  ),
                  CustomListTile(
                    title: 'Location',
                    subtitle: CustomShimmer(width: 200, height:20 ),
                    leading: Ionicons.location_outline,
                    trailing: Icons.edit_location_alt_outlined,

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
  }
}
