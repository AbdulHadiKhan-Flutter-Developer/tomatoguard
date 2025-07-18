// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tomato_guard/model/user_data_model.dart';
import 'package:tomato_guard/screens/home_screen.dart';
import 'package:tomato_guard/screens/user_profile_screen.dart';
import 'package:tomato_guard/utils/app_constant.dart';
import 'package:tomato_guard/utils/get_upload_function.dart';
import 'package:tomato_guard/widgets/bottom_button_widget.dart';
import 'package:tomato_guard/widgets/dignose_widget.dart';

class DiagnoseListScreen extends StatefulWidget {
  @override
  State<DiagnoseListScreen> createState() => _DiagnoseListScreenState();
}

class _DiagnoseListScreenState extends State<DiagnoseListScreen> {
  List<UserDataModel> data = [];

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  void loaddata() async {
    var userdata = await GetUploadFunction().fetchdata();

    setState(() {
      data = userdata;
    });
  }

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.background,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAll(HomeScreen());
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppConstant.container,
                    child: Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppConstant.heading,
                        size: 18,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 75),
                Text(
                  'Diagnose List',
                  style: TextStyle(
                    fontFamily: AppConstant.boldfontheading,
                    color: AppConstant.text,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 555,
                color: AppConstant.container,
                child: data.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 60,
                              color: AppConstant.heading,
                            ),
                            SizedBox(height: 10),
                            Text(
                              ' Scan your Tomato Plant and press save button \n               Internet Connection Not Found.',
                              style: TextStyle(
                                fontFamily: AppConstant.boldfontheading,
                                fontSize: 12,
                                color: AppConstant.heading,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final disease = data[index];
                          return DignoseWidget(
                            result: disease.title,
                            imageurl: disease.image,
                            date: disease.data,
                            id: disease.id,
                            refresh: loaddata,
                          );
                        },
                      ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(35),
              child: Container(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    BottomButtonWidget(
                      isselected: index == 0,
                      ontap: () {
                        Get.off(HomeScreen());
                        setState(() {
                          index = 0;
                        });
                      },
                      selectedcolor: AppConstant.heading,
                      unselectedcolor: AppConstant.unhover,
                      icon: Icons.home_outlined,
                    ),
                    SizedBox(width: 30),
                    BottomButtonWidget(
                      isselected: index == 1,
                      ontap: () {
                        Get.to(DiagnoseListScreen());
                        setState(() {
                          index = 1;
                        });
                      },
                      selectedcolor: AppConstant.heading,
                      unselectedcolor: AppConstant.unhover,
                      icon: Icons.book_outlined,
                    ),
                    SizedBox(width: 30),
                    BottomButtonWidget(
                      isselected: index == 2,
                      ontap: () {
                        Get.to(UserProfileScreen());
                        setState(() {
                          index = 2;
                        });
                      },
                      selectedcolor: AppConstant.heading,
                      unselectedcolor: AppConstant.unhover,
                      icon: Icons.person_outlined,
                    ),
                  ],
                ),
                height: 70,
                width: double.infinity,
                color: AppConstant.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
