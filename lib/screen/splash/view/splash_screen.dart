import 'dart:async';
import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/screen/user/controller/user_controller.dart';
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    bool check = FireAuthHelper.helper.checkUser();
    if (check) {
      profileController.getUserData();
    }

    Timer(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed(check ? 'home' : 'signIn');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(
        "https://wallpapers.com/images/hd/love-yourself-quotes-43ff3kbx1bcc7shf.jpg",
        fit: BoxFit.cover,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
      ),
    );
  }
}
