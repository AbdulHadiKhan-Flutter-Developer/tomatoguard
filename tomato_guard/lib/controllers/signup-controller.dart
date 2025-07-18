// ignore_for_file: unused_field, body_might_complete_normally_nullable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

import 'package:tomato_guard/model/user_auth_model.dart';

class SignupController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //password visibility...
  var isPasswordVisible = false.obs;

  // SignUp Method...

  Future<UserCredential?> signupMethod(
    String userName,
    String email,
    String password,
  ) async {
    try {
      EasyLoading.show(status: 'Please Wait');
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserAuthModel userAuthModel = UserAuthModel(
        uId: userCredential.user!.uid,
        username: userName,
        email: email,
      );

      _firebaseFirestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set(userAuthModel.tomap());
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      EasyLoading.dismiss();
    }
  }
}
