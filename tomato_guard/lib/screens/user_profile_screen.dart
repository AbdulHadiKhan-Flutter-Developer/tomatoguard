// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomato_guard/screens/diagnose_list_screen.dart';
import 'package:tomato_guard/screens/home_screen.dart';
import 'package:tomato_guard/utils/api.dart';
import 'package:tomato_guard/utils/app_constant.dart';
import 'package:tomato_guard/utils/get_upload_function.dart';
import 'package:tomato_guard/widgets/bottom_button_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final Api api = Api();
  final GetUploadFunction getUploadFunction = GetUploadFunction();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  String? imageurl;

  File? imagefile;

  Future<void> loaddata() async {
    final profiledata = await getUploadFunction.fetchprofiledata(uid);
    if (profiledata != null) {
      setState(() {
        nameController.text = profiledata.username;
        emailController.text = profiledata.useremail;
        experienceController.text = profiledata.userfarmingexperience;
        imageurl = profiledata.userimage;
      });
    }
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  void pickimagegallery() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      print('No image selected.');
      return;
    }

    var imagepath = File(image.path);

    print('Image URL: ${imagepath.path}'); // ✅ Print before setState

    setState(() {
      imagefile = imagepath;
    });
  }

  int index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              child: Container(
                height: 250,
                width: double.infinity,
                color: AppConstant.heading,
                child: Stack(
                  children: [
                    Positioned(
                      top: 50,
                      left: 20,
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
                                padding: const EdgeInsets.only(
                                  left: 6,
                                  bottom: 1,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                  color: AppConstant.heading,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontFamily: AppConstant.boldfontheading,
                              color: AppConstant.container,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 110,
                      left: 70,
                      child: Text(
                        'Setup your Profile for better experience.',
                        style: TextStyle(
                          fontFamily: AppConstant.boldfontheading,
                          color: AppConstant.container,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 145,
                      left: 140,
                      child: Container(
                        padding: EdgeInsets.all(4), // border thickness
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white, // outer white border
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: imagefile != null
                              ? FileImage(imagefile!)
                              : (imageurl != null && imageurl!.isNotEmpty
                                        ? NetworkImage(
                                            '${api.profileurl}$imageurl',
                                          )
                                        : const NetworkImage(
                                            'https://i.pinimg.com/736x/84/64/82/8464826d795c3a32fff669b37aba806d.jpg',
                                          ))
                                    as ImageProvider,
                          backgroundColor:
                              Colors.grey[200], // optional background color
                        ),
                      ),
                    ),
                    Positioned(
                      top: 145,
                      left: 190,
                      child: GestureDetector(
                        onTap: () {
                          pickimagegallery();
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color.fromARGB(
                            76,
                            139,
                            104,
                            104,
                          ),
                          radius: 14,
                          child: Icon(
                            Icons.photo_library,
                            size: 18,
                            color: AppConstant.container,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 238,
                      left: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 20,
                          width: 80,
                          color: AppConstant.background,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 242,
                      left: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 8,
                          width: 60,
                          color: AppConstant.heading,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Add your Personal Detail\'s',
                        style: TextStyle(
                          fontFamily: AppConstant.boldfontheading,
                          fontWeight: FontWeight.bold,
                          color: AppConstant.heading,
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 15,
                        ),
                        child: TextFormField(
                          controller: nameController,
                          cursorColor: AppConstant.heading,
                          style: TextStyle(
                            color: AppConstant.text,
                            fontFamily: AppConstant.fontheading,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppConstant.heading,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppConstant.heading,
                              ),
                            ),
                            hintText: 'User Name',
                            hintStyle: TextStyle(
                              fontFamily: AppConstant.fontheading,
                              fontSize: 13,
                              color: AppConstant.text,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 15,
                        ),
                        child: TextFormField(
                          controller: emailController,
                          cursorColor: AppConstant.heading,
                          style: TextStyle(
                            color: AppConstant.text,
                            fontFamily: AppConstant.fontheading,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppConstant.heading,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppConstant.heading,
                              ),
                            ),
                            hintText: 'E-Mail',
                            hintStyle: TextStyle(
                              fontFamily: AppConstant.fontheading,
                              fontSize: 13,
                              color: AppConstant.text,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 15,
                        ),
                        child: TextFormField(
                          controller: experienceController,
                          cursorColor: AppConstant.heading,
                          style: TextStyle(
                            color: AppConstant.text,
                            fontFamily: AppConstant.fontheading,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppConstant.heading,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppConstant.heading,
                              ),
                            ),
                            hintText: 'Farming Experience',
                            hintStyle: TextStyle(
                              fontFamily: AppConstant.fontheading,
                              fontSize: 13,
                              color: AppConstant.text,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: GestureDetector(
                          onTap: () {
                            String name = nameController.text.trim();
                            String email = emailController.text.trim();
                            String experi = experienceController.text.trim();

                            getUploadFunction.uploadorsaveprofile(
                              uid,
                              name,
                              email,
                              experi,
                              imagefile,
                            );
                            print('Image URL: $imageurl');
                          },

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              color: AppConstant.heading,
                              child: Center(
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                    fontFamily: AppConstant.boldfontheading,
                                    color: AppConstant.container,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  height: 400,
                  width: double.infinity,
                  color: AppConstant.container,
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
      ),
    );
  }
}
