import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:tomato_guard/screens/home_screen.dart';
import 'package:tomato_guard/utils/app_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.background,

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(top: 40, left: 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.offAll(HomeScreen()),
                      child: CircleAvatar(
                        backgroundColor: AppConstant.container,
                        radius: 16,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsetsGeometry.only(left: 7),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                              color: AppConstant.heading,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 90),
                    Text(
                      'About Me',
                      style: TextStyle(
                        fontFamily: AppConstant.fontheading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                '👨‍💻 Abdul Hadi Khan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppConstant.boldfontheading,
                  color: AppConstant.heading,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '🎓 Computer Systems Engineer\n💙 Flutter Developer (1+ Years Experience)',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppConstant.boldfontheading,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '📱 About this App',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppConstant.boldfontheading,
                  color: AppConstant.heading,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'This mobile application is developed as my Final Year Project (FYP). It uses AI-powered image recognition to detect diseases in tomato plant leaves using a Convolutional Neural Network (CNN) model.',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppConstant.boldfontheading,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '💡 Technologies Used:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppConstant.boldfontheading,
                  color: AppConstant.heading,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '• Flutter\n• Python (for model training)\n• TensorFlow Lite (TFLite)\n• Firebase\n• CNN (Deep Learning)',
                style: TextStyle(
                  fontFamily: AppConstant.boldfontheading,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '🌐 Portfolio',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppConstant.boldfontheading,
                  color: AppConstant.heading,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(
                    'https://abdulhadikhan-flutter-developer.github.io/abdulhadikhan.github.io/',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    throw ('launch error: $url');
                  }
                },
                child: Text(
                  'Check out my work:\nhttps://abdulhadikhan-flutter-developer.github.io/abdulhadikhan.github.io/',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontFamily: AppConstant.boldfontheading,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Thank you for using Tomato Guard! 🍅',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstant.boldfontheading,
                    fontSize: 14,
                    color: Colors.grey[700],
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
