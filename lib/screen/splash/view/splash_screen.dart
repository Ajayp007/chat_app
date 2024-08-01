import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
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
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    bool check = FireAuthHelper.helper.checkUser();
    super.initState();
    Timer(
      const Duration(seconds: 12),
      () {
        Get.offAllNamed(check ? 'home' : 'signIn');
      },
    );
    controller.getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "https://wallpapers.com/images/hd/love-yourself-quotes-43ff3kbx1bcc7shf.jpg",
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      "Chat App",
                      textStyle: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TyperAnimatedText(
                      "Quote means to repeat the exact words of a speaker or an author. A quote is also a passage or statement repeated in this way. Quote means to cite something as a form of proof.",
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Color(0xffF6C6B2),
                      ),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
