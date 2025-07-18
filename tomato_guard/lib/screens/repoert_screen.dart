import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:tomato_guard/screens/home_screen.dart';
import 'package:tomato_guard/utils/app_constant.dart';
import 'package:tomato_guard/utils/get_upload_function.dart';
import 'package:tomato_guard/utils/label_descriptions.dart';
import 'package:tomato_guard/utils/label_traetments.dart';

class RepoertScreen extends StatelessWidget {
  final String result;
  final double accuracy;
  final File image;
  final VoidCallback regenerate;

  const RepoertScreen({
    super.key,
    required this.result,
    required this.accuracy,
    required this.image,
    required this.regenerate,
  });

  @override
  Widget build(BuildContext context) {
    GetUploadFunction getUploadFunction = GetUploadFunction();
    final description =
        labelDescriptions[result.trim()] ?? 'No description available.';
    final treatment =
        labelTreatments[result.trim()] ?? 'No treatment information available.';

    return Scaffold(
      backgroundColor: AppConstant.background,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.offAll(HomeScreen()),
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
                SizedBox(width: 65),
                Text(
                  'Tomato Diagnosis',
                  style: TextStyle(
                    fontFamily: AppConstant.boldfontheading,
                    color: AppConstant.text,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25, right: 25),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Report',
                          style: TextStyle(
                            fontFamily: AppConstant.boldfontheading,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 150,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Text(
                              'Disease Name: ',
                              style: TextStyle(
                                fontFamily: AppConstant.boldfontheading,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 3),
                                child: Text(
                                  result,
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: AppConstant.boldfontheading,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Text(
                              'Accuracy Rate: ',
                              style: TextStyle(
                                fontFamily: AppConstant.boldfontheading,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              '${accuracy.toStringAsFixed(2)}%',
                              style: TextStyle(
                                fontFamily: AppConstant.boldfontheading,
                                fontSize: 11,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Know about disease: ',
                          style: TextStyle(
                            fontFamily: AppConstant.boldfontheading,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,

                            color: AppConstant.heading,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontFamily: AppConstant.boldfontheading,

                            fontSize: 9,

                            color: AppConstant.text,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Treatment about disease:',
                          style: TextStyle(
                            fontFamily: AppConstant.boldfontheading,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,

                            color: AppConstant.heading,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          treatment,
                          style: TextStyle(
                            fontFamily: AppConstant.boldfontheading,

                            fontSize: 9,

                            color: AppConstant.text,
                          ),
                        ),
                      ),

                      Center(
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/stamp.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                height: 600,
                width: double.infinity,
                color: AppConstant.container,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: AppConstant.container,
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          regenerate();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppConstant.heading,
                              ),
                            ),
                            height: 40,
                            width: 125,
                            child: Center(
                              child: Text(
                                'Re-Generate',
                                style: TextStyle(
                                  color: AppConstant.heading,
                                  fontFamily: AppConstant.boldfontheading,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () async {
                          EasyLoading.show(status: 'Saving...');

                          // Wait for upload to complete
                          bool uploadSuccess = await getUploadFunction
                              .uploaddata(image, result);

                          if (uploadSuccess) {
                            await getUploadFunction
                                .fetchdata(); // wait for data refresh
                            EasyLoading.showSuccess('Saved');
                          } else {
                            EasyLoading.showError('Upload Failed');
                          }

                          EasyLoading.dismiss(); // you can remove this if using showSuccess/showError
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            height: 40,
                            width: 125,
                            color: AppConstant.heading,
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: AppConstant.container,
                                  fontFamily: AppConstant.boldfontheading,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
