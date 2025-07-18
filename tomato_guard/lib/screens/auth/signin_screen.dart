// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tomato_guard/controllers/signin_controller.dart';
import 'package:tomato_guard/screens/auth/signup_screen.dart';
import 'package:tomato_guard/screens/home_screen.dart';
import 'package:tomato_guard/utils/app_constant.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  SigninController signinController = Get.put(SigninController());
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.background,
      body: SingleChildScrollView(
        child: Container(
          color: AppConstant.background,
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontFamily: AppConstant.boldfontheading,
                    fontWeight: FontWeight.bold,
                    color: AppConstant.heading,
                    fontSize: 16,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '  Login with you\'r data that you entered \n             during you\'r registration.',
                  style: TextStyle(
                    fontFamily: AppConstant.fontheading,

                    color: AppConstant.text,
                    fontSize: 9,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: AppConstant.container,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 15,
                          ),
                          child: TextFormField(
                            controller: useremailController,
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
                            controller: userpasswordController,
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
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontFamily: AppConstant.fontheading,
                                fontSize: 13,
                                color: AppConstant.text,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 230),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontFamily: AppConstant.boldfontheading,
                              color: AppConstant.heading,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(50),
                          child: GestureDetector(
                            onTap: () async {
                              String email = useremailController.text.trim();
                              String password = userpasswordController.text
                                  .trim();

                              if (email.isEmpty || password.isEmpty) {
                              } else {
                                UserCredential? userCredential =
                                    await signinController.signinMethod(
                                      email,
                                      password,
                                    );
                                Get.offAll(HomeScreen());
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                color: AppConstant.heading,
                                child: Center(
                                  child: Text(
                                    'Signin',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'don\'t have an account?',
                              style: TextStyle(
                                fontFamily: AppConstant.fontheading,
                                color: AppConstant.text,
                                fontSize: 9,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.offAll(SignupScreen()),
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                  fontFamily: AppConstant.boldfontheading,
                                  color: AppConstant.heading,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
