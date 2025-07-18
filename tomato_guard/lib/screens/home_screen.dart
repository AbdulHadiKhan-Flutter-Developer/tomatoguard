// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomato_guard/model/user_data_model.dart';
import 'package:tomato_guard/screens/diagnose_list_screen.dart';
import 'package:tomato_guard/screens/repoert_screen.dart';
import 'package:tomato_guard/screens/user_profile_screen.dart';
import 'package:tomato_guard/utils/api.dart';
import 'package:tomato_guard/utils/get_upload_function.dart';
import 'package:tomato_guard/widgets/app_drawer.dart';
import 'package:tomato_guard/widgets/bottom_button_widget.dart';
import 'package:tomato_guard/widgets/carousal_slider.dart';
import 'package:tomato_guard/utils/app_constant.dart';
import 'package:tomato_guard/widgets/dignose_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? Username;
  String? imageurl;
  final GetUploadFunction getUploadFunction = GetUploadFunction();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  void loadprofiledata() async {
    var profile = await getUploadFunction.fetchprofiledata(uid);
    if (profile != null) {
      setState(() {
        Username = profile.username;
        imageurl = profile.userimage;
      });
    }
  }

  List<UserDataModel> disease = [];
  void loaddisease() async {
    final data = await GetUploadFunction().fetchdata();
    final Api api = Api();
    setState(() {
      disease = data;
    });
  }

  File? imagefile;
  String result = '';
  double accuracy = 0.0;

  @override
  void initState() {
    loadmodelmethod();
    loaddisease();
    loadprofiledata();
    super.initState();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  void loadmodelmethod() async {
    String? res = await Tflite.loadModel(
      model: 'assets/model/tomato_model.tflite',
      labels: 'assets/model/labels.txt',
      useGpuDelegate: false,
      numThreads: 1,
      isAsset: true,
    );
  }

  void Pickimagegallery() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;
    var imagepath = File(image.path);
    setState(() {
      imagefile = imagepath;
    });

    var recognition = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );

    if (recognition == null) return;

    setState(() {
      result = (recognition[0]['label'].toString());
      accuracy = (recognition[0]['confidence'] * 100);
    });
    Get.offAll(
      RepoertScreen(
        result: result,
        accuracy: accuracy,
        image: imagepath,
        regenerate: Pickimagegallery,
      ),
    );
  }

  void Pickimagecamera() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) return;

    var imagepath = File(image.path);

    setState(() {
      imagefile = imagepath;
    });

    var recognition = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );

    if (recognition == null) return;

    setState(() {
      result = (recognition[0]['label'].toString());
      accuracy = (recognition[0]['confidence'] * 100);
    });
    Get.offAll(
      RepoertScreen(
        result: result,
        accuracy: accuracy,
        image: imagepath,
        regenerate: Pickimagecamera,
      ),
    );
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    if (Username == null && imageurl == null) {
      return Text('');
    }
    return Scaffold(
      backgroundColor: AppConstant.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.heading),
        backgroundColor: AppConstant.background,

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(bottom: 7.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        Username!,
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: AppConstant.boldfontheading,
                          fontWeight: FontWeight.bold,
                          color: AppConstant.heading,
                        ),
                      ),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: AppConstant.fontheading,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.all(2), // thickness of the border
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // to match the circular ClipRRect
                    border: Border.all(
                      color:
                          Colors.black, // change to your desired border color
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              (imageurl != null && imageurl!.isNotEmpty
                                      ? NetworkImage(
                                          '${api.profileurl}$imageurl',
                                        )
                                      : const NetworkImage(
                                          'https://i.pinimg.com/736x/84/64/82/8464826d795c3a32fff669b37aba806d.jpg',
                                        ))
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5),

            CarousalSlider(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(15),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(2),
                              child: Container(
                                child: Center(
                                  child: Container(
                                    child: Image.asset(
                                      'assets/images/scan.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                height: 30,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppConstant.heading,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Know Tomato Disease With Ai Powered Tomato Guard',
                                  style: TextStyle(
                                    fontFamily: AppConstant.boldfontheading,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9,
                                  ),
                                ),
                                Text(
                                  'Detect Tomato Leaf Diseases Using CNN-Based Deep Learning.',
                                  style: TextStyle(
                                    fontFamily: AppConstant.fontheading,
                                    fontSize: 7,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(4),
                            child: GestureDetector(
                              onTap: () {
                                bottomscansheet(context);
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Scan Now',
                                    style: TextStyle(
                                      fontFamily: AppConstant.boldfontheading,
                                      color: AppConstant.heading,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                height: 30,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppConstant.heading,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  height: 100,
                  width: double.infinity,
                  color: AppConstant.container,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(15),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(15),
                child: Container(
                  child: Stack(
                    children: [
                      Positioned(
                        top: -5,
                        left: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(5),
                                child: Container(
                                  height: 10,
                                  width: 70,
                                  color: AppConstant.container,
                                ),
                              ),
                            ),
                            height: 20,
                            width: 80,
                            color: AppConstant.background,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        left: 5,
                        child: Container(
                          height: 259,
                          width: 320,
                          color: AppConstant.container,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Recent Diagnose',
                                      style: TextStyle(
                                        fontFamily: AppConstant.boldfontheading,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          Get.offAll(DiagnoseListScreen()),
                                      child: Text(
                                        'See All',
                                        style: TextStyle(
                                          fontFamily: AppConstant.fontheading,
                                          fontWeight: FontWeight.bold,
                                          color: AppConstant.heading,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: disease.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                fontFamily:
                                                    AppConstant.boldfontheading,
                                                fontSize: 12,
                                                color: AppConstant.heading,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          child: ListView.builder(
                                            itemCount: disease.length,
                                            itemBuilder: (context, index) {
                                              final data = disease[index];
                                              return DignoseWidget(
                                                result: data.title,
                                                imageurl: data.image,
                                                date: data.data,
                                                id: data.id,
                                                refresh: loaddisease,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  height: 280,
                  width: double.infinity,
                  color: AppConstant.container,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(35),
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      BottomButtonWidget(
                        isselected: index == 0,
                        ontap: () {
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

  void bottomscansheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 90, left: 260),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              height: 200,
              width: 60,
              color: AppConstant.text,
              child: Column(
                children: [
                  SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      Pickimagecamera();
                      Get.offAll(
                        RepoertScreen(
                          result: result,
                          accuracy: accuracy,
                          image: imagefile!,
                          regenerate: () => bottomscansheet(context),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.camera_outlined,
                      color: AppConstant.container,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Pickimagegallery();
                      Get.offAll(
                        RepoertScreen(
                          result: result,
                          accuracy: accuracy,
                          image: imagefile!,
                          regenerate: () => bottomscansheet(context),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.image_outlined,
                      color: AppConstant.heading,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(height: 2, width: 30, color: AppConstant.container),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Get.offAll(HomeScreen()),
                    child: Icon(Icons.cancel, color: Colors.red, size: 40),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
