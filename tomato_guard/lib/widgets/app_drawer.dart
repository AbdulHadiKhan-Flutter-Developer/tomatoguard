import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:tomato_guard/screens/about_me_screen.dart';
import 'package:tomato_guard/screens/auth/signin_screen.dart';
import 'package:tomato_guard/screens/diagnose_list_screen.dart';
import 'package:tomato_guard/screens/user_profile_screen.dart';
import 'package:tomato_guard/utils/app_constant.dart';
import 'package:tomato_guard/widgets/app_drawer_button_widget.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppConstant.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30),
            //padding: EdgeInsetsGeometry.only(left: 20),
            child: Text(
              'Tomato Guard',
              style: TextStyle(
                fontFamily: AppConstant.boldfontheading,
                fontWeight: FontWeight.bold,
                color: AppConstant.heading,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 30),
            child: Row(
              children: [
                Text(
                  '@ Ai Powered Solution',
                  style: TextStyle(
                    fontFamily: AppConstant.boldfontheading,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
                SizedBox(width: 43),
                Text(
                  'Version 1.0.1',
                  style: TextStyle(
                    fontFamily: AppConstant.boldfontheading,
                    fontWeight: FontWeight.bold,
                    color: AppConstant.text,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(indent: 15, endIndent: 15, color: AppConstant.heading),
          SizedBox(height: 30),
          AppDrawerButtonWidget(
            text: 'Home',
            selectedcolor: AppConstant.heading,
            unselectedcolor: AppConstant.text,
            iconselectedcolor: AppConstant.text,
            isselected: selectedindex == 0,
            ontap: () {
              setState(() {
                selectedindex = 0;
              });
            },
            icon: Icons.home_outlined,
          ),
          SizedBox(height: 25),
          AppDrawerButtonWidget(
            text: 'Diagnose List',
            selectedcolor: AppConstant.heading,
            unselectedcolor: AppConstant.text,
            iconselectedcolor: AppConstant.text,
            isselected: selectedindex == 1,
            ontap: () {
              Get.offAll(DiagnoseListScreen());
              setState(() {
                selectedindex = 1;
              });
            },
            icon: Icons.book_outlined,
          ),
          SizedBox(height: 25),
          AppDrawerButtonWidget(
            text: 'Profile',
            selectedcolor: AppConstant.heading,
            unselectedcolor: AppConstant.text,
            iconselectedcolor: AppConstant.text,
            isselected: selectedindex == 2,
            ontap: () {
              Get.offAll(UserProfileScreen());
              setState(() {
                selectedindex = 2;
              });
            },
            icon: Icons.person_outline,
          ),
          SizedBox(height: 25),

          AppDrawerButtonWidget(
            text: 'About Me',
            selectedcolor: AppConstant.heading,
            unselectedcolor: AppConstant.text,
            iconselectedcolor: AppConstant.text,
            isselected: selectedindex == 4,
            ontap: () {
              setState(() {
                selectedindex = 4;
                Get.offAll(AboutMeScreen());
              });
            },
            icon: Icons.info_outline,
          ),
          SizedBox(height: 300),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(SigninScreen());
              },
              child: Row(
                children: [
                  Icon(Icons.logout_outlined, color: AppConstant.heading),
                  SizedBox(width: 4),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: AppConstant.boldfontheading,
                      color: AppConstant.heading,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
