import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomato_guard/controllers/signup-controller.dart';
import 'package:tomato_guard/screens/auth/signin_screen.dart';
import 'package:tomato_guard/utils/app_constant.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupController signupController = Get.put(SignupController());
  TextEditingController usernameController = TextEditingController();
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
                  'Create a new account',
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
                  ' Fill in your detail\'s to create a new accout and \n       start diagnose to your tomato plants!',
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
                            controller: usernameController,
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
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontFamily: AppConstant.fontheading,
                                  color: AppConstant.text,
                                  fontSize: 9,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.offAll(SigninScreen()),
                                child: Text(
                                  'Signin',
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
                        ),

                        Padding(
                          padding: const EdgeInsets.all(50),
                          child: GestureDetector(
                            onTap: () async {
                              String name = usernameController.text.trim();
                              String email = useremailController.text.trim();
                              String password = userpasswordController.text
                                  .trim();
                              if (name.isEmpty ||
                                  email.isEmpty ||
                                  password.isEmpty) {
                              } else {
                                UserCredential? userCredential =
                                    await signupController.signupMethod(
                                      name,
                                      email,
                                      password,
                                    );
                                if (userCredential != null) {
                                  FirebaseAuth.instance.signOut();
                                  Get.offAll(() => SigninScreen());
                                }
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
                                    'SignUp',
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
